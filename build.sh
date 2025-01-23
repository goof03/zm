#! /bin/bash
ZMK_CONFIG_PATH=$PWD
ZMK_APP=../zmk/app/

# Build
cd "$ZMK_APP" || return
git pull
west build -p -d build/left -b nice_nano_v2 -S studio-rpc-usb-uart -- -DSHIELD=corne_left \
  -DZMK_CONFIG="$ZMK_CONFIG_PATH/config" -DCONFIG_ZMK_STUDIO=y
west build -p -d build/right -b nice_nano_v2 -S studio-rpc-usb-uart -- -DSHIELD=corne_right \
  -DZMK_CONFIG="$ZMK_CONFIG_PATH/config" -DCONFIG_ZMK_STUDIO=y

# Get the result
cd "$ZMK_CONFIG_PATH" || return
mkdir -p build
rm -r "$ZMK_CONFIG_PATH/build"/*
cp "$ZMK_APP/build/left/zephyr/zmk.uf2" build/left.uf2
cp "$ZMK_APP/build/right/zephyr/zmk.uf2" build/right.uf2

dolphin "$ZMK_CONFIG_PATH/build" &
