df <- read.csv('BostonHousing.csv')

df1 <- aggregate(df$MEDV, by = list(df$CHAS), FUN = mean)

names(df1) <- c("CHAS", 'MeanMEDV')

barplot(df1$MeanMEDV, names.arg = df1$CHAS, col=c("darkkhaki","darkorange"), xlab = "CHAS", ylab = "Avg. MEDV")

plot(df$MEDV ~ df$LSTAT, xlab ="LSTAT", ylab ="MEDV", col="darkorchid4")

hist(df$MEDV, xlab = "MEDV", col="steelblue4")

boxplot(df$MEDV ~ df$CHAS, col=c("darkkhaki","darkorange"), xlab = "CHAS", ylab = "MEDV")

heatmap(cor(df), Rowv = NA, Colv = NA)

library(gplots)
heatmap.2(cor(df), Rowv = FALSE, Colv = FALSE, dendrogram = "none",
          cellnote = round(cor(df),2),
          notecol = "black", key = FALSE, trace = 'none', margins = c(9,9))
