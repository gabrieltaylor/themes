#!/usr/bin/env bash
git add . && \
  git stash && \
  git checkout master && \
  git pull && \
  release_number=${1:-01} && \
  formatted_date=$(date +"%Y-%m-%d") && \
  git tag -a "$formatted_date-$release_number" -m "$formatted_date-$release_number" && \
  git push origin "$formatted_date-$release_number"
