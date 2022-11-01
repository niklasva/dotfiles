#!/bin/sh
CWD=$PWD
PROJ_WD="/Users/niklas/dev/git/clean/nrf52-application"
BUILD_WD="BUILD/SLIM_DEBUG/GCC_ARM-MBED_PROFILE_DEBUG"

cd $PROJ_WD

sed -i '' "s/#define\ BOARD_TYPE.*/#define\ BOARD_TYPE\ \(SLIM_DEBUG\)/g" $PROJ_WD/src/board/boardType.h 

if mbed compile --profile=mbed_profile_debug.json --toolchain GCC_ARM --target SLIM_DEBUG --color -l NRF52840.ld ; then
    echo $'OK\n'
else
    echo $'\e[30;41m' FAIL $'\e[0m\n'
    cd $PWD
    exit 1
fi

cd $BUILD_WD

if nrfutil settings generate --family NRF52840 --bl-settings-version 2 --bootloader-version 0 --application nrf52-application.hex --application-version 0 nrf_bl_settings.hex; then
    echo $'OK\n'
else
    echo $'\e[30;41m' FAIL $'\e[0m\n'
    cd $PWD
    exit 1
fi

if nrfjprog --program nrf_bl_settings.hex --sectorerase; then
    echo $'OK\n'
else
    echo $'\e[30;41m' FAIL $'\e[0m\n'
    cd $PWD
    exit 1
fi

if nrfjprog --program nrf52-application.hex --sectorerase; then
    echo $'OK\n'
else
    echo $'\e[30;41m' FAIL $'\e[0m\n'
    cd $PWD
    exit 1
fi

if nrfjprog --reset; then
    echo $'OK\n'
else
    echo $'\e[30;41m' FAIL $'\e[0m\n'
    cd $PWD
    exit 1
fi

cd $PWD
