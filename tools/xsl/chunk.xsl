<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:ch="http://docbook.sf.net/xmlns/chunk"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:f="http://docbook.org/xslt/ns/extension"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:h="http://www.w3.org/1999/xhtml"
                xmlns:m="http://docbook.org/xslt/ns/mode"
                xmlns:mp="http://docbook.org/xslt/ns/mode/private"
                xmlns:t="http://docbook.org/xslt/ns/template"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="ch db f fn h m mp t xs"
                version="2.0">

<xsl:import href="https://cdn.docbook.org/release/xsl20/current/xslt/base/html/chunk.xsl"/>
<!--
<xsl:import href="../../../xslt20/build/xslt/base/html/chunk.xsl"/>
-->

<xsl:include href="custom.xsl"/>
<xsl:param name="chunk.section.depth" select="0"/>

<!-- DELETE THESE TEMPLATES WHEN 2.5.1+ LANDS IN MAVEN -->
<!-- VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV -->

<xsl:template match="db:refentry">
  <article>
    <xsl:sequence select="f:html-attributes(., f:node-id(.))"/>

    <xsl:if test="$refentry.separator and preceding-sibling::db:refentry">
      <div class="refentry-separator">
        <hr/>
      </div>
    </xsl:if>

    <xsl:call-template name="t:titlepage"/>

    <div class="content">
      <xsl:apply-templates/>
    </div>

    <xsl:call-template name="t:process-footnotes"/>
  </article>
</xsl:template>

<xsl:template match="db:refnamediv">
  <div>
    <xsl:sequence select="f:html-attributes(., f:node-id(.))"/>

    <xsl:choose>
      <xsl:when test="$refentry.generate.name">
        <h2>
          <xsl:call-template name="gentext">
            <xsl:with-param name="key" select="'RefName'"/>
          </xsl:call-template>
        </h2>
      </xsl:when>

      <xsl:when test="$refentry.generate.title">
        <h2>
          <xsl:choose>
            <xsl:when test="../db:refmeta/db:refentrytitle">
              <xsl:apply-templates select="../db:refmeta/db:refentrytitle"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="db:refname[1]"/>
            </xsl:otherwise>
          </xsl:choose>
        </h2>
      </xsl:when>
    </xsl:choose>
    <p>
      <xsl:apply-templates/>
    </p>
  </div>
</xsl:template>

<xsl:template match="db:refsynopsisdiv">
  <div>
    <xsl:sequence select="f:html-attributes(., f:node-id(.))"/>

    <h2>
      <xsl:choose>
        <xsl:when test="db:info/db:title">
          <xsl:apply-templates select="db:info/db:title"
                               mode="m:titlepage-mode"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="gentext">
            <xsl:with-param name="key" select="'RefSynopsisDiv'"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </h2>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<!-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ -->

<xsl:template match="*" mode="m:user-header-content">
  <xsl:param name="node" select="."/>
  <xsl:param name="next" select="()"/>
  <xsl:param name="prev" select="()"/>
  <xsl:param name="up" select="()"/>
  <xsl:variable name="home" select="root($node)/*"/>

  <div class="navigation">
    <a title="{/db:book/db:info/db:title}" href="{f:href($node, $home)}">
      <i class="fas fa-home"></i>
    </a>
    <xsl:text>&#160;</xsl:text>

    <xsl:choose>
      <xsl:when test="count($prev)>0">
        <a href="{f:href($node, $prev)}" title="{f:title-content($prev, false())}">
          <i class="fas fa-arrow-left"></i>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <span class="inactive">
          <i class="fas fa-arrow-left"></i>
        </span>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>&#160;</xsl:text>

    <xsl:choose>
      <xsl:when test="count($up)>0">
        <a title="{f:title-content($up, false())}" href="{f:href($node, $up)}">
          <i class="fas fa-arrow-up"></i>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <span class="inactive">
          <i class="fas fa-arrow-up"></i>
        </span>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>&#160;</xsl:text>

    <xsl:choose>
      <xsl:when test="count($next)>0">
        <a title="{f:title-content($next, false())}" href="{f:href($node, $next)}">
          <i class="fas fa-arrow-right"></i>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <span class="inactive">
          <i class="fas fa-arrow-right"></i>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </div>
  
  <div class="title">
    <i class="title"><xsl:value-of select="/db:book/db:info/db:title"/></i>
    <span class="version">
      <xsl:text>  (Version </xsl:text>
      <a href="ch00-online.html">
        <xsl:value-of select="/db:book/db:info/db:releaseinfo[not(@role)]"/>
      </a>
      <xsl:text>)</xsl:text>
    </span>
  </div>
</xsl:template>

