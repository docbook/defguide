<!DOCTYPE style-sheet
  PUBLIC "-//Norman Walsh//DTD Annotated DSSSL Style Sheet V1.2//EN" [
<!ENTITY % html "IGNORE">
<!ENTITY % htmlhelp "IGNORE">
<![%html;[
<!ENTITY % print "IGNORE">
<!ENTITY nut.dsl SYSTEM "nuthtml.dsl" CDATA dsssl>
]]>
<![%htmlhelp;[
<!ENTITY % print "IGNORE">
<!ENTITY nut.dsl SYSTEM "nuthelp.dsl" CDATA dsssl>
]]>
<!ENTITY % print "INCLUDE">
<![%print;[
<!ENTITY nut.dsl SYSTEM "nutprint.dsl" CDATA dsssl>
]]>
]>

<style-sheet supportsid="yes">
<title>Nutshell Stylesheet</title>
<doctype pubid="-//Davenport//DTD DocBook V3.0//EN">
<backend name="rtf"  backend="rtf"  default="true">
<backend name="sgml" backend="sgml" options="-i html">
<backend name="help" backend="sgml" options="-i htmlhelp -V html-help">

<style-specification use="nutshell">
<style-specification-body>

(define debug
  (external-procedure "UNREGISTERED::James Clark//Procedure::debug"))

(define ROOTID #f)

(root
    (if ROOTID
	(process-element-with-id ROOTID)
	(process-children)))

</style-specification-body>
</style-specification>

<external-specification id="nutshell" document="nut.dsl">

</style-sheet>
