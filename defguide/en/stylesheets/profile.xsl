<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<!-- Generate DocBook instance with correct DOCTYPE -->
<xsl:output method="xml"
            doctype-public="-//OASIS//DTD DocBook XML V4.1.2//EN"
            doctype-system="http://www.oasis-open.org/docbook/xml/4.0/docbookx.dtd"/>

<xsl:param name="output.media" select="'online'"/>

<!-- Copy all non-element nodes -->
<xsl:template match="@*|text()|comment()|processing-instruction()">
  <xsl:copy/>
</xsl:template>

<!-- Profile elements based on output.media -->
<xsl:template match="*">
  <xsl:if test="not(@condition) or @condition=$output.media">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
