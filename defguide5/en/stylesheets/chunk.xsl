<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://icl.com/saxon"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
		version="1.0"
                exclude-result-prefixes="doc"
                extension-element-prefixes="saxon">

<!-- THIS STYLESHEET IS FOR SAXON -->

<!-- Because I want to change the chunking rules, I need to copy the
     while stylesheet. The import/apply-imports trick won't work because
     the imported chunking code would chunk at the places where I want
     to avoid chunking. -->

<xsl:import href="tdg.xsl"/>

<xsl:param name="html.ext" select="'.html'"/>
<xsl:param name="root.filename" select="'docbook'"/>
<xsl:param name="base.dir" select="''"/>

<!-- ==================================================================== -->

<xsl:template match="bookinfo/copyright" mode="titlepage.mode">
  <xsl:choose>
    <xsl:when test="not(preceding-sibling::copyright)">
      <a href="{concat('dbcpyright',$html.ext)}">Copyright</a>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>Copyright</xsl:text>
    </xsl:otherwise>
  </xsl:choose>

  <xsl:text> &#xA9; </xsl:text>
  <xsl:for-each select="year">
    <xsl:if test="position() &gt; 1">, </xsl:if>
    <xsl:apply-templates select="." mode="titlepage.mode"/>
  </xsl:for-each>
  <xsl:text> </xsl:text>
  <xsl:apply-templates select="holder" mode="titlepage.mode"/>
  <xsl:text> </xsl:text>

  <xsl:if test="not(preceding-sibling::copyright)">
    <xsl:call-template name="write.chunk">
      <xsl:with-param name="filename">
	<xsl:call-template name="make-relative-filename">
	  <xsl:with-param name="base.dir" select="$base.dir"/>
	  <xsl:with-param name="base.name" select="concat('dbcpyright',$html.ext)"/>
	</xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
	<xsl:apply-templates select="/book" mode="dbcpyright-mode"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<xsl:template match="book" mode="dbcpyright-mode">
  <html>
    <xsl:call-template name="html.head"/>
    <body>
      <xsl:apply-templates select="bookinfo/legalnotice"
                           mode="titlepage.mode"/>
    </body>
  </html>
</xsl:template>

<!-- ==================================================================== -->
<!-- What's a chunk?

     appendix
     article
     bibliography  in article or book
     book
     chapter
     colophon
     glossary      in article or book
     index         in article or book
     part
     preface
     refentry
     reference
     set
     setindex
                                                                          -->
<!-- ==================================================================== -->

