#!/bin/bash


export GLOG_logtostderr=1
export GLOG_v=2
cd /datadrive/wenet/wenet-hotwords/runtime/server/x86
model_dir=/datadrive/wenet/wenet-hotwords/examples/release/s0/exp/sp_spec_aug
./build/websocket_server_main     --port 20086     --chunk_size 16     --model_path $model_dir/final.zip     --dict_path $model_dir/words.txt 2>&1 | tee server.log