#!/bin/bash

. ../.env

mkdir -p "$MACHINE"

qemu-img create -f qcow2 "$MACHINE/$QCOW2" 20G
