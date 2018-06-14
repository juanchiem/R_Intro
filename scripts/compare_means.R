# browseURL("http://www.sthda.com/english/articles/24-ggpubr-publication-ready-plots/76-add-p-values-and-significance-levels-to-ggplots/"
)
library(devtools)
install_github("kassambara/ggpubr")
library(ggpubr)

data("ToothGrowth")
head(ToothGrowth)

compare_means(len ~ supp, data = ToothGrowth, method = "t.test")
compare_means(len ~ supp, data = ToothGrowth, method = "t.test")

p <- ggboxplot(ToothGrowth, 
               x = "supp", y = "len",
               # color = "supp", palette = "jco",
               add = "jitter")
#  Add p-value
p + stat_compare_means()
# Change method
p + stat_compare_means(method = "t.test")

p + stat_compare_means(label = "p.signif", label.x = 1.5, label.y = 40)

compare_means(len ~ supp, data = ToothGrowth, paired = FALSE)

ggpaired(ToothGrowth, x = "supp", y = "len",
         color = "supp", line.color = "gray", line.size = 0.4,
         palette = "jco")+
  stat_compare_means(paired = TRUE)

compare_means(len ~ dose,  data = ToothGrowth, method = "anova")

# Default method = "kruskal.test" for multiple groups
ggboxplot(ToothGrowth, x = "dose", y = "len",
          color = "dose", palette = "jco")+
  stat_compare_means()

# Change method to anova
ggboxplot(ToothGrowth, x = "dose", y = "len",
          color = "dose", palette = "jco")+
  stat_compare_means(method = "anova")

compare_means(len ~ dose,  data = ToothGrowth)

my_comparisons <- list( c("0.5", "1"), c("1", "2"), c("0.5", "2") )
ggboxplot(ToothGrowth, x = "dose", y = "len",
          color = "dose", palette = "jco")+ 
  stat_compare_means(comparisons = my_comparisons)+ # Add pairwise comparisons p-value
  stat_compare_means(label.y = 50)     # Add global p-value
