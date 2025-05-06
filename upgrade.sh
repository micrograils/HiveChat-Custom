#!/bin/bash

git submodule update --init --recursive
git add .
git commit -m "Update HiveChat submodule to track main branch"
git push