<xsl:template match="*" mode="m:user-footer-content">
  <xsl:param name="node" select="."/>
  <xsl:param name="next" select="()"/>
  <xsl:param name="prev" select="()"/>
  <xsl:param name="up" select="()"/>
  <xsl:variable name="home" select="root($node)/*"/>

  <div class="navrow">
    <div class="navleft">
      <xsl:if test="count($prev)>0">
        <a title="{f:title-content($prev, false())}" href="{f:href($node, $prev)}">
          <i class="fas fa-arrow-left"></i>
        </a>
      </xsl:if>
    </div>
    <div class="navmiddle">
      <xsl:if test="exists($home)">
        <a title="{f:title-content($home, false())}" href="{f:href($node, $home)}">
          <i class="fas fa-home"></i>
        </a>
      </xsl:if>
    </div>
    <div class="navright">
      <xsl:if test="count($next)>0">
        <a title="{f:title-content($next, false())}" href="{f:href($node, $next)}">
          <i class="fas fa-arrow-right"></i>
        </a>
      </xsl:if>
    </div>
  </div>

  <div class="navrow">
    <div class="navleft">
      <xsl:value-of select="f:title-content($prev, false())"/>
    </div>
    <div class="navmiddle">
      <xsl:if test="count($up)>0">
        <a title="{f:title-content($up, false())}" href="{f:href($node, $up)}">
          <i class="fas fa-arrow-up"></i>
        </a>
      </xsl:if>
    </div>
    <div class="navright">
      <xsl:value-of select="f:title-content($next, false())"/>
    </div>
  </div>

  <xsl:if test="$node/db:info/db:releaseinfo[@role='hash']">
    <xsl:variable name="hash"
                  select="$node/db:info/db:releaseinfo[@role='hash']"/>

    <div class="infofooter">
      <xsl:text>Last revised by </xsl:text>
      <xsl:value-of
          select="substring-before($node/db:info/db:releaseinfo[@role='author'],
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
      <span class="githash" title="{$hash}">
        <xsl:text>(git hash: </xsl:text>
        <xsl:value-of select="concat(substring($hash, 1, 6), '…')"/>
        <xsl:text>)</xsl:text>
      </span>
    </div>
  </xsl:if>

  <div class="copyrightfooter">
    <a href="dbcpyright.html">Copyright</a>
    <xsl:text> &#xA9; </xsl:text>
    <xsl:value-of select="/db:book/db:info/db:copyright/db:year[1]"/>
    <xsl:text>–</xsl:text>
    <xsl:value-of select="/db:book/db:info/db:copyright/db:year[last()]"/>
    <xsl:text> Norman Walsh.</xsl:text>
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

<xsl:template match="*" mode="m:chunk">
  <xsl:variable name="chunkfn" select="f:chunk-filename(.)"/>
  <xsl:variable name="pinav"
                select="(f:pi(./processing-instruction('dbhtml'), 'navigation'),'true')[1]"/>

  <xsl:variable name="chunk" select="key('id', generate-id(.), $chunk-tree)"/>
  <xsl:variable name="nchunk" select="($chunk/following::h:chunk|$chunk/descendant::h:chunk)[1]"/>
  <xsl:variable name="pchunk" select="($chunk/preceding::h:chunk|$chunk/parent::h:chunk)[last()]"/>
  <xsl:variable name="uchunk" select="$chunk/ancestor::h:chunk[1]"/>

  <xsl:result-document href="{$base.dir}{$chunkfn}" method="xhtml" indent="no">
    <xsl:apply-templates select="." mode="m:pre-root"/>
    <html>
      <head>
        <xsl:apply-templates select="." mode="mp:html-head"/>
      </head>
      <body>
        <xsl:if test="self::db:book">
          <xsl:attribute name="id" select="'bookhome'"/>
        </xsl:if>
        <xsl:call-template name="t:body-attributes"/>
        <xsl:if test="@status">
          <xsl:attribute name="class" select="@status"/>
        </xsl:if>
        <article>
          <header>
            <xsl:if test="$pinav = 'true'">
              <xsl:apply-templates select="." mode="m:user-header-content">
                <xsl:with-param name="node" select="."/>
                <xsl:with-param name="next" select="key('genid', $nchunk/@xml:id)"/>
                <xsl:with-param name="prev" select="key('genid', $pchunk/@xml:id)"/>
                <xsl:with-param name="up" select="key('genid', $uchunk/@xml:id)"/>
              </xsl:apply-templates>
            </xsl:if>
          </header>

          <main>
            <xsl:apply-templates select=".">
              <xsl:with-param name="override-chunk" select="true()"/>
            </xsl:apply-templates>
          </main>

          <footer>
            <xsl:if test="$pinav = 'true'">
              <xsl:apply-templates select="." mode="m:user-footer-content">
                <xsl:with-param name="node" select="."/>
                <xsl:with-param name="next" select="key('genid', $nchunk/@xml:id)"/>
                <xsl:with-param name="prev" select="key('genid', $pchunk/@xml:id)"/>
                <xsl:with-param name="up" select="key('genid', $uchunk/@xml:id)"/>
              </xsl:apply-templates>
            </xsl:if>
          </footer>
        </article>
      </body>
    </html>
  </xsl:result-document>
</xsl:template>

</xsl:stylesheet>
