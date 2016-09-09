## # Gene expression analysis
##
## Perform a (fairly meaningless) gene expression analysis on some samples. The
## data comes from [Rudolph *& al.* (2016)][@Rudolph2016]. The full data can be
## found [on figshare](https://dx.doi.org/10.6084/m9.figshare.2056227.v1).

#+ packages, echo=FALSE, message=FALSE
modules::import_package('dplyr', attach = TRUE)
modules::import_package('ggplot2', attach = TRUE)

#+ load-data
expression_data = readr::read_tsv('data/rnaseq-vst.tsv')
library_design = readr::read_tsv('data/rnaseq-design.tsv',
                                 col_names = c('ID', 'Condition'))

linkify = function (gene_id)
    sprintf('<a href="http://ensembl.org/id/%s">%s</a>', gene_id, gene_id)

top_genes = readr::read_tsv('data/rnaseq-top-10-genes.tsv') %>%
    mutate(Gene = linkify(Gene))

## To verify that biological replicates cluster together, we can perform a PCA:

#+ prcomp
expr_matrix = expression_data %>%
        as.data.frame() %>%
        tibble::column_to_rownames('Gene') %>%
        as.matrix()
pca = prcomp(t(expr_matrix))
pcx = pca$x %>%
    as.data.frame() %>%
    tibble::rownames_to_column('Library') %>%
    inner_join(library_design, by = c('Library' = 'ID'))

var_expl = function (pca, axis) {
    vars = pca$sdev ^ 2
    vars = vars / sum(vars)
    vars[axis] * 100
}

#+ pca-scatter-plot, fig.width=4, fig.height=4
ggplot(pcx) +
    aes(PC1, PC2, color = Condition) +
    geom_point() +
    labs(x = sprintf('PC1 (%0.0f%% variance explained)', var_expl(pca, 1)),
         y = sprintf('PC2 (%0.0f%% variance explained)', var_expl(pca, 2))) +
    theme_minimal()

## Here’s a table of the top `r nrow(top_genes)` genes:

#+ top-genes, echo=FALSE, results='asis'
knitr::kable(top_genes)

## [@Rudolph2016]: http://dx.doi.org/10.1371/journal.pgen.1006024 "Rudolph & al., Codon-Driven Translational Efficiency Is Stable across Diverse Mammalian Cell States. PLoS Genet; 2016"
