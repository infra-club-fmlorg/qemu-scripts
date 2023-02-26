#!/bin/bash

. ../.env

mkdir -p "$MACHINE"

qemu-system-"$ARCH" -vga std -smp $CPU -m "$MEMORY" -name "$NAME" \
	-drive file="$MACHINE/$QCOW2",if=virtio,format=qcow2 \
	-netdev user,id=mynet0,hostfwd=tcp::7722-:22,hostfwd=tcp::7780-:80 \
	-device e1000,netdev=mynet0
