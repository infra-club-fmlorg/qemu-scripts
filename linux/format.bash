#!/bin/bash

. ../.env

mkdir -p ../"$NAME"
cd ../"$NAME" || exit

qemu-img create -f qcow2 "$QCOW2" 20G
