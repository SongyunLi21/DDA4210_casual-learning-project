library(readr)
#import dataset
TCGA_Breast_Cancer <- read_csv("casual/TCGA_Breast_Cancer.csv")
name_tcga<-TCGA_Breast_Cancer$sample
TCGA_Breast_Cancer$sample <-NULL
#range(TCGA_Breast_Cancer)

#grayBreastCell <- read_csv("casual/grayBreastCell.csv")
normal_breast_mammary_tissue <- read_csv("casual/normal_breast_mammary_tissue.csv")
name_normal <- normal_breast_mammary_tissue$Description
normal_breast_mammary_tissue$Name<-NULL
normal_breast_mammary_tissue$Description <-NULL

name <- intersect(name_normal,name_tcga)

normal <- subset(normal_breast_mammary_tissue,name_normal%in%name)
cancer <- subset(TCGA_Breast_Cancer,name_tcga%in%name_normal)
name_normal <- name_normal[name_normal%in%name]
name_cancer <-  name_tcga[name_tcga%in%name]

# load counts table from GEO

# pre-filter low count genes
# keep genes with at least 2 counts > 10
keep <- rowSums(normal >= 10)>= 2
normal  <- normal[keep, ]
name_normal <-name_normal[keep]

# log transform raw counts
# instead of raw counts can display vst(as.matrix(tbl)) i.e. variance stabilized counts
normal <- log2(normal+1)
normal <- (normal-min(normal))/(max(normal)-min(normal))
normal$name<-name_normal
write.csv(normal,"normal.csv")
cancer<-cancer[name_cancer%in%name_normal,]
name_cancer<-name_cancer[name_cancer%in%name_normal]
cancer <- (cancer-min(cancer))/(max(cancer)-min(cancer))
cancer$name<-name_cancer
write.csv(cancer,"cancer.csv")


