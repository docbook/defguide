all: ref-elements.xml
	$(MAKE) -C elements

depends:
	$(MAKE) -c elements depends

ref-elements.xml:
	echo "<reference xml:id='ref-element' xmlns='http://docbook.org/docbook-ng' xmlns:xi='http://www.w3.org/2001/XInclude'>" > $@
	echo "<title>DocBook Element Reference</title>" >> $@
	echo "<?dbhtml filename='ref-elements.html'?>" >> $@
	echo "<xi:include href='intro-elements.xml'/>" >> $@
	@for f in elements/[a-z]*/db.*.xml elements/[A-Z]*/db.*.xml; do \
		echo -n "<xi:include href='" >> $@; \
		echo -n `dirname $$f` >> $@; \
		echo -n "/" >> $@; \
		echo -n `basename $$f .xml`.gen >> $@; \
		echo "'/>" >> $@; \
	done
	echo "</reference>" >> $@
