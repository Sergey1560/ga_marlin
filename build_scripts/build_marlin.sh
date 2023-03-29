#!/bin/bash

PIO_PATH="/root/.platformio/penv/bin/pio"
PIO_PARAM="run -s"
PIO_CONFIG_PATH="/marlin/build_config"
BIN_DIR="/marlin/build_bin"
BIN_F103_DIR="stm32f103_boards"
BIN_F407_DIR="stm32f407_boards"

F4_ENVS="mks_robin_nano_v1_3_a4988 mks_robin_nano_v1_3_2208 mks_robin_nano_v1_3_s mks_robin_nano_v1_3_s_2209"
F1_ENVS="mks_robin_nano_v1v2_fb4s_2208 mks_robin_nano_v1v2_fb4s_a4988 mks_robin_nano_v1v2_fb5_2208 mks_robin_nano_v1v2_fb5_a4988 mks_robin_nano_v1v2_fb5_rb30"

echo "Clean bin dir"
rm -rf ${BIN_DIR}

echo "Mkdir struct"
mkdir ${BIN_DIR}
mkdir -p ${BIN_DIR}/{${BIN_F103_DIR},${BIN_F407_DIR}}

for e in $F4_ENVS
do
    mkdir -p ${BIN_DIR}/${BIN_F407_DIR}/$e
done
 

for e in $F1_ENVS
do
    mkdir -p ${BIN_DIR}/${BIN_F103_DIR}/$e
done

echo "Change DIR"
cd /marlin/Marlin_FB4S
echo "Current DIR"
pwd

echo "STM32F4 Boards"

for e in $F4_ENVS
do
    echo " =>Processing $e"
    ${PIO_PATH} ${PIO_PARAM} -e $e
    cp /marlin/Marlin_FB4S/.pio/build/$e/Robin_nano35.bin ${BIN_DIR}/${BIN_F407_DIR}/$e
    ${PIO_PATH} ${PIO_PARAM} -t clean -e $e
done

echo "STM32F1 Boards"
for e in $F1_ENVS
do
    echo " =>Processing $e"
    ${PIO_PATH} ${PIO_PARAM} -e $e
    cp /marlin/Marlin_FB4S/.pio/build/$e/Robin_nano35.bin ${BIN_DIR}/${BIN_F103_DIR}/$e
    ${PIO_PATH} ${PIO_PARAM} -t clean -e $e
done
