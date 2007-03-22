all: refpages list-elements.xml 

refpages:
	$(MAKE) -C elements

list-elements.xml: Makefile $(wildcard elements/build/*.xml)
	@echo Extracting elements...
	../tools/bin/makeelist > $@

clean:
	$(MAKE) -C elements clean
