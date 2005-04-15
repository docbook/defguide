<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="2.0">

  <xsl:output method="text"/>

  <xsl:strip-space elements="*"/>

  <xsl:template match="dtd">
    <xsl:for-each select="element">
      <xsl:sort data-type="text" select="@name"/>
      <xsl:variable name="name" select="@name"/>

      <xsl:variable name="elems">
	<xsl:for-each select="content-model-expanded//element-name">
	  <elem name="{@name}"/>
	</xsl:for-each>
      </xsl:variable>

      <xsl:if test="content-model-expanded//pcdata">
	<xsl:value-of select="$name"/>
	<xsl:text>: #PCDATA&#10;</xsl:text>
      </xsl:if>

      <xsl:for-each-group select="$elems/elem" group-by="@name">
	<xsl:sort data-type="text" select="current-grouping-key()"/>
	<xsl:value-of select="$name"/>
	<xsl:text>: </xsl:text>
	<xsl:value-of select="current-grouping-key()"/>
	<xsl:text>&#10;</xsl:text>
      </xsl:for-each-group>

      <xsl:if test="content-model/empty">
	<xsl:value-of select="$name"/>
	<xsl:text>: EMPTY&#10;</xsl:text>
      </xsl:if>

      <xsl:text>&#10;</xsl:text>

    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