<xsl:template name="chunk">
  <xsl:param name="node" select="."/>
  <!-- returns 1 if $node is a chunk -->

  <xsl:choose>
    <xsl:when test="name($node)='preface'">1</xsl:when>
    <xsl:when test="name($node)='chapter'">1</xsl:when>
    <xsl:when test="name($node)='appendix'">1</xsl:when>
    <xsl:when test="name($node)='article'">1</xsl:when>
    <xsl:when test="name($node)='part'">1</xsl:when>
    <xsl:when test="name($node)='reference'">1</xsl:when>
    <xsl:when test="name($node)='refentry'">1</xsl:when>
    <xsl:when test="name($node)='index'">1</xsl:when>
    <xsl:when test="name($node)='bibliography'">1</xsl:when>
    <xsl:when test="name($node)='glossary'">1</xsl:when>
    <xsl:when test="name($node)='colophon'">1</xsl:when>
    <xsl:when test="name($node)='book'">1</xsl:when>
    <xsl:when test="name($node)='set'">1</xsl:when>
    <xsl:when test="name($node)='setindex'">1</xsl:when>
    <xsl:otherwise>0</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="*" mode="chunk-filename">
  <xsl:param name="recursive" select="false()"/>

  <!-- returns the filename of a chunk -->
  <xsl:variable name="ischunk"><xsl:call-template name="chunk"/></xsl:variable>
  <xsl:variable name="filename">
    <xsl:call-template name="dbhtml-filename"/>
  </xsl:variable>
  <xsl:variable name="dir">
    <xsl:call-template name="dbhtml-dir"/>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$ischunk='0'">
      <!-- if called on something that isn't a chunk, walk up... -->
      <xsl:choose>
        <xsl:when test="count(parent::*)>0">
          <xsl:apply-templates mode="chunk-filename" select="parent::*">
            <xsl:with-param name="recursive" select="$recursive"/>
          </xsl:apply-templates>
        </xsl:when>
        <!-- unless there is no up, in which case return "" -->
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <xsl:when test="not($recursive) and $filename != ''">
      <!-- if this chunk has an explicit name, use it -->
      <xsl:if test="$dir != ''">
        <xsl:value-of select="$dir"/>
        <xsl:text>/</xsl:text>
      </xsl:if>

      <xsl:choose>
        <!-- hack hack hack -->
        <xsl:when test="$html.ext != '.html'">
          <xsl:value-of select="substring-before($filename, '.html')"/>
          <xsl:value-of select="$html.ext"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$filename"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <xsl:when test="local-name(.)='set'">
      <xsl:value-of select="$root.filename"/>
      <xsl:if test="not($recursive)">
        <xsl:value-of select="$html.ext"/>
      </xsl:if>
    </xsl:when>

    <xsl:when test="local-name(.)='book'">
      <xsl:choose>
        <xsl:when test="count(parent::*)>0">
          <xsl:text>bk</xsl:text>
          <xsl:number level="any" format="01"/>
        </xsl:when>
        <xsl:otherwise>
	  <xsl:value-of select="$root.filename"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="not($recursive)">
        <xsl:value-of select="$html.ext"/>
      </xsl:if>
    </xsl:when>

    <xsl:when test="local-name(.)='article'">
      <xsl:choose>
        <xsl:when test="/set">
          <!-- in a set, make sure we inherit the right book info... -->
          <xsl:apply-templates mode="chunk-filename" select="parent::*">
            <xsl:with-param name="recursive" select="true()"/>
          </xsl:apply-templates>
        </xsl:when>
        <xsl:when test="count(parent::*)>0">
          <!-- if we aren't the root, name them numerically ... -->
          <xsl:text>ar</xsl:text>
          <xsl:number level="any" format="01" from="book"/>
        </xsl:when>
        <xsl:otherwise>
	  <xsl:value-of select="$root.filename"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="not($recursive)">
        <xsl:value-of select="$html.ext"/>
      </xsl:if>
    </xsl:when>

    <xsl:when test="local-name(.)='preface'">
      <xsl:if test="/set">
        <xsl:apply-templates mode="chunk-filename" select="parent::*">
          <xsl:with-param name="recursive" select="true()"/>
        </xsl:apply-templates>
      </xsl:if>
      <xsl:text>pr</xsl:text>
      <xsl:number level="any" format="01" from="book"/>
      <xsl:if test="not($recursive)">
        <xsl:value-of select="$html.ext"/>
      </xsl:if>
    </xsl:when>

    <xsl:when test="local-name(.)='chapter'">
      <xsl:if test="/set">
        <xsl:apply-templates mode="chunk-filename" select="parent::*">
          <xsl:with-param name="recursive" select="true()"/>
        </xsl:apply-templates>
      </xsl:if>
      <xsl:text>ch</xsl:text>
      <xsl:number level="any" format="01" from="book"/>
      <xsl:if test="not($recursive)">
        <xsl:value-of select="$html.ext"/>
      </xsl:if>
    </xsl:when>

    <xsl:when test="local-name(.)='appendix'">
      <xsl:if test="/set">
        <xsl:apply-templates mode="chunk-filename" select="parent::*">
          <xsl:with-param name="recursive" select="true()"/>
        </xsl:apply-templates>
      </xsl:if>
      <xsl:text>ap</xsl:text>
      <xsl:number level="any" format="a" from="book"/>
      <xsl:if test="not($recursive)">
        <xsl:value-of select="$html.ext"/>
      </xsl:if>
    </xsl:when>

    <xsl:when test="local-name(.)='part'">
      <xsl:if test="/set">
        <xsl:apply-templates mode="chunk-filename" select="parent::*">
          <xsl:with-param name="recursive" select="true()"/>
        </xsl:apply-templates>
      </xsl:if>
      <xsl:text>pt</xsl:text>
      <xsl:number level="any" format="01" from="book"/>
      <xsl:if test="not($recursive)">
        <xsl:value-of select="$html.ext"/>
      </xsl:if>
    </xsl:when>

    <xsl:when test="local-name(.)='reference'">
      <xsl:if test="/set">
        <xsl:apply-templates mode="chunk-filename" select="parent::*">
          <xsl:with-param name="recursive" select="true()"/>
        </xsl:apply-templates>
      </xsl:if>
      <xsl:text>rn</xsl:text>
      <xsl:number level="any" format="01" from="book"/>
      <xsl:if test="not($recursive)">
        <xsl:value-of select="$html.ext"/>
      </xsl:if>
    </xsl:when>

    <xsl:when test="local-name(.)='refentry'">
      <xsl:if test="parent::reference">
        <xsl:apply-templates mode="chunk-filename" select="parent::*">
          <xsl:with-param name="recursive" select="true()"/>
        </xsl:apply-templates>
      </xsl:if>
      <xsl:text>re</xsl:text>
      <xsl:number level="any" format="01" from="book"/>
      <xsl:if test="not($recursive)">
        <xsl:value-of select="$html.ext"/>
      </xsl:if>
    </xsl:when>

    <xsl:when test="local-name(.)='colophon'">
      <xsl:if test="/set">
        <xsl:apply-templates mode="chunk-filename" select="parent::*">
          <xsl:with-param name="recursive" select="true()"/>
        </xsl:apply-templates>
      </xsl:if>
      <xsl:text>co</xsl:text>
      <xsl:number level="any" format="01" from="book"/>
      <xsl:if test="not($recursive)">
        <xsl:value-of select="$html.ext"/>
      </xsl:if>
    </xsl:when>

    <xsl:when test="local-name(.)='bibliography'">
      <xsl:if test="/set">
        <xsl:apply-templates mode="chunk-filename" select="parent::*">
          <xsl:with-param name="recursive" select="true()"/>
        </xsl:apply-templates>
      </xsl:if>
      <xsl:text>bi</xsl:text>
      <xsl:number level="any" format="01" from="book"/>
      <xsl:if test="not($recursive)">
        <xsl:value-of select="$html.ext"/>
      </xsl:if>
    </xsl:when>

    <xsl:when test="local-name(.)='glossary'">
      <xsl:if test="/set">
        <xsl:apply-templates mode="chunk-filename" select="parent::*">
          <xsl:with-param name="recursive" select="true()"/>
        </xsl:apply-templates>
      </xsl:if>
      <xsl:text>go</xsl:text>
      <xsl:number level="any" format="01" from="book"/>
      <xsl:if test="not($recursive)">
        <xsl:value-of select="$html.ext"/>
      </xsl:if>
    </xsl:when>

    <xsl:when test="local-name(.)='index'">
      <xsl:if test="/set">
        <xsl:apply-templates mode="chunk-filename" select="parent::*">
          <xsl:with-param name="recursive" select="true()"/>
        </xsl:apply-templates>
      </xsl:if>
      <xsl:text>ix</xsl:text>
      <xsl:number level="any" format="01" from="book"/>
      <xsl:if test="not($recursive)">
        <xsl:value-of select="$html.ext"/>
      </xsl:if>
    </xsl:when>

    <xsl:when test="local-name(.)='setindex'">
      <xsl:text>si</xsl:text>
      <xsl:number level="any" format="01" from="set"/>
      <xsl:if test="not($recursive)">
        <xsl:value-of select="$html.ext"/>
      </xsl:if>
    </xsl:when>

    <xsl:otherwise>
      <xsl:text>chunk-filename-error-</xsl:text>
      <xsl:value-of select="local-name(.)"/>
      <xsl:number level="any" format="01" from="set"/>
      <xsl:if test="not($recursive)">
        <xsl:value-of select="$html.ext"/>
      </xsl:if>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="href.target">
  <xsl:param name="object" select="."/>
  <xsl:variable name="ischunk">
    <xsl:call-template name="chunk">
      <xsl:with-param name="node" select="$object"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:apply-templates mode="chunk-filename" select="$object"/>

  <xsl:if test="$ischunk='0'">
    <xsl:text>#</xsl:text>
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select="$object"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="html.head">
  <xsl:param name="prev" select="/foo"/>
  <xsl:param name="next" select="/foo"/>
  <xsl:variable name="home" select="/*[1]"/>
  <xsl:variable name="up" select="parent::*"/>

  <head>
    <xsl:call-template name="head.content"/>
    <xsl:call-template name="user.head.content"/>

    <xsl:if test="$home">
      <link rel="home">
        <xsl:attribute name="href">
          <xsl:call-template name="href.target">
            <xsl:with-param name="object" select="$home"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:attribute name="title">
          <xsl:apply-templates select="$home" mode="object.title.markup.textonly">
            <xsl:with-param name="text-only" select="'1'"/>
          </xsl:apply-templates>
        </xsl:attribute>
      </link>
    </xsl:if>

    <xsl:if test="$up">
      <link rel="up">
        <xsl:attribute name="href">
          <xsl:call-template name="href.target">
            <xsl:with-param name="object" select="$up"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:attribute name="title">
          <xsl:apply-templates select="$up" mode="object.title.markup.textonly">
            <xsl:with-param name="text-only" select="'1'"/>
          </xsl:apply-templates>
        </xsl:attribute>
      </link>
    </xsl:if>

    <xsl:if test="$prev">
      <link rel="previous">
        <xsl:attribute name="href">
          <xsl:call-template name="href.target">
            <xsl:with-param name="object" select="$prev"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:attribute name="title">
          <xsl:apply-templates select="$prev" mode="object.title.markup.textonly">
            <xsl:with-param name="text-only" select="'1'"/>
          </xsl:apply-templates>
        </xsl:attribute>
      </link>
    </xsl:if>

    <xsl:if test="$next">
      <link rel="next">
        <xsl:attribute name="href">
          <xsl:call-template name="href.target">
            <xsl:with-param name="object" select="$next"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:attribute name="title">
          <xsl:apply-templates select="$next" mode="object.title.markup.textonly">
            <xsl:with-param name="text-only" select="'1'"/>
          </xsl:apply-templates>
        </xsl:attribute>
      </link>
    </xsl:if>

    <xsl:if test=".//annotation">
      <script type="text/javascript" src="/script/AnchorPosition.js"/>
      <script type="text/javascript" src="/script/PopupWindow.js"/>
      <script type="text/javascript">
	<xsl:text>&#10;// Create PopupWindow objects</xsl:text>
	<xsl:for-each select=".//annotation">
	  <xsl:text>&#10;var popup_</xsl:text>
	  <xsl:value-of select="generate-id(.)"/>
	  <xsl:text> = new PopupWindow("popup-</xsl:text>
	  <xsl:value-of select="generate-id(.)"/>
	  <xsl:text>");&#10;</xsl:text>
	  <xsl:text>popup_</xsl:text>
	  <xsl:value-of select="generate-id(.)"/>
	  <xsl:text>.offsetY = 15;&#10;</xsl:text>
	  <xsl:text>popup_</xsl:text>
	  <xsl:value-of select="generate-id(.)"/>
	  <xsl:text>.autoHide();&#10;</xsl:text>
	</xsl:for-each>
      </script>
    </xsl:if>
  </head>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="header.navigation">
  <xsl:param name="prev" select="/foo"/>
  <xsl:param name="next" select="/foo"/>
  <xsl:variable name="home" select="/*[1]"/>
  <xsl:variable name="up" select="parent::*"/>

  <xsl:if test="$suppress.navigation = '0' and $suppress.header.navigation = '0'">
    <div class="navheader">
      <table border="0" cellpadding="0" cellspacing="0" width="100%"
             summary="Navigation table">
        <tr>
          <td align="left">
            <xsl:text>&#160;</xsl:text>
            <a>
              <xsl:attribute name="title">
                <xsl:apply-templates select="$home" mode="object.title.markup.textonly"/>
              </xsl:attribute>
              <xsl:attribute name="href">
                <xsl:call-template name="href.target">
                  <xsl:with-param name="object" select="$home"/>
                </xsl:call-template>
              </xsl:attribute>

              <img src="figures/nav-home.png" alt="Home" border="0"/>
            </a>
            <xsl:text>&#160;</xsl:text>

            <xsl:choose>
              <xsl:when test="count($prev)>0">
                <a>
                  <xsl:attribute name="title">
                    <xsl:apply-templates select="$prev" mode="object.title.markup.textonly"/>
                  </xsl:attribute>
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$prev"/>
                    </xsl:call-template>
                  </xsl:attribute>

                  <img src="figures/nav-prev.png" alt="Prev" border="0"/>
                </a>
              </xsl:when>
              <xsl:otherwise>
                <img src="figures/nav-xprev.png" alt="Prev" border="0"/>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:text>&#160;</xsl:text>

            <xsl:choose>
              <xsl:when test="count($up)>0">
                <a>
                  <xsl:attribute name="title">
                    <xsl:apply-templates select="$up" mode="object.title.markup.textonly"/>
                  </xsl:attribute>
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$up"/>
                    </xsl:call-template>
                  </xsl:attribute>

                  <img src="figures/nav-up.png" alt="Up" border="0"/>
                </a>
              </xsl:when>
              <xsl:otherwise>
                <img src="figures/nav-xup.png" alt="Up" border="0"/>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:text>&#160;</xsl:text>

            <xsl:choose>
              <xsl:when test="count($next)>0">
                <a>
                  <xsl:attribute name="title">
                    <xsl:apply-templates select="$next" mode="object.title.markup.textonly"/>
                  </xsl:attribute>
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$next"/>
                    </xsl:call-template>
                  </xsl:attribute>

                  <img src="figures/nav-next.png" alt="Next" border="0"/>
                </a>
              </xsl:when>
              <xsl:otherwise>
                <img src="figures/nav-xnext.png" alt="Next" border="0"/>
              </xsl:otherwise>
            </xsl:choose>
          </td>
          <td align="right">
            <i>DocBook: The Definitive Guide</i>
            <xsl:text> </xsl:text>
            <xsl:value-of select="/book/bookinfo/releaseinfo"/>
            <xsl:text> </xsl:text>
            <span class="alpha-version">
              <xsl:text>(</xsl:text>
              <a>
		<xsl:attribute name="href">co01.html</xsl:attribute>
                <em>Alpha</em>
              </a>
              <xsl:text>)</xsl:text>
            </span>
            <xsl:text> </xsl:text>
          </td>
        </tr>
      </table>
    </div>
  </xsl:if>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="footer.navigation">
  <xsl:param name="prev" select="/foo"/>
  <xsl:param name="next" select="/foo"/>
  <xsl:variable name="home" select="/*[1]"/>
  <xsl:variable name="up" select="parent::*"/>

  <xsl:if test="$suppress.navigation = '0' and $suppress.footer.navigation = '0'">
    <div class="navfooter">
      <table width="100%" summary="Navigation table">
        <tr>
          <td width="40%" align="left">
            <xsl:if test="count($prev)>0">
              <a>
                <xsl:attribute name="title">
                  <xsl:apply-templates select="$prev" mode="object.title.markup.textonly"/>
                </xsl:attribute>
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$prev"/>
                  </xsl:call-template>
                </xsl:attribute>

                <img src="figures/nav-prev.png" alt="Prev" border="0"/>
              </a>
            </xsl:if>
            <xsl:text>&#160;</xsl:text>
          </td>
          <td width="20%" align="center">
            <xsl:choose>
              <xsl:when test="$home != .">
                <a>
                  <xsl:attribute name="title">
                    <xsl:apply-templates select="$home" mode="object.title.markup.textonly"/>
                  </xsl:attribute>
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$home"/>
                    </xsl:call-template>
                  </xsl:attribute>

                  <img src="figures/nav-home.png" alt="Home" border="0"/>
                </a>
              </xsl:when>
              <xsl:otherwise>&#160;</xsl:otherwise>
            </xsl:choose>
          </td>
          <td width="40%" align="right">
            <xsl:text>&#160;</xsl:text>
            <xsl:if test="count($next)>0">
              <a>
                <xsl:attribute name="title">
                  <xsl:apply-templates select="$next" mode="object.title.markup.textonly"/>
                </xsl:attribute>
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$next"/>
                  </xsl:call-template>
                </xsl:attribute>

                <img src="figures/nav-next.png" alt="Next" border="0"/>
              </a>
            </xsl:if>
          </td>
        </tr>

        <tr>
          <td width="40%" align="left">
            <xsl:apply-templates select="$prev" mode="object.title.markup.textonly"/>
            <xsl:text>&#160;</xsl:text>
          </td>
          <td width="20%" align="center">
            <xsl:choose>
              <xsl:when test="count($up)>0">
                <a>
                  <xsl:attribute name="title">
                    <xsl:apply-templates select="$up" mode="object.title.markup.textonly"/>
                  </xsl:attribute>
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$up"/>
                    </xsl:call-template>
                  </xsl:attribute>

                  <img src="figures/nav-up.png" alt="Up" border="0"/>
                </a>
              </xsl:when>
              <xsl:otherwise>&#160;</xsl:otherwise>
            </xsl:choose>
          </td>
          <td width="40%" align="right">
            <xsl:text>&#160;</xsl:text>
            <xsl:apply-templates select="$next" mode="object.title.markup.textonly"/>
          </td>
        </tr>
      </table>
    </div>
  </xsl:if>
</xsl:template>

<xsl:template name="X.footer.navigation">
  <xsl:param name="prev" select="/foo"/>
  <xsl:param name="next" select="/foo"/>
  <xsl:variable name="home" select="/*[1]"/>
  <xsl:variable name="up" select="parent::*"/>

  <xsl:if test="$suppress.navigation = '0' and $suppress.footer.navigation = '0'">
    <div class="navfooter">
      <table width="100%" summary="Navigation table">
        <tr>
          <td width="40%" align="left">
            <xsl:if test="count($prev)>0">
              <a>
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$prev"/>
                  </xsl:call-template>
                </xsl:attribute>
                <xsl:call-template name="gentext.nav.prev"/>
              </a>
            </xsl:if>
            <xsl:text>&#160;</xsl:text>
          </td>
          <td width="20%" align="center">
            <xsl:choose>
              <xsl:when test="$home != .">
                <a>
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$home"/>
                    </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="gentext.nav.home"/>
                </a>
              </xsl:when>
              <xsl:otherwise>&#160;</xsl:otherwise>
            </xsl:choose>
          </td>
          <td width="40%" align="right">
            <xsl:text>&#160;</xsl:text>
            <xsl:if test="count($next)>0">
              <a>
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$next"/>
                  </xsl:call-template>
                </xsl:attribute>
                <xsl:call-template name="gentext.nav.next"/>
              </a>
            </xsl:if>
          </td>
        </tr>

        <tr>
          <td width="40%" align="left">
            <xsl:apply-templates select="$prev" mode="object.title.markup.textonly"/>
            <xsl:text>&#160;</xsl:text>
          </td>
          <td width="20%" align="center">
            <xsl:choose>
              <xsl:when test="count($up)>0">
                <a>
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$up"/>
                    </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="gentext.nav.up"/>
                </a>
              </xsl:when>
              <xsl:otherwise>&#160;</xsl:otherwise>
            </xsl:choose>
          </td>
          <td width="40%" align="right">
            <xsl:text>&#160;</xsl:text>
            <xsl:apply-templates select="$next" mode="object.title.markup.textonly"/>
          </td>
        </tr>
      </table>
    </div>
  </xsl:if>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="processing-instruction('dbhtml')">
  <!-- nop -->
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="process-chunk-element">
  <xsl:param name="root" select="count(parent::*) &gt; 0"/>

  <xsl:variable name="prev"
    select="(preceding::book[1]
             |preceding::preface[1]
             |preceding::chapter[1]
             |preceding::appendix[1]
             |preceding::part[1]
             |preceding::reference[1]
             |preceding::refentry[1]
             |preceding::colophon[1]
             |preceding::article[1]
             |preceding::bibliography[1]
             |preceding::glossary[1]
             |preceding::index[1]
             |preceding::setindex[1]
             |ancestor::set
             |ancestor::book[1]
             |ancestor::preface[1]
             |ancestor::chapter[1]
             |ancestor::appendix[1]
             |ancestor::part[1]
             |ancestor::reference[1]
             |ancestor::article[1])[last()]"/>

  <xsl:variable name="next"
    select="(following::book[1]
             |following::preface[1]
             |following::chapter[1]
             |following::appendix[1]
             |following::part[1]
             |following::reference[1]
             |following::refentry[1]
             |following::colophon[1]
             |following::bibliography[1]
             |following::glossary[1]
             |following::index[1]
             |following::article[1]
             |following::setindex[1]
             |descendant::book[1]
             |descendant::preface[1]
             |descendant::chapter[1]
             |descendant::appendix[1]
             |descendant::article[1]
             |descendant::bibliography[1]
             |descendant::glossary[1]
             |descendant::index[1]
             |descendant::colophon[1]
             |descendant::setindex[1]
             |descendant::part[1]
             |descendant::reference[1]
             |descendant::refentry[1])[1]"/>

  <xsl:variable name="ischunk">
    <xsl:call-template name="chunk"/>
  </xsl:variable>

  <xsl:variable name="chunkfn">
    <xsl:if test="$ischunk='1'">
      <xsl:apply-templates mode="chunk-filename" select="."/>
    </xsl:if>
  </xsl:variable>

  <xsl:if test="$ischunk='0'">
    <xsl:message>
      <xsl:text>Error </xsl:text>
      <xsl:value-of select="name(.)"/>
      <xsl:text> is not a chunk!</xsl:text>
    </xsl:message>
  </xsl:if>

  <xsl:variable name="filename">
    <xsl:call-template name="make-relative-filename">
      <xsl:with-param name="base.dir" select="$base.dir"/>
      <xsl:with-param name="base.name" select="$chunkfn"/>
    </xsl:call-template>
  </xsl:variable>

  <!-- processing the whole book and the index in the same pass -->
  <!-- causes out-of-memory errors. So don't do that. -->
  <xsl:if test="local-name(.) != 'index' or $rootid != ''">
    <xsl:call-template name="write.chunk">
      <xsl:with-param name="filename" select="$filename"/>
      <xsl:with-param name="content">
        <xsl:call-template name="chunk-element-content">
          <xsl:with-param name="prev" select="$prev"/>
          <xsl:with-param name="next" select="$next"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="chunk-element-content">
  <xsl:param name="prev"></xsl:param>
  <xsl:param name="next"></xsl:param>

  <html>
    <xsl:call-template name="html.head">
      <xsl:with-param name="prev" select="$prev"/>
      <xsl:with-param name="next" select="$next"/>
    </xsl:call-template>

    <body>
      <xsl:if test=". != /book">
        <xsl:call-template name="user.header.navigation"/>

        <xsl:call-template name="header.navigation">
          <xsl:with-param name="prev" select="$prev"/>
          <xsl:with-param name="next" select="$next"/>
        </xsl:call-template>

        <xsl:call-template name="user.header.content"/>
      </xsl:if>

      <xsl:apply-imports/>

      <xsl:if test=". != /book">
        <xsl:call-template name="user.footer.content"/>

        <xsl:call-template name="footer.navigation">
          <xsl:with-param name="prev" select="$prev"/>
          <xsl:with-param name="next" select="$next"/>
        </xsl:call-template>

        <xsl:call-template name="user.footer.navigation"/>
      </xsl:if>

      <xsl:if test=".//annotation">
	<div class="annotation-list">
	  <div class="annotation-nocss">
	    <p>The following annotations are from this page. You are seeing
	    them here because your browser doesn’t support the user-interface
	    techniques used to make them appear as ‘popups’ on modern browsers.
	    </p>
	  </div>

	  <xsl:apply-templates select=".//annotation"
			       mode="annotation-popup"/>
	</div>
      </xsl:if>
    </body>
  </html>
