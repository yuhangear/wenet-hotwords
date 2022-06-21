#!/bin/bash


export GLOG_logtostderr=1
export GLOG_v=2
cd /datadrive/wenet/wenet-hotwords/runtime/server/x86
wav_path=/datadrive/wenet/wenet-hotwords/examples/release/s0/data/ntu-conversation/raw_wav/S1-mml-1-dec-2017-a-session1-2-103009-103892.wav 
./build/websocket_client_main     --hostname 127.0.0.1 --port 20086     --wav_path $wav_path 2>&1 | tee client.log


