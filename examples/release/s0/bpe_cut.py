import sentencepiece as spm
sp = spm.SentencePieceProcessor()
from collections import Counter, defaultdict
import math 
from wenet.utils.file_utils import read_symbol_table, read_non_lang_symbols
sp.load("./data/lang_char/train_unigram5000.model")


symbol_table = read_symbol_table("./data/lang_char/train_unigram5000_units.txt")


#hot_id
with open("./hotwords_list") as f:
    for line in f:
        line=line.strip()
        line=sp.encode_as_pieces(line)
        for i in line:
            print(str(i) +" ",end="")
        print("")
        
#word F
# vocab_counter = Counter()
# all_count=0
# with open("./hotwords_list") as f:
#     for line in f:
#         line=line.strip()
#         line=sp.encode_as_pieces(line)
#         for i in line:
#             all_count=all_count+1
#             vocab_counter[str(symbol_table[i])] += 1


# f={}
# for i in vocab_counter:
#     f[i]=vocab_counter[str(i)]/all_count

# print(f)



#w
# vocab_counter = Counter()
# all_count=0
# with open("./hotwords_list") as f:
#     for line in f:
#         line=line.strip()
#         line=sp.encode_as_pieces(line)
#         for i in line:
#             all_count=all_count+1
#             vocab_counter[str(symbol_table[i])] += 1

# f={}
# for i in vocab_counter:
#     f[i]=  math.log( vocab_counter[str(i)]/all_count * 20 )

# print(f)
    

#git all dict
# with open("./hotwords_list") as f:
#     for line in f:
#         line=line.strip()
#         line=line.split()
        
#         len1=len(line)

#         for i in range(len1):
#             if i>=1:
#                 print(" ".join(line[0:i+1])+" ",end="")
#                 if i+1 <len1:
#                     print(str(line[i+1]))
#                 else:
#                     print("end")


# dict + set
# predict={}
# with open("./hotwords_list") as f:
#     for line in f:
#         line=line.strip()
#         line=line.split()
#         key=" ".join(line[0:-1])
#         if key not in predict:
#             tempset=set()
#             tempset.add(line[-1])
#             predict[key]=tempset
#         else:
#             predict[key].add(line[-1])

# print(predict)
       

