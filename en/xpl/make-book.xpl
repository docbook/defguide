<p:declare-step version='1.0' xmlns:p="http://www.w3.org/ns/xproc">
<p:input port="source" />
<p:output port="result" />
<p:input port="parameters" kind="parameter"/>

<p:option name="condition" select="''"/>
<p:option name="arch" select="'defguide5'"/>
<p:option name="revision" required="true"/>

<!--
<p:import href="../defguide5/build/docbook/xslt/base/pipelines/docbook.xpl"/>
-->

<p:variable name="srcbase" select="base-uri(/)"/>

<p:xslt name="tdg2db">
  <p:input port="stylesheet">
    <p:document href="../stylesheets/tdg2db.xsl"/>
  </p:input>
</p:xslt>

<p:xslt name="profiled">
  <p:input port="stylesheet">
    <!-- FIXME: why doesn't the full URI work with the rewriter?
    <p:document href="https://cdn.docbook.org/release/latest/xslt/base/preprocess/30-profile.xsl"/>
    -->
    <p:document href="../stylesheets/30-profile.xsl"/>
  </p:input>
  <p:with-param name="profile.separator" select="' '"/>
  <p:with-param name="profile.condition" select="$condition"/>
  <p:with-param name="profile.arch"      select="$arch"/>
  <p:with-param name="profile.revision"  select="$revision"/>
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
