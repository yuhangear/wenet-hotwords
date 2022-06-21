Introduction of WENET with hot word decoding

The main process of wenET model training deployment and testing will be introduced next

1. Model training

   1. Install wenet

      ```
      git clone https://github.com/wenet-e2e/wenet.git
      
      #or hotwords vision
      #git clone https://github.com/yuhangear/wenet-hotwords
      
      conda create -n wenet python=3.8
      conda activate wenet
      pip install -r requirements.txt
      conda install pytorch=1.10.0 torchvision torchaudio=0.10.0 cudatoolkit=11.1 -c pytorch -c conda-forge
      ```

   2. Prepare training data and training models

      1. To prepare data
         1. Need Kaldi format ready wav. SCP, text, segments
      2. Training model
         1. Find the example folder in the directory, we can refer to the case training model, because wenET already has a large amount of data training model, such as Gigaspeech. Our main training process is to initialize our model with Gigaspeech's model.
         2. The script for the training is roughly the same as the Gigaspeech /s0/run.sh process, with the care to change the data directory names appropriately
         3. The configuration file selected for the model is: ** train_U2 ++_conformer. Yaml ** In the past experiments, the build uses a smaller learning rate LR :0.00005
         4. Code training details in the table of contents：/home3/yuhang001/new_wenet/wenet/examples/gigaspeech/temp/wenet/examples/gigaspeech/s1。The main changes are as follows
            1. Download the model from the official website before training：https://wenet-1256283475.cos.ap-shanghai.myqcloud.com/models/gigaspeech/20210728_u2pp_conformer_exp.tar.gz
            2. Before training, let the model load the trained model in advance

2. Model packaging

   1. After the model is trained, average will be carried out on the model.
   2. The model is then packaged using wenet/bin/export_jit.py to produce final.zip. The final.zip file and the data/ lang_CHAR/train_unigRAM5000_units. TXT file will be used on the server or Android

3. Deployment model

   

   Next, the deployment method on the server is introduced. The server also uses C language code to load the running model. The first step is to compile the C language code model, and the compilation process is as follows. It should be noted that there will be problems with the installation in the following situations. This is not a problem if it is the ubuntu20 version

   + The glibc version is too early
   + Unable to download dependency packages on Github due to network problems

   ```
   git clone https://github.com/yuhangear/wenet-hotwords
   cd runtime/server/x86
   mkdir build && cd build && cmake .. && cmake --build .
   ```

   

   The code is different from  official code,  Here is the modified code

   ```
   x86/decoder/context_graph.cc  (Build graph with lists of hot words)  
   x86/decoder/context_graph.h
   x86/decoder/ctc_prefix_beam_search.cc (Add hot word scores during the decoding process of end-to-end model BeamSearch)
   x86/decoder/ctc_prefix_beam_search.h
   x86/decoder/hw_scorer.cc (The hot word score is given for hot word matching)
   x86/decoder/hw_scorer.h
   ```

   

4. The test process

   + cd examples/release/s0

   + Prepare the test audio file directory

     + We need to prepare Kaldi Formated (wav. scp text utt2spk spk2utt) files
     + If there is a "segments" file, we need to cut the wav file and reestablish the wav.scp and delete the segments
   
   + Prepare a list of hot words
   
     + ```
       #According to the hot words list, cut into sub-words
       python bpe_cut.py > content_tex_temp
       
       ```
   
       

   + The decoding mode is based on the server client

     + ```
       #Start the server program
       ./server_start.sh
       #Start the client for decoding
       ./client_start.sh 
       ```
   
   + Local multiprocess decoding
   
     ```
     #
     ./multi_pro_test.sh --test_data ntu-conversation
     ```
   
     
