#!/bin/bash
set -e

apt-get update -y
apt-get install -y python3 python3-pip python3-venv git curl unzip

python3 -m pip install --upgrade pip
pip3 install lightgbm scikit-learn pandas numpy

mkdir -p /home/benchmark
echo "Setup complete" > /home/benchmark/ready.txt
