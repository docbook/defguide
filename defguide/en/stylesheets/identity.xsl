<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://icl.com/saxon"
                exclude-result-prefixes="saxon"
                version="1.0">

  <xsl:output method="xml" indent="no"
              doctype-system="../../docbook/ebnf/dbebnf.dtd"/>

  <xsl:preserve-space elements="*"/>

  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="comment()|processing-instruction()|text()">
    <xsl:copy/>
  </xsl:template>
</xsl:stylesheet>
