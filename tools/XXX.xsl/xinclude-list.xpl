<p:declare-step version='1.0' xmlns:p="http://www.w3.org/ns/xproc">
<p:input port="source" />

<p:for-each>
  <p:iteration-source select="/list/item"/>

  <p:variable name="base" select="base-uri(/)"/>
  <p:variable name="xifile" select="string(.)"/>
  <p:variable name="name" select="substring-before($xifile,'.xi')"/>
  <p:variable name="xihref" select="concat('../../../refpages/elements/',$name,'.xml')"/>

  <p:load>
    <p:with-option name="href" select="resolve-uri($xihref, $base)"/>
  </p:load>

  <p:xinclude/>
  <p:add-xml-base relative="false"/>
  <p:store>
    <p:with-option name="href" select="resolve-uri($xifile, $base)"/>
  </p:store>
</p:for-each>

</p:declare-step>
