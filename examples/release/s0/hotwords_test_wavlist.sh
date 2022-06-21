#!/bin/bash

file=

. utils/parse_options.sh


export GLOG_logtostderr=1
export GLOG_v=2

context_path=/datadrive/wenet/wenet-hotwords/examples/release/s0/content_text

model_dir=/datadrive/wenet/wenet-hotwords/examples/release/s0/exp/sp_spec_aug
:>$file/log.txt




cd /datadrive/wenet/wenet-hotwords/runtime/server/x86
    # --context_path $context_path \
    # --context_score 4 \
    # --context_path $context_path \
    # --context_score 3 \
  ./build/decoder_main \
    --context_path $context_path \
    --context_score 3 \
    --wav_scp $file/wav.scp \
    --chunk_size -1 \
    --model_path $model_dir/final.zip \
    --dict_path $model_dir/words.txt 2>&1  >  $file/temp


wait




