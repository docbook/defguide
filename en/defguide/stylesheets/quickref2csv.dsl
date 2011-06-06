<!DOCTYPE style-sheet
  PUBLIC "-//Norman Walsh//DTD Annotated DSSSL Style Sheet V1.2//EN" [
<!ENTITY nut.dsl SYSTEM "nuthtml.dsl" CDATA dsssl>
]>

<style-sheet>
<title>QuickRef 2 CSV</title>
<doctype pubid="-//Davenport//DTD DocBook V3.0//EN">
<doctype pubid="-//OASIS//DTD DocBook V3.1//EN">
<backend name="sgml" backend="sgml" default="true">

<style-specification use="nutshell">
<style-specification-body>

(declare-flow-object-class formatting-instruction
  "UNREGISTERED::James Clark//Flow Object Class::formatting-instruction")

(define debug
  (external-procedure "UNREGISTERED::James Clark//Procedure::debug"))

(element quickref
  (process-children))

(element element
  (make sequence
    (process-children)
    (literal ",")))

(element category
  (make sequence
    (literal "\"")
    (process-children)
    (literal "\",")))

(element purpose
  (make sequence
    (literal "\"")
    (process-children)
    (literal "\",")
    (make formatting-instruction data: "
")))

(element sgmltag
  (process-children))

(element quote
  (process-children))

(element acronym
  (process-children))

</style-specification-body>
</style-specification>

<external-specification id="nutshell" document="nut.dsl">

</style-sheet>
