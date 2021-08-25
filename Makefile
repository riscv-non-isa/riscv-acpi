#
#	Build usable docs
#

ASCIIDOCTOR = asciidoctor
DITAA = ditaa
RISCV_ACPI_SPEC = riscv-acpi-platform-req
PANDOC = pandoc

# Build the platform spec in several formats
all: $(RISCV_ACPI_SPEC).md $(RISCV_ACPI_SPEC).pdf $(RISCV_ACPI_SPEC).html

$(RISCV_ACPI_SPEC).md: $(RISCV_ACPI_SPEC).xml
	$(PANDOC) -f docbook -t markdown_strict $< -o $@ 

$(RISCV_ACPI_SPEC).xml: $(RISCV_ACPI_SPEC).adoc
	$(ASCIIDOCTOR) -d book -b docbook $<

$(RISCV_ACPI_SPEC).pdf: $(RISCV_ACPI_SPEC).adoc
	$(ASCIIDOCTOR) -d book -r asciidoctor-pdf -b pdf $<

$(RISCV_ACPI_SPEC).html: $(RISCV_ACPI_SPEC).adoc
	$(ASCIIDOCTOR) -d book -b html $<

clean:
	rm -f $(RISCV_ACPI_SPEC).xml
	rm -f $(RISCV_ACPI_SPEC).md
	rm -f $(RISCV_ACPI_SPEC).pdf
	rm -f $(RISCV_ACPI_SPEC).html

# handy shortcuts for installing necessary packages: YMMV
install-debs:
	sudo apt-get install pandoc asciidoctor ditaa ruby-asciidoctor-pdf

install-rpms:
	sudo dnf install ditaa pandoc rubygem-asciidoctor rubygem-asciidoctor-pdf
