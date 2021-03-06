#!/bin/sh
#Evaluaci�n parcial de mensajes
#Dominio p�blico. 2009. vtamara@pasosdeJesus.org

. ../ver.sh

DLENG=$1
if (test "X$DLENG" = "X") then {
	DLENG=en;
} fi;

sed -e "s/\\\\/\\\\\\\\/g;s/\\\\n/\\\\\\\\n/g;s/\(\$[^_]\)/\\\\\1/g;s/\(\$_[^s]\)/\\\\\1/g;s/\(\$_s[^l]\)/\\\\\1/g;s/\`/\\\\\`/g;s/\"/\\\\\"/g;s/\(.*\)/echo \"\1\"/g" install-lang.sh > /tmp/install-lang-inst.sh

sed -e "s/\\\\/\\\\\\\\/g;s/\\\\n/\\\\\\\\n/g;s/\(\$[^_]\)/\\\\\1/g;s/\(\$_[^s]\)/\\\\\1/g;s/\(\$_s[^l]\)/\\\\\1/g;s/\`/\\\\\`/g;s/\"/\\\\\"/g;s/\(.*\)/echo \"\1\"/g" install-amd64-lang.md > /tmp/install-amd64-lang-inst.sh

sed -e "s/\\\\/\\\\\\\\/g;s/\\\\n/\\\\\\\\n/g;s/\(\$[^_]\)/\\\\\1/g;s/\(\$_[^s]\)/\\\\\1/g;s/\(\$_s[^l]\)/\\\\\1/g;s/\`/\\\\\`/g;s/\"/\\\\\"/g;s/\(.*\)/echo \"\1\"/g" install-lang.sub > /tmp/install-sub-inst.sh

sed -e "s/\\\\/\\\\\\\\/g;s/\\\\n/\\\\\\\\n/g;s/\(\$[^_]\)/\\\\\1/g;s/\(\$_[^s]\)/\\\\\1/g;s/\(\$_s[^l]\)/\\\\\1/g;s/\`/\\\\\`/g;s/\"/\\\\\"/g;s/\(.*\)/echo \"\1\"/g" upgrade-lang.sh > /tmp/upgrade-lang-inst.sh


. ./install-$DLENG

. /tmp/install-lang-inst.sh > install-$DLENG.sh
echo "1";
. /tmp/install-sub-inst.sh > install-$DLENG.sub
echo "2";
. /tmp/upgrade-lang-inst.sh > upgrade-$DLENG.sh
echo "3";
. /tmp/install-amd64-lang-inst.sh > install-amd64-$DLENG.md
echo "4";

