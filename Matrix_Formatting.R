library(plyr)
library(xlsx)

distance = read.csv(file="spearman_coeff.csv", header = TRUE, sep = ",")
pval = read.csv(file="spearman_pval.csv", header = TRUE, sep = ",")

get_lower_tri<-function(distance){  #Creates a function to find the unique gene pairings 
distance[upper.tri(distance)] <- NA
return(distance)} 
distance<-get_lower_tri(distance)   #Creates new dataset with only unique pairings 

variables <- colnames(distance)     #Extracts all of the gene names into a list 
variables_q <- variables[2:131]     #Removes the excess variables 

total_function_cor <- function(gene) {  #Function to find pairings and coefficient, for each specified gene 
    new_gene<-noquote(gene)         #Removes the quotes from the gene name 
    X3 <- distance[,new_gene]       #Copies the distance correlation coefficient 
    X3 <- as.data.frame(X3)
    X1 <- rep(new_gene,1)           #Copies the gene name in a column 
    repeating <- as.data.frame(X1)  
    X2 <- distance[,1]              #Creates a list of the other genes in the pair 
    all_names <-as.data.frame(X2)
    X2 <- all_names[-c(131),]       #Removes data set 
    all_names <-as.data.frame(X2)
    combined_names <- merge(repeating,all_names)  #merges all three of the columns
    combined_names["X3"] <- X3      #Gene1, Gene2, Distance Coefficient 
    return(combined_names)
}

final_final = data.frame(matrix(ncol=3,nrow=1)) #Makes an empty dataframe 

for (option in variables_q)         #Parses through all the genes 
{
  final_final= rbind(total_function_cor(option),final_final)
}

final_3col <- na.omit(final_final) #Removes empty data 
final_3col<- rename(final_3col, c("X3"="Correlation"))

#Comparing to Pval 
pval<-get_lower_tri(pval)   #Creates new dataset with only unique pairings 

total_function_pval <- function(gene) {  #Function to find pairings and coefficient, for each specified gene 
  new_gene<-noquote(gene)         #Removes the quotes from the gene name 
  X3 <- pval[,new_gene]       #Copies the distance correlation coefficient 
  X3 <- as.data.frame(X3)
  X1 <- rep(new_gene,1)           #Copies the gene name in a column 
  repeating <- as.data.frame(X1)  
  X2 <- pval[,1]              #Creates a list of the other genes in the pair 
  all_names <-as.data.frame(X2)
  X2 <- all_names[-c(131),]       #Removes data set 
  all_names <-as.data.frame(X2)
  combined_names <- merge(repeating,all_names)  #merges all three of the columns
  combined_names["X3"] <- X3      #Gene1, Gene2, Distance Coefficient 
  return(combined_names)
}

pval_all = data.frame(matrix(ncol=3,nrow=1)) #Makes an empty dataframe 

for (option in variables_q)         #Parses through all the genes 
{
  pval_all= rbind(total_function_pval(option),pval_all) #Binds all the information together
}

pval_omit <- na.omit(pval_all) #Removes empty data 
pval_omit<- rename(pval_omit, c("X3"="pval"))

final_combined <- cbind(pval_omit,final_3col) #combine the pval table with the correlation table 
final_combined<- final_combined[c("X1","X2","pval","Correlation")] #Keeps the gene names and the correlation value 

final_cor <- final_combined[final_combined$Correlation<=-.8,]
final_pval<- final_cor[final_cor$pval < 0.05,] #keep only the significant pvalues
