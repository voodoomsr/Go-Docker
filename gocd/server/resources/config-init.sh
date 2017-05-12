#!/usr/bin/env bash

# Config
CONFIG_FILE=/godata/config/.configured

mkdir -p /godata/db
mkdir -p /godata/config
mkdir -p /godata/artifacts

if [ ! -f $CONFIG_FILE ]; then
    echo Coping initial configuration...
    cp -vr /base-config/* /godata/config

    date > $CONFIG_FILE
fi

# GitHub
SSH_BASE_DIR=/godata/ssh-keys
SSH_CONFIG_FILE=$SSH_BASE_DIR/config
SSH_KEY_FILE=$SSH_BASE_DIR/github.com

if [ ! -f $SSH_KEY_FILE ] || [ ! -f ${SSH_KEY_FILE}.pub ]; then
    mkdir -p $SSH_BASE_DIR
    echo Generating GitHub SSH keys \(at `date`\)...

    echo "Host github.com"                       > $SSH_CONFIG_FILE
    echo "    User git"                         >> $SSH_CONFIG_FILE
    echo "    HostName github.com"              >> $SSH_CONFIG_FILE
    echo "    StrictHostKeyChecking no"         >> $SSH_CONFIG_FILE
    echo "    IdentityFile $SSH_KEY_FILE"       >> $SSH_CONFIG_FILE

    ssh-keygen -t rsa -f $SSH_KEY_FILE -P ''
fi
