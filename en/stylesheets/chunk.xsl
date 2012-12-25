<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:ch="http://docbook.sf.net/xmlns/chunk"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:f="http://docbook.org/xslt/ns/extension"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:h="http://www.w3.org/1999/xhtml"
                xmlns:m="http://docbook.org/xslt/ns/mode"
                xmlns:t="http://docbook.org/xslt/ns/template"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="ch db f fn h m t xs"
                version="2.0">

<xsl:import href="/Volumes/Data/docbook/xslt20/xslt/base/html/chunk.xsl"/>
<xsl:include href="custom.xsl"/>

<xsl:param name="chunk.section.depth" select="0"/>

<xsl:template name="t:user-header-content">
  <xsl:param name="node" select="."/>
  <xsl:param name="next" select="()"/>
  <xsl:param name="prev" select="()"/>
  <xsl:param name="up" select="()"/>
  <xsl:variable name="home" select="root($node)/*"/>

  <div class="navheader">
    <table border="0" cellpadding="0" cellspacing="0" width="100%"
           summary="Navigation table">
      <tr>
        <td align="left">
          <xsl:text>&#160;</xsl:text>
          <a title="{/db:book/db:info/db:title}" href="{f:href($node, $home)}">
            <img src="{/db:book/db:info/db:releaseinfo[@role='nav-home']}" alt="Home" border="0"/>
          </a>
          <xsl:text>&#160;</xsl:text>

          <xsl:choose>
            <xsl:when test="count($prev)>0">
              <a href="{f:href($node, $prev)}" title="{f:title-content($prev, false())}">
                <img src="figs/web/nav/prev.png" alt="Prev" border="0"/>
              </a>
            </xsl:when>
            <xsl:otherwise>
              <img src="figs/web/nav/xprev.png" alt="Prev" border="0"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>&#160;</xsl:text>

          <xsl:choose>
            <xsl:when test="count($up)>0">
              <a title="{f:title-content($up, false())}" href="{f:href($node, $up)}">
                <img src="figs/web/nav/up.png" alt="Up" border="0"/>
              </a>
            </xsl:when>
            <xsl:otherwise>
              <img src="figs/web/nav/xup.png" alt="Up" border="0"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>&#160;</xsl:text>

          <xsl:choose>
            <xsl:when test="count($next)>0">
              <a title="{f:title-content($next, false())}" href="{f:href($node, $next)}">
                <img src="figs/web/nav/next.png" alt="Next" border="0"/>
              </a>
            </xsl:when>
            <xsl:otherwise>
              <img src="figs/web/nav/xnext.png" alt="Next" border="0"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <td align="right">
          <i><xsl:value-of select="/db:book/db:info/db:title"/></i>
          <xsl:text> (Version </xsl:text>
          <a href="ch00-online.html">
            <xsl:value-of select="/db:book/db:info/db:releaseinfo[not(@role)]"/>
          </a>
          <xsl:text>)</xsl:text>
        </td>
      </tr>
    </table>
  </div>
</xsl:template>

<xsl:template name="t:user-footer-content">
  <xsl:param name="node" select="."/>
  <xsl:param name="next" select="()"/>
  <xsl:param name="prev" select="()"/>
  <xsl:param name="up" select="()"/>
  <xsl:variable name="home" select="root($node)/*"/>

  <div class="footers">
    <div class="navfooter">
      <table width="100%" summary="Navigation table">
        <tr>
          <td width="40%" align="left">
            <xsl:if test="count($prev)>0">
              <a title="{f:title-content($prev, false())}" href="{f:href($node, $prev)}">
                <img src="figs/web/nav/prev.png" alt="Prev" border="0"/>
              </a>
            </xsl:if>
            <xsl:text>&#160;</xsl:text>
          </td>
          <td width="20%" align="center">
            <xsl:choose>
              <xsl:when test="exists($home)">
                <a title="{f:title-content($home, false())}" href="{f:href($node, $home)}">
                  <img src="{/db:book/db:info/db:releaseinfo[@role='nav-home']}"
                       alt="Home" border="0"/>
                </a>
              </xsl:when>
              <xsl:otherwise>&#160;</xsl:otherwise>
            </xsl:choose>
          </td>
          <td width="40%" align="right">
            <xsl:text>&#160;</xsl:text>
            <xsl:if test="count($next)>0">
              <a title="{f:title-content($next, false())}" href="{f:href($node, $next)}">
                <img src="figs/web/nav/next.png" alt="Next" border="0"/>
              </a>
            </xsl:if>
          </td>
        </tr>

        <tr>
          <td width="40%" align="left">
            <xsl:value-of select="f:title-content($prev, false())"/>
            <xsl:text>&#160;</xsl:text>
          </td>
          <td width="20%" align="center">
            <xsl:choose>
              <xsl:when test="count($up)>0">
                <a title="{f:title-content($up, false())}" href="{f:href($node, $up)}">
                  <img src="figs/web/nav/up.png" alt="Up" border="0"/>
                </a>
              </xsl:when>
              <xsl:otherwise>&#160;</xsl:otherwise>
            </xsl:choose>
          </td>
          <td width="40%" align="right">
            <xsl:text>&#160;</xsl:text>
            <xsl:value-of select="f:title-content($next, false())"/>
          </td>
        </tr>
      </table>
    </div>

    <xsl:if test="$node/db:info/db:releaseinfo[@role='hash']">
      <div class="infofooter">
        <xsl:text>Last revised by </xsl:text>
        <xsl:value-of select="substring-before($node/db:info/db:releaseinfo[@role='author'],
                                               ' &lt;')"/>
        <xsl:text> on </xsl:text>
        <xsl:for-each select="$node/db:info/db:pubdate">
          <!-- hack: there should be only one -->
          <xsl:if test=". castable as xs:dateTime">
            <xsl:value-of select="format-dateTime(. cast as xs:dateTime,
                                                  '[D1] [MNn,*-3] [Y0001]')"/>
          </xsl:if>
        </xsl:for-each>
        <xsl:text> </xsl:text>
        <span class="githash">
          <xsl:text>(git hash: </xsl:text>
          <xsl:value-of select="$node/db:info/db:releaseinfo[@role='hash']"/>
          <xsl:text>)</xsl:text>
        </span>
      </div>
    </xsl:if>

    <div class="copyrightfooter">
      <p>
        <a href="dbcpyright.html">Copyright</a>
        <xsl:text> &#xA9; </xsl:text>
        <xsl:for-each select="/db:book/db:info/db:copyright/db:year">
          <xsl:if test="position() &gt; 1">, </xsl:if>
          <xsl:value-of select="."/>
        </xsl:for-each>
        <xsl:text> Norman Walsh.</xsl:text>
      </p>
    </div>
  </div>
</xsl:template>

<xsl:function name="f:title-content" as="node()*">
  <xsl:param name="node" as="node()?"/>
  <xsl:param name="allow-anchors" as="xs:boolean"/>
  <xsl:choose>
    <xsl:when test="empty($node)"/>
    <xsl:otherwise>
      <xsl:apply-templates select="$node" mode="m:title-content">
        <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
      </xsl:apply-templates>
    </xsl:otherwise>
  </xsl:choose>
</xsl:function>

</xsl:stylesheet>