</xsl:template>

<xsl:template match="annotation">
  <xsl:variable name="title">
    <xsl:text>[Annotation #</xsl:text>
    <xsl:number count="annotation" level="any" format="1"/>
    <xsl:text>]</xsl:text>
  </xsl:variable>

  <a href="#annot-{generate-id(.)}" title="{$title}"
     name="anch-{generate-id(.)}" id="anch-{generate-id(.)}">
    <xsl:attribute name="onClick">
      <xsl:text>popup_</xsl:text>
      <xsl:value-of select="generate-id(.)"/>
      <xsl:text>.showPopup('anch-</xsl:text>
      <xsl:value-of select="generate-id(.)"/>
      <xsl:text>'); return false;</xsl:text>
    </xsl:attribute>
    <img src="/graphics/annot.png" border="0" alt="{$title}"/>
  </a>
</xsl:template>

<xsl:template match="annotation" mode="annotation-popup">
  <div class="annotation-nocss">
    <p>
      <a name="annot-{generate-id(.)}"/>
      <xsl:text>Annotation #</xsl:text>
      <xsl:number count="annotation[@class='block']" level="any" format="1"/>
      <xsl:text>:</xsl:text>
    </p>
  </div>

  <div id="popup-{generate-id(.)}" class="annotation-popup">
    <xsl:if test="string-length(.) &gt; 300">
      <xsl:attribute name="style">width:400px</xsl:attribute>
    </xsl:if>

    <xsl:call-template name="annotation-title"/>
    <div class="annotation-body">
      <xsl:apply-templates select="*[local-name(.) != 'title']"/>
    </div>
    <div class="annotation-close">
      <a href="#" onclick="popup_{generate-id(.)}.hidePopup();return false;">
	<img src="/graphics/close.png" alt="X" border="0"/>
      </a>
    </div>
  </div>
</xsl:template>

<xsl:template name="annotation-title">
  <div class="annotation-title">
    <xsl:choose>
      <xsl:when test="title">
	<xsl:apply-templates select="title/node()"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>Annotation</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </div>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="/set|/book|/part|/preface|/chapter|/appendix
                     |/article|/reference|/refentry
                     |/glossary|/bibliography|/colophon
                     |/setindex|/index"
              priority="2">
  <xsl:call-template name="process-chunk-element">
    <xsl:with-param name="root" select="'1'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="set|book|part|preface|chapter|appendix
                     |article
                     |reference|refentry
                     |book/glossary|article/glossary
                     |book/bibliography|article/bibliography
                     |colophon">
  <xsl:call-template name="process-chunk-element"/>
</xsl:template>

<xsl:template match="setindex
                     |book/index
                     |article/index">
  <!-- some implementations use completely empty index tags to indicate -->
  <!-- where an automatically generated index should be inserted. so -->
  <!-- if the index is completely empty, skip it. -->
  <xsl:if test="count(*)>0 or $generate.index != '0'">
    <xsl:call-template name="process-chunk-element"/>
  </xsl:if>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>
