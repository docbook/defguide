all: refpages list-elements.xml list-assembly.xml

refpages:
	$(MAKE) -C elements

list-elements.xml: Makefile $(wildcard elements/build/*.xml) ../tools/bin/makeelist
	@echo Extracting elements...
	../tools/bin/makeelist > $@

list-assembly.xml: Makefile $(wildcard elements/build/*.xml) ../tools/bin/makeelist
	@echo Extracting elements...
	../tools/bin/makeelist assembly > $@

clean:
	$(MAKE) -C elements clean
