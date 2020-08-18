#!/bin/bash -e
###############################################################################
# (c) Copyright IBM Corporation 2019, 2020. All Rights Reserved.
# Note to U.S. Government Users Restricted Rights:
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
# Licensed Materials - Property of IBM
# 
# Copyright (c) 2020 Red Hat, Inc.
###############################################################################
export GO111MODULE=off

# Go tools

# Build tools

if ! which operator-sdk > /dev/null; then
    curr_dir="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
    echo ">>> Installing Operator SDK"
    set +e
    # cannot use 'set -e' because this command always fails after project has been cloned down for some reason
    set -e
    echo $curr_dir/../operator-sdk
    cd $curr_dir/../operator-sdk
    git checkout .
    
    echo ">>> >>> Running make tidy"
    go version
    GO111MODULE=on make tidy || echo 'make tidy failed, skipping'
    echo ">>> >>> Running make install"
    GO111MODULE=on make install
    echo ">>> Done installing Operator SDK"
    operator-sdk version
    cd $curr_dir
fi
