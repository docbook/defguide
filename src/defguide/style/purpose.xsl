<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:cvs="http://nwalsh.com/xslt/ext/com.nwalsh.saxon.CVS"
		xmlns:html="http://www.w3.org/1999/xhtml"
		xmlns:db="http://docbook.org/ns/docbook"
		xmlns:dbx="http://sourceforge.net/projects/docbook/defguide/schema/extra-markup"
                xmlns:exsl="http://exslt.org/common"
                exclude-result-prefixes="cvs rng html db dbx exsl"
                version="2.0">

<!-- Terrible hack just to get the relative URIs right -->

<xsl:import href="../../../tools/xsl/purpose.xsl"/>

<xsl:variable name="rngfile"
	      select="'../../../src/lib/defguide.rnd'"/>

<xsl:variable name="rng" select="document($rngfile)"/>

</xsl:stylesheet>
