install.packages('BiocManager')
library(BiocManager)
install('gson')
install('clusterProfiler')                 
install.packages('vctrs')
install('pathview')
install('XML')
install.packages("oaqc")
install.packages('data.table')
install.packages('rescale')
BiocManager::install("oaqc")
devtools::install_github("poissonconsulting/rescale")
library(BiocManager)

library(clusterProfiler)
library(org.Hs.eg.db)
library(enrichplot)
library(dplyr)
library(pathview)
library(R.utils)
library(oaqc)
library(ggraph)
library(rescale)

Mono_c04_high_genes = read.csv('C:/Users/james/D：/Mono_c04_PF4_PPBP_sap_high.csv',
                              header=1)
CD8_T_c01_GZMH_high_genes = read.csv('C:/Users/james/D：/CD8_T_c01_GZMH_sap_high.csv',
                        header=1)
scissor_genes = read.csv('C:/Users/james/D：/scissor_1_high.csv',
                                     header=1)

c = as.list(scissor_genes$'sap')

eg <- bitr(as.character(c), fromType="SYMBOL", toType=c("ENTREZID","ENSEMBL"), OrgDb="org.Hs.eg.db")
eg <- na.omit(eg)
eg <- eg[!duplicated(eg$SYMBOL),]
eg
genelist <- eg$ENTREZID
go1 <- enrichGO(genelist, OrgDb = org.Hs.eg.db, ont='BP',pvalueCutoff = 0.1, 
                qvalueCutoff = 0.2,readable = TRUE)
R.utils::setOption("clusterProfiler.download.method",'auto')
kegg1 <- enrichKEGG(genelist, organism = 'hsa', keyType = 'kegg', pvalueCutoff = 0.1,pAdjustMethod = 'BH', 
                    minGSSize = 10,maxGSSize = 500,qvalueCutoff = 0.2,use_internal_data = FALSE)

barplot(kegg1)
barplot(go1)
go <- go1
go@result <- go1@result[c(1,2,4,12),]

