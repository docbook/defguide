<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:rng='http://relaxng.org/ns/structure/1.0'
                xmlns:xi='http://www.w3.org/2001/XInclude'
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="db rng xs"
		version="2.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"
	    omit-xml-declaration="yes"/>

<xsl:template match="/">
  <xsl:variable name="items" as="element(item)*">
    <xsl:apply-templates select="//rng:define[rng:element]"/>
  </xsl:variable>

  <list>
    <xsl:for-each select="$items">
      <xsl:sort select="."/>
      <xsl:choose>
        <xsl:when test=". = 'dcterms.any'">
          <item>dcterms</item>
        </xsl:when>
        <xsl:when test="starts-with(.,'dcterms.')">
          <!-- suppress -->
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </list>
</xsl:template>

<xsl:template match="rng:define">
  <item>
    <!-- Work around the irregular naming conventions of the XML files -->
    <xsl:choose>
      <xsl:when test="starts-with(@name,'db.cals.')">
        <xsl:value-of select="substring-after(@name, 'db.cals.')"/>
      </xsl:when>
      <xsl:when test="starts-with(@name,'db.')">
        <xsl:value-of select="substring-after(@name, 'db.')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@name"/>
      </xsl:otherwise>
    </xsl:choose>
  </item>
</xsl:template>

</xsl:stylesheet>
