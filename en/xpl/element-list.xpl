<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:exf="http://exproc.org/standard/functions"
                exclude-inline-prefixes="cx exf"
                name="main">
<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>
<p:output port="result"/>
<p:serialization port="result" indent="true"/>

<p:option name="manual" select="''"/>

<p:xslt>
  <p:input port="stylesheet">
    <p:document href="../stylesheets/elem-xi.xsl"/>
  </p:input>
  <p:with-param name="manual" select="$manual"/>
</p:xslt>

</p:declare-step>
