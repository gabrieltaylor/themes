#!/usr/bin/env bash

# The output is a Markdown table with columns for the PR (with a link),
# a branch, and JIRA ticket with link (if available).
#
# If the branch name starts with an id for a JIRA ticket (e.g.,
# PLAT-123), then a link to the ticket is created.  Otherwise this
# column is blank.
#
# A link to the branch isn't valuable because they are usually
# deleted after merging.

from_tag=${FROM_TAG}
to_tag=${TAG##*/}

echo "## Changes"
echo ""
echo "### PRs"
git --no-pager log --merges --first-parent master --format='%s' ${from_tag}..${to_tag} | \
    gawk 'BEGIN { print "| PR | Branch | Ticket |" ;
                  print "| -- | ------ | ------ |" }
          {if (match($0,/(#[0-9]+).*\/(([A-Z]+-[0-9]+)\S+)/,m))
            printf "| %s | %s | [%s](https://citybase.atlassian.net/browse/%s) |\n", m[1], m[2], m[3], m[3] }
          {if (match($0,/(#[0-9]+).*\/([a-z]\S+)/,m))
            print "|", m[1], "|", m[2], "|", "|"}'

echo ""
echo "### Code Diff"
echo "https://github.com/${REPO}/compare/${from_tag}..${to_tag}"
