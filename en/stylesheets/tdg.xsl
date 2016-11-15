<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
                xmlns:f="http://docbook.org/xslt/ns/extension"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
		xmlns:html="http://www.w3.org/1999/xhtml"
		xmlns:db="http://docbook.org/ns/docbook"
		xmlns:t="http://docbook.org/xslt/ns/template"
		xmlns:m="http://docbook.org/xslt/ns/mode"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="f rng html db m t xs"
                version="2.0">

<!-- this stylesheet somewhat dangerously does its own profiling -->

<xsl:import href="../defguide5/build/docbook/xslt/base/html/docbook.xsl.xsl"/>
<xsl:include href="custom.xsl"/>

</xsl:stylesheet>
