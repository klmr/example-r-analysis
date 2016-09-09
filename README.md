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
is [an ongoing project of mine](https://github.com/klmr/modules/milestone/4).

## Dependencies

Run on R v3.2.1.

This project has several package and several
[module][klmr/modules] dependencies:

### Package dependencies

#### CRAN

* ezknitr v0.4
* knitr v1.13
* readr v0.2.2.9000
* tibble v1.1
* tidyr v0.3.1.9000
* dplyr v0.5.0.9000
* ggplot2 v2.1.0

#### Github

* [klmr/modules][] v0.9.5 (not online; but try master instead)

### Bioconductor

* DESeq2 v1.8.2

### Module dependencies

* [klmr/sys@ea12f5e](https://github.com/klmr/sys/tree/ea12f5e2f61e7efde7395c7ab7ecfe6cb86de507)

[klmr/modules]: https://github.com/klmr/modules
