all:
	for f in *; do if [ -d $$f ]; then $(MAKE) -C $$f; fi; done

depends:
	for f in *; do if [ -d $$f ]; then $(MAKE) -C $$f depends; fi; done
