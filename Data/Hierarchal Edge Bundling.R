# Load required libraries
library(readxl)
library(dplyr)
library(stats)
library(ggplot2)
library(ggdendro)
library(igraph)
library(ggraph)

# Step 1: Load and standardize the data
data <- read_excel("Data/Mol_raw_data.xlsx", sheet = 1)
data <- as.data.frame(data)

# Ensure the first column becomes the row names
rownames(data) <- data[,1]
data <- data[,-1]

#Standardise the data 
scaled_data <- vegan::decostand(data, method="standardize", MARGIN = 1)

# Step 2: Calculate Euclidean distances
dist_matrix <- dist(scaled_data, method = "euclidean")

# Step 3: Apply hierarchical clustering
hc <- hclust(dist_matrix, method = "ward.D2")

# Step 4 : Convert to dendrogram 
dendro <- as.dendrogram(hc)

#Step 5: Use ggraph 
hierarchy = as_tbl_graph(dendro)
