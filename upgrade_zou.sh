#!/bin/sh

export LC_ALL=C.UTF-8
export LANG=C.UTF-8

zou upgrade-db
zou reset-search-index
