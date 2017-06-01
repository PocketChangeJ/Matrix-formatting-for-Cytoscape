# Matrix-formatting-for-Cytoscape
Converting an experimentally derived Spearman matrix into a Cytoscape compatible table

Virginia Commonwealth University 
Applications in Bioinformatics BNFO 420 
Professor: Dr. Tarynn Witten 

Overall, our project was to compare gene networks between 2 month and 24 month old mice to determine changes in the immune system. We were given large matrices including Spearman, Pearson and Distance, with the corresponding p-value matrices. These matrices had all of the given genes, in our case 130, and compared them to each other. We first began by subsetting the matrices into a simpler table with the columns as names of the paired genes, the correlation value (We used Spearman), and the corresponding p-value. 

This code first finds all of the unique gene pairs and their values and imports these values into a table. The table has three columns, the two genes names, and the value. This is done for both the Spearman matrix and the p-value matrix. These two tables are then combined so that each gene pair has its correlation value and the p-value in the same row. Next, we keep the values that have a p-value less than .05, and a correlation value greater than or equal to .8. 

The final table is then in the correct format to be imported into Cytoscape to produce a network. 
 
R Core Team (2017). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL https://www.R-project.org/.

Hadley Wickham (2011). The Split-Apply-Combine Strategy for Data Analysis. Journal of Statistical Software, 40(1), 1-29. URL http://www.jstatsoft.org/v40/i01/.

Adrian A. Dragulescu (2014). xlsx: Read, write, format Excel 2007 and Excel 97/2000/XP/2003 files. R package version 0.5.7. https://CRAN.R-project.org/package=xlsx
