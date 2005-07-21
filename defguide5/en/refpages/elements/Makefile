all:
	for f in *; do if [ -d $$f -a $$f != 'CVS' ]; then $(MAKE) -C $$f; fi; done

depends:
	for f in *; do if [ -d $$f -a $$f != 'CVS' ]; then $(MAKE) -C $$f depends; fi; done
