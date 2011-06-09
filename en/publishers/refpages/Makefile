all: refpages list-elements.xml

refpages:
	$(MAKE) -C elements

list-elements.xml: Makefile elements/.formatted ../../tools/bin/makeelist
	@echo Extracting elements...
	../../tools/bin/makeelist > $@

clean:
	$(MAKE) -C elements clean
