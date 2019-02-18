library(ggplot2)

corr <- round(cor(iris[,-5]), 1)

library(GGally)
ggpairs(iris, columns = 1:4)
ggpairs(iris, columns = 1:4, ggplot2::aes(colour=Species))

library(ggcorrplot)
ggcorrplot(corr, p.mat = cor_pmat(iris[,-5]),
           hc.order = TRUE, type = "lower",
           color = c("#FC4E07", "white", "#00AFBB"),
           outline.col = "white", lab = TRUE)


library(FactoMineR)
library(factoextra)

iris.pca <- PCA(iris[,-5], graph = FALSE)

fviz_pca_var(iris.pca)

fviz_pca_ind(iris.pca,
             col.ind.sup = "blue",
             repel = FALSE)

fviz_pca_biplot(iris.pca,
                geom.ind = "point" # Individuals
                )

fviz_pca_biplot(iris.pca,
                col.ind = iris$Species, palette = "jco",
                addEllipses = TRUE, #ellipse.type = "confidence",
                label = "var",
                col.var = "black", repel = TRUE,
                legend.title = "Species")

fviz_pca_biplot(iris.pca,
                # Individuals
                geom.ind = "point",
                fill.ind = iris$Species, col.ind = "black",
                pointshape = 21, pointsize = 2,
                palette = "jco",
                addEllipses = TRUE,

                # Variables
                # alpha.var ="contrib",
                col.var = "contrib",
                gradient.cols = "RdYlBu",
                legend.title = list(fill = "Species", colour = "Contribution")
)
