<p:declare-step version='1.0' xmlns:p="http://www.w3.org/ns/xproc">
<p:input port="source" />
<p:output port="result" />
<p:input port="parameters" kind="parameter"/>

<p:option name="not-condition" select="'compact print'"/>
<p:option name="condition" select="''"/>
<p:option name="not-arch" select="''"/>
<p:option name="arch" select="'defguide5'"/>
<p:option name="revision" required="true"/>

<p:import href="../publishers/build/docbook/xslt/base/pipelines/docbook.xpl"/>

<p:variable name="srcbase" select="base-uri(/)"/>

<p:xslt name="tdg2db">
  <p:input port="stylesheet">
    <p:document href="../stylesheets/tdg2db.xsl"/>
  </p:input>
</p:xslt>

<p:xslt name="profiled">
  <p:input port="stylesheet">
    <p:document href="../stylesheets/profile.xsl"/>
  </p:input>
  <p:with-param name="condition" select="$condition"/>
  <p:with-param name="not-condition" select="$not-condition"/>
  <p:with-param name="arch" select="$arch"/>
  <p:with-param name="not-arch" select="$not-arch"/>
  <p:with-param name="revision" select="$revision"/>
  <p:log port="result" href="/tmp/tdg-profile.xml"/>
</p:xslt>

<p:load name="purpose.xsl">
  <p:with-option name="href"
                 select="resolve-uri('../style/purpose.xsl', $srcbase)"/>
</p:load>

<p:xslt>
  <p:input port="source">
    <p:pipe step="profiled" port="result"/>
  </p:input>
  <p:input port="stylesheet">
    <p:pipe step="purpose.xsl" port="result"/>
  </p:input>
</p:xslt>

<p:delete match="*/@xml:base"/>

</p:declare-step>
