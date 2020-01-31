#!/usr/bin/env bash
git add . && \
  git stash && \
  git checkout master && \
  git pull && \
  formatted_date=$(date +"%Y-%m-%d")
  git tag -a "$formatted_date-11" -m "$formatted_date-11"
  git push origin "$formatted_date-11"
