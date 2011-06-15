<p:declare-step version='1.0' xmlns:p="http://www.w3.org/ns/xproc">
<p:input port="source" />
<p:output port="result" />
<p:input port="parameters" kind="parameter"/>

<p:variable name="srcbase" select="base-uri(/)"/>

<p:xslt name="profiled">
  <p:input port="stylesheet">
    <p:document href="profile.xsl"/>
  </p:input>
  <p:with-param name="not-condition" select="'compact print'"/>
</p:xslt>

<p:load name="purpose.xsl">
  <p:with-option name="href" select="resolve-uri('style/purpose.xsl', $srcbase)"/>
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
