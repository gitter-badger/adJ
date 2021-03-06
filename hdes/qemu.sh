#!/bin/sh
# Inicia maquina virtual para probar imagen ISO

. ./ver.sh

if (test "$ARQ" = "i386") then {
	cmd="qemu"
} else {
	cmd="qemu-system-x86_64"
} fi;
opq="-boot $qemuboot -cdrom AprendiendoDeJesus-$V$VESP-$ARQ.iso virtual.vdi"
if (test "$TEXTO" = "1") then {
	opq="$opq -nographic -curses -s"
	cmd="$cmd $opq"
} else {
	opq="$opq -s -serial file:/tmp/q -monitor stdio"
	cmd="sudo xterm -e \"$cmd $opq\""
} fi;
if (test ! -f virtual.vdi) then {
	qemu-img create -f raw virtual.vdi 15G
} fi;

echo $cmd;
eval $cmd;
