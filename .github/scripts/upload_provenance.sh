#!/bin/bash

RELEASE_DRAFT_TAG=$(gh release list | awk '{ if ($2 == "Draft") print $1}')
