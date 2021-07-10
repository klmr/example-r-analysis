.DEFAULT_GOAL := report/report.html

data report:
	mkdir -p '$@'

# Data from <https://dx.doi.org/10.6084/m9.figshare.2056227>

data/rnaseq-counts.tsv: | data
	curl -L --output '$@' https://ndownloader.figshare.com/files/3632364

data/rnaseq-design.tsv: | data
	curl -L --output '$@' https://ndownloader.figshare.com/files/3632328

data/rnaseq-vst.tsv: data/rnaseq-counts.tsv data/rnaseq-design.tsv
	scripts/stabilize-counts --counts '$<' --design '$(lastword $^)' '$@'

data/rnaseq-top-10-genes.tsv: data/rnaseq-vst.tsv data/rnaseq-design.tsv
	scripts/top-genes --vst '$<' --design '$(lastword $^)' -n 10 '$@'

report/report.html: data/rnaseq-vst.tsv data/rnaseq-design.tsv data/rnaseq-top-10-genes.tsv

report/%.html: %.r | report
	scripts/spin '$<' --out-dir '$(dir $@)'
