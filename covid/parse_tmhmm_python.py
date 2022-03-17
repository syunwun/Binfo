import pandas as pd
import numpy as np

tmhmm  = pd.read_table('/data02/home/susan/project/11_UE_RNA/analysis/secrete_protein/new/merge/tmhmm_out.txt', sep='\t', comment='#', header= None)
mem = tmhmm[tmhmm[2] == 'TMhelix']
#groupgene = mem.groupby(mem[0])
tmhmm = mem.groupby(mem[0]).filter(lambda x: len(x) == 1)
#unigene.agg(np.size)
tmhmm[4] = tmhmm[3].str.split('\s+', expand=True)[1]
tmhmm[5] = tmhmm[3].str.split('\s+', expand=True)[2]
tmhmm_final=tmhmm.drop([3], axis=1)
tmhmm_final.to_csv('/data02/home/susan/project/11_UE_RNA/analysis/secrete_protein/new/merge/tmhmm_parse.txt', index=False, sep='\t',header = False)
