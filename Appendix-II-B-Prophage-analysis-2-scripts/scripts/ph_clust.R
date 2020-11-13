#############################################################################
# - Obtain Euclidian distances, followed by Hierachical clustering based on #
# a frequency matrix.                                                       #
#############################################################################

library(ape)
library(ggplot2)

file_matrix<-(commandArgs(TRUE)[1])
freq_matrix_a<-read.delim(file_matrix, sep="\t", header=TRUE, row.names = 1)
freq_matrix<-t(freq_matrix_a)
myData <- list(names = rownames(freq_matrix), mat = freq_matrix)
isolate_number <- nrow(freq_matrix)

a <- Sys.time() # ~ 2 min
nDup <- sum(duplicated(myData$mat), na.rm=TRUE) # must remove duplicate lines due to hclust method

myDist <- dist(myData$mat)
myHierachy <- hclust(myDist, method = "complete") # change methods if you want to
myHierachyd <- as.dendrogram(myHierachy)

t0 <- Sys.time()

#tree_plot <- plot(as.phylo(myHierachy), type = "unrooted", cex = 0.6, no.margin = TRUE)
svg(filename="./output/prophage_tree.svg")
nodePar <- list(lab.cex = 0.6, pch = c(NA, 19), 
                cex = 0.7, col = "blue")
plot(myHierachyd, nodePar = nodePar, horiz = TRUE)
#plot(as.phylo(myHierachy), type = "unrooted", cex = 0.6, no.margin = TRUE)
dev.off()

print("Done")
Sys.time() - t0
