import pandas as pd

signal_file = pd.read_table('/Users/Syunwun/Desktop/temp/result/merge/signalp_out.txt', sep='\s+')
target_file = pd.read_table('/Users/Syunwun/Desktop/temp/result/merge/target_parsed.txt', sep='\s+', header = None)
###tmhmm_file  = pd.read_table('/data02/home/susan/project/11_UE_RNA/analysis/secrete_protein/new/merge/tmhmm_parse.txt', sep='\t', header = None)


#parse singal
signal = signal_file[['name', 'pos.1','?']]
#  name  pos.1  ?
#0  1_g     72  N
#1  2_g     52  N
signal.columns=['name','possignal','result_signal']

#parse target
target = target_file[[0,5]]
#           0  5
#0     1621_g  _
#1     1622_g  _
target.columns=['name','result_target']

#parse tmhmm
###tmhmm = tmhmm_file[[0,3]]
#            0     3
#0         3_g    21
#1        41_g    16
###tmhmm.columns=['name','pos_tmhmm']

#merge
merged_result1 = pd.merge(signal, target, how='outer', on = 'name')
###merged_result2 = pd.merge(merged_result1, tmhmm, how='outer', on = 'name')
#  name  pos_signal result_signal result_target  pos_tmhmm
#0  1_g          72             N             _        NaN

###merged_result2.to_csv('/data02/home/susan/project/11_UE_RNA/analysis/secrete_protein/new/merge/final_merge',index=False, sep='\t', na_rep='N')
merged_result1.to_csv('/Users/Syunwun/Desktop/temp/result/merge/final_merge',index=False, sep='\t', na_rep='N')


#calculate distance
###merged_result2[6]=merged_result2.pos_signal-merged_result2.pos_tmhmm

