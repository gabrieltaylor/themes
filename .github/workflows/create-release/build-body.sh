#!/usr/bin/env bash

# Usage
#
# In the service's repo, run:
#
#   release-notes from-ref to-ref
#
# Example:
#
#   release-notes 2019-11-08-01 2019-11-25-01
#
# If you leave out to-ref, it defaults to `HEAD`.  If you also leave out
# from-ref, it defaults to the last tag.
#
# The output is a Markdown table with colums for the PR (with a link),
# a branch, and JIRA ticket with link (if available).
#
# If the branch name starts with an id for a JIRA ticket (e.g.,
# PLAT-123), then a link to the ticket is created.  Otherwise this
# column is blank.
#
# A link to the branch isn't valueable because they are usually
# deleted after merging.
#

from_tag=${1:-$(git tag | tail -n 1)}
to_tag=${2:-HEAD}

echo "## Changes"
echo ""
echo "### PRs"
git --no-pager log --merges --first-parent master --format='%s' ${from_tag}..${to_tag} | \
    gawk 'BEGIN { print "| PR | Branch | Ticket |" ;
                  print "| -- | ------ | ------ |" }
          {if (match($0,/(#[0-9]+).*CityBaseInc\/(([A-Z]+-[0-9]+)\S+)/,m))
            printf "| %s | %s | [%s](https://citybase.atlassian.net/browse/%s) |\n", m[1], m[2], m[3], m[3] }
          {if (match($0,/(#[0-9]+).*CityBaseInc\/([a-z]\S+)/,m))
            print "|", m[1], "|", m[2], "|", "|"}'

echo ""
echo "### Code Diff"
from_sha=$(git rev-parse ${from_tag}^{})
to_sha=$(git rev-parse ${to_tag}^{})
echo "https://github.com/${REPO}/compare/${from_sha}..${to_sha}"
