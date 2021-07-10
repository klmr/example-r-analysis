# Example R analysis workflow

This is a makefile based R analysis workflow. Intermediate results are generated
in incremental steps, with every analysis step corresponding to an
(extension-less) file inside the `script` path.

The final output(s) is/are generated via a Knitr report. Together with
intermediate data files (in the `data` path) and the figure files (in the
`report/figures/*` paths), this represents the publishable output of the
analysis.

The result can be previewed in [`report/report.html` on the `compiled`
branch](http://htmlpreview.github.io/?https://github.com/klmr/example-r-analysis/blob/compiled/report/report.html).

To run the whole workflow, simply execute

```bash
make
```

on the command line.

This will first download the necessary raw data and then perform the analysis.
**Note** that this will *not* install the required dependencies. Achieving this
is [an ongoing project](https://github.com/klmr/box/milestone/4).

## Dependencies

Run on R v3.2.1.

This project has several package and several ‘box’ module dependencies:

### Package dependencies

#### CRAN

* box
* ezknitr
* knitr
* readr
* tibble
* tidyr
* dplyr
* ggplot2

### Bioconductor

* DESeq2 v1.8.2

### Module dependencies

* [klmr/sys@box-rewrite](https://github.com/klmr/sys/commit/e7ebbef1fcd453704b16a31c6ed7f77d05800770)
