#! /bin/bash
TEMP=`getopt -o vd: --long verbose,debug:,boot:,bif:,bootloader:,second:,bit: -n "make-boot.sh"  -- "$@"`

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

# Note the quotes around `$TEMP': they are essential!
eval set -- "$TEMP"

VERBOSE=false
DEBUG=false
BIF='boot.bif'
BOOT='boot.bin'
BIT='zturn-trd.bit'
BOOTLOADER='fslb.elf'
SECOND='u-boot.elf'

while true; do
  case "$1" in
    -v | --verbose ) VERBOSE=true; shift ;;
    -d | --debug ) DEBUG=true; shift ;;
    --boot ) BOOT="$2"; shift 2 ;;
    --bif ) BIF="$2"; shift 2 ;;
    --bit ) BIT="$2"; shift 2 ;;
    --bootloader ) BOOTLOADER="$2"; shift 2 ;;
    --second ) SECOND="$2"; shift 2 ;;
    * ) break ;;
  esac
done


#sanity check

function getout {
	echo $1
	exit 1
}

[ -e "$BOOT" ] && rm -f "$BOOT"
[ -e "$BIT" ] || getout "$BIT not found"
[ -e "$BOOTLOADER" ] ||  getout "$BOOTLOADER not found"
[ -e "$SECOND" ] ||  getout "$SECOND not found"

if [ "${SECOND#*.}" != "elf" ];
then
	TMP_SECOND="$(tempfile -s ".elf")"
	cp "$SECOND" "$TMP_SECOND"
	SECOND=$TMP_SECOND
fi
if [ "${BOOTLOADER#*.}" != "elf" ];
then
	TMP_BOOTLOADER="$(tempfile -s ".elf")"
	cp "$BOOTLOADER" "$TMP_BOOTLOADER"
	BOOTLOADER=$TMP_BOOTLOADER
fi


cat <<EOF > $BIF
image: {
[bootloader] $BOOTLOADER
$BIT
$SECOND
}
EOF


[ -e "$BIF" ] ||  getout "$BIF not found"

exec bootgen -arch zynq -image $BIF -o $BOOT -log debug -w

rm -f $TMP_BOOTLOADER $TMP_SECOND

#echo "$BOOT file has been created, using $BIF as specifications."
