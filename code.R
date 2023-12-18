getwd()
df<-read.csv("C:/Users/james/D：/ctr_df_T.csv",header=T,
         stringsAsFactors = F)
head(df)
dim(df)
df$group<-ifelse(df$logfd>=2&df$pvals<=0.05,"Up",
                  ifelse(df$logfd<=-2&df$pvals<=0.05,
                         "Down","Not sig"))
table(df$group)
df
write.csv(df, file = "ctr_df_mono_2.csv")

head(df)
library(ggplot2)
#install.packages("ggrepel")
library(ggrepel)
ggplot(df,aes(x=logfd,y=-log10(pvals)))+
  geom_point(aes(color=group))+
  scale_color_manual(values=c("dodgerblue","gray","firebrick"))
df$pvalue_log10<-(-log10(df$pvals))
df1<-df[df$pvalue_log10>=10,]
dim(df1)
options(ggrepel.max.overlaps = 5)
ggplot(df,aes(x=logfd,y=-log10(pvals)))+
  geom_point(aes(color=group))+
  scale_color_manual(values=c("dodgerblue","gray","firebrick"))+
  geom_label_repel(data=df1,aes(x=logfd,y=-log10(pvals),
                          label=genes))+
  theme_bw()+
  labs(y="-log10(pvalue)",x="log(Fold Change)")
  
  
