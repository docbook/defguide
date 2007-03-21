<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns='http://docbook.org/docbook-ng'
		xmlns:s="http://www.ascc.net/xml/schematron"
		xmlns:set="http://exslt.org/sets"
		xmlns:db='http://docbook.org/ns/docbook'
		xmlns:rng='http://relaxng.org/ns/structure/1.0'
		xmlns:xlink="http://www.w3.org/1999/xlink"
		xmlns:doc='http://nwalsh.com/xmlns/schema-doc/'
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		exclude-result-prefixes="db rng xlink doc s set"
                version="2.0">

<xsl:output method="text"/>

<xsl:key name="div" match="rng:div" use="db:refname"/>
<xsl:key name="element" match="rng:element" use="@name"/>
<xsl:key name="define" match="rng:define" use="@name"/>
<xsl:key name="elemdef" match="rng:define" use="rng:element/@name"/>

<xsl:variable name="raw-element-list" as="xs:string*">
  <xsl:for-each select="document('../tools/lib/defguide.rnd')//rng:define[rng:element]">
    <xsl:variable name="pattern" select="@name"/>
    <xsl:variable name="element" select="rng:element/@name"/>
    <xsl:choose>
      <xsl:when test="not($element)">
	<xsl:value-of select="()"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$element"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
</xsl:variable>

<xsl:variable name="element-list" as="xs:string*"
	      select="distinct-values($raw-element-list)"/>

<xsl:variable name="tags" select="//db:tag[not(@class) or @class='element']"/>

<xsl:variable name="missing-elements" as="xs:string*">
  <xsl:for-each select="$element-list">
    <xsl:sort order="ascending" data-type="text"/>
    <xsl:if test="not(. = $tags)">
      <xsl:value-of select="."/>
    </xsl:if>
  </xsl:for-each>
</xsl:variable>

<xsl:template match="/">
  <xsl:text>There are </xsl:text>
  <xsl:value-of select="count($missing-elements)"/>
  <xsl:text> missing elements in Chapter 2&#10;</xsl:text>
  <xsl:for-each select="$missing-elements">
    <xsl:value-of select="position()"/>
    <xsl:text>: </xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>&#10;</xsl:text>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
