library(CANM)
# IGCI method
set.seed(0)
x=read_csv("casual/breast_cancer_gene_expression.csv")
x$...1 <- NULL
gene <- colnames(x)
y=read_csv("casual/true_labels.csv")
y$...1 <-NULL
l_xy <- c()
l_yx <- c()
for(i in gene){
  f=IGCI(x[,i],y,refMeasure=2,estimator=1)
  print(i)
  if(f<0){
    l_xy<-append(l_xy,1)
    l_yx<-append(l_yx,0)
    print("X->Y")
  }else{
    l_xy<-append(l_xy,0)
    l_yx<-append(l_yx,1)
    print("Y->X")
  }
}

df <-data.frame(l_xy,l_yx)
colnames(df)<-c("XY","YX")
write.csv(df,"igci.csv")
