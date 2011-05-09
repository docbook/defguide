<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns='http://docbook.org/docbook-ng'
		xmlns:s="http://www.ascc.net/xml/schematron"
		xmlns:set="http://exslt.org/sets"
		xmlns:db='http://docbook.org/ns/docbook'
		xmlns:rng='http://relaxng.org/ns/structure/1.0'
		xmlns:xlink="http://www.w3.org/1999/xlink"
		xmlns:doc='http://nwalsh.com/xmlns/schema-doc/'
		exclude-result-prefixes="db rng xlink doc s set"
                version="1.0">

<xsl:output method="text"/>

<xsl:key name="div" match="rng:div" use="db:refname"/>
<xsl:key name="element" match="rng:element" use="@name"/>
<xsl:key name="define" match="rng:define" use="@name"/>
<xsl:key name="elemdef" match="rng:define" use="rng:element/@name"/>

<xsl:template match="/">
  <xsl:for-each select="//rng:define[rng:element]">
    <xsl:variable name="pattern" select="@name"/>
    <xsl:variable name="element" select="rng:element/@name"/>
    <xsl:choose>
      <xsl:when test="not($element)">ANY</xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$element"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text> </xsl:text>
    <xsl:value-of select="count(key('elemdef', $element))"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$pattern"/>
    <xsl:text>&#10;</xsl:text>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
