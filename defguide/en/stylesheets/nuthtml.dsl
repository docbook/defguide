<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY docbook.dsl PUBLIC "-//Norman Walsh//DOCUMENT DocBook HTML Stylesheet//EN" CDATA dsssl>
]>

<style-sheet>
<style-specification id="html" use="docbook">
<style-specification-body>

(define %default-variablelist-termlength% 0)

(define %stylesheet% "dbtdg.css")

(define show-comments #f)
(define html-help #f)
(define %html-ext% ".html")

(define (chunk-element-list)
  (list (normalize "preface")
	(normalize "chapter")
	(normalize "appendix")
	(normalize "article")
	(normalize "glossary")
	(normalize "bibliography")
	(normalize "index")
	(normalize "colophon")
	(normalize "setindex")
	(normalize "reference")
	(normalize "refentry")
	(normalize "part")
	(normalize "book") ;; just in case nothing else matches...
	(normalize "set")  ;; sets are definitely chunks...
	))

(define (nav-banner elemnode)
  (let* ((root     (sgml-root-element))
	 (title    (book-title root))
	 (info     (select-elements (children root) (normalize "bookinfo")))
	 (subtitle (select-elements (children info) (normalize "subtitle"))))
    (with-mode xref-title-mode
      (make sequence
	(process-node-list title)
	(literal ": ")
	(process-node-list subtitle)))))

(define read-entity
  (external-procedure "UNREGISTERED::James Clark//Procedure::read-entity"))

(element emphasis
  (if (equal? (attribute-string (normalize "role")) "bold")
      ($bold-seq$)
      ($italic-seq$)))

(element command
  ($italic-seq$))

(define %section-autolabel% #t)
(define %chapter-autolabel% #t)

(define %generate-legalnotice-link% #t)

(define %admon-graphics% #t)
(define %admon-graphics-path% "figures/")

(define ($html-body-end$)
  (let* ((book (ancestor-member (current-node) (list (normalize "book"))))
	 (info (select-elements (children book) (normalize "bookinfo")))
	 (notice (select-elements (children info) (normalize "legalnotice"))))
    (make element gi: "P"
	  (if (node-list-empty? notice)
	      (literal "Copyright")
	      (make element gi: "A"
		    attributes: (list
				 (list "HREF"
				       ($legalnotice-link-file$
					(node-list-first notice))))
		    (literal "Copyright")))
	  (literal " ")
	  (make entity-ref name: "copy")
	  (literal " 1999 O'Reilly ")
	  (make entity-ref name: "amp")
	  (literal " Associates, Inc. All rights reserved.")

)))

(define %graphic-default-extension% "gif")

;; ======================================================================

(element informalexample
  (let ((role (attribute-string (normalize "role"))))
    (if (or (equal? role "example-source")
	    (equal? role "example-output"))
	(make element gi: "DIV"
	      attributes: (list (list "CLASS" role))
	      (process-children))
	(next-match))))

;; HACK HACK HACK.  Get synchronous HTML markup from asynchronous DocBook!
(element anchor
  (let ((role (attribute-string (normalize "role"))))
    (if (equal? role "HACK-ex.out.start")
	(make formatting-instruction
	  data: "&#60;DIV CLASS=\"example-output\">")
	(if (equal? role "HACK-ex.out.end")
	    (make formatting-instruction
	      data: "&#60;/DIV>")
	    (next-match)))))

;; ======================================================================

(element informaltable
  (if (equal? (attribute-string (normalize "role")) "elemsynop")
      ($element-synopsis$)
      ($informal-object$)))

(define ($element-synopsis$)
  (let* ((table (current-node))
	 (rows  (select-elements (descendants table) (normalize "row"))))
    (with-mode elemsynop (process-node-list rows))))

(mode elemsynop
  (element (entry emphasis)
    (if (equal? (attribute-string (normalize "role")) "bold")
	($charseq$)
	($italic-seq$)))

  (element row
    (let* ((entries (select-elements (children (current-node))
				     (normalize "entry")))
	   (entry   (node-list-first entries))
	   (entry2  (node-list-first (node-list-rest entries))))
      (case (attribute-string (normalize "role"))
	(("cmtitle")
	 (make element gi: "H3"
	       (process-node-list (children entry))))
	(("cmsynop")
	 (process-node-list (children entry)))
	(("incltitle")
	   (make element gi: "H3"
		 (process-node-list (children entry))))
	(("inclsynop")
	 (process-node-list (children entry)))
	(("excltitle")
	   (make element gi: "H3"
		 (process-node-list (children entry))))
	(("exclsynop")
	 (process-node-list (children entry)))
	(("attrtitle")
	 (make sequence
	   (make element gi: "H3"
		 (process-node-list (children entry)))
	   (make element gi: "P"
		 (process-node-list (children entry2)))))
	(("attrheader")
	 (make sequence
	   ;; we got some work to do here...
	   (let* ((rows     (select-elements (children (parent (current-node)))
					     (normalize "row")))
		  (attrrows (let loop ((nl rows) (attr (empty-node-list)))
			      (if (node-list-empty? nl)
				  attr
				  (if (equal? (attribute-string
					       (normalize "role")
					       (node-list-first nl))
					      "attr")
				      (loop (node-list-rest nl)
					    (node-list attr
						       (node-list-first nl)))
				      (loop (node-list-rest nl) attr))))))
	     (make element gi: "TABLE"
		   attributes: '(("BORDER" "1")
				 ("WIDTH" "100%"))
		   (make element gi: "TR"
			 (process-children))
		   (let loop ((nl attrrows))
		     (if (node-list-empty? nl)
			 (empty-sosofo)
			 (make sequence
			   (make element gi: "TR"
				 (process-node-list
				  (children (node-list-first nl))))
			   (loop (node-list-rest nl)))))))))
	(("attr") (empty-sosofo))
	(("tmtitle")
	   (make element gi: "H3"
		 (process-node-list (children entry))))
	(("tmsynop")
	 (process-node-list (children entry)))
	(("petitle")
	 (make sequence
	   (make element gi: "H3"
		 (process-node-list (children entry)))

	   ;; we got some work to do here...
	   (let* ((rows     (select-elements (children (parent (current-node)))
					     (normalize "row")))
		  (attrrows (let loop ((nl rows) (attr (empty-node-list)))
			      (if (node-list-empty? nl)
				  attr
				  (if (equal? (attribute-string
					       (normalize "role")
					       (node-list-first nl))
					      "pe")
				      (loop (node-list-rest nl)
					    (node-list attr
						       (node-list-first nl)))
				      (loop (node-list-rest nl) attr))))))
	     (make element gi: "TABLE"
		   attributes: '(("BORDER" "0")
				 ("WIDTH" "100%"))
		   (let loop ((nl attrrows))
		     (if (node-list-empty? nl)
			 (empty-sosofo)
			 (make sequence
			   (make element gi: "TR"
				 (process-node-list
				  (children (node-list-first nl))))
			   (loop (node-list-rest nl)))))))))
	(("pe") (empty-sosofo))
	(("vle-pe") (empty-sosofo))
	(("vle-petitle")
	 (make sequence
	   (make element gi: "P"
		 (make element gi: "B"
		       (process-node-list (children entry))))

	   ;; we got some work to do here...
	   (let* ((rows     (select-elements (children (parent (current-node)))
					     (normalize "row")))
		  (attrrows (let loop ((nl rows) (attr (empty-node-list)))
			      (if (node-list-empty? nl)
				  attr
				  (if (equal? (attribute-string
					       (normalize "role")
					       (node-list-first nl))
					      "vle-pe")
				      (loop (node-list-rest nl)
					    (node-list attr
						       (node-list-first nl)))
				      (loop (node-list-rest nl) attr))))))
	     (make element gi: "TABLE"
		   attributes: '(("BORDER" "0")
				 ("WIDTH" "100%"))
		   (let loop ((nl attrrows))
		     (if (node-list-empty? nl)
			 (empty-sosofo)
			 (make sequence
			   (make element gi: "TR"
				 (process-node-list
				  (children (node-list-first nl))))
			   (loop (node-list-rest nl)))))))))
	(("vle-cmtitle")
	 (make element gi: "P"
	       (make element gi: "B"
		     (literal "Parameter entity content:")))))))

  (element entry
    (let ((tablegi (if (equal? (attribute-string (normalize "role")) "TH")
		       "TH"
		       "TD")))
      (make element gi: tablegi
	    attributes: '(("ALIGN" "LEFT")
			  ("VALIGN" "TOP")
			  ("WIDTH" "33%"))
	    (process-children)))))

;; ======================================================================

(element (entry simplelist)
  (make element gi: "P"
    (process-children)))

(element (entry simplelist member)
  (make sequence
    (if (equal? (child-number) 1)
	(empty-sosofo)
	(make empty-element gi: "BR"))
    (process-children)))

(element (varlistentry term)
  (make sequence
    (make element gi: "B"
	  (process-children-trim))
    (if (not (last-sibling?))
	(literal ", ")
	(literal ""))))

(element sgmltag
  (let* ((class (if (attribute-string (normalize "class"))
		    (attribute-string (normalize "class"))
		    (normalize "element")))
	 (role  (attribute-string "role"))
	 (content (data (current-node)))
	 (linkend (if (equal? class (normalize "paramentity"))
		      ;; hack; some of the paramentity ids don't start
		      ;; with dbre...
		      (if (node-list-empty? (element-with-id
					     (string-append "dbre.pent."
							    content)))
			  (string-append "pent." content)
			  (string-append "dbre.pent." content))
		      (string-append "dbre.elem." content)))
	 (target  (if (equal? role "NOLINK")
		      (empty-node-list)
		      (element-with-id linkend)))
;	 (err     (if (and (not (equal? role "NOLINK"))
;			   (node-list-empty? target))
;		      (debug (string-append
;			      "Unresolved SGMLTAG (CLASS="
;			      class
;			      "): "
;			      content))
;		      "")))
)
<![CDATA[
  (cond
   ((equal? class (normalize "attribute")) ($charseq$))
   ((equal? class (normalize "attvalue")) ($mono-seq$))

   ((equal? class (normalize "element"))
    (if (or (has-ancestor-member? (current-node)
				  (list (normalize "link")))
	    (node-list-empty? target))
	($mono-seq$)
	(make element gi: "A"
	      attributes: (list (list "HREF" (href-to target)))
	      ($mono-seq$))))

   ((equal? class (normalize "endtag")) ($mono-seq$ (make sequence
						      (literal "</")
						      (process-children)
						      (literal ">"))))
   ((equal? class (normalize "genentity")) ($mono-seq$ (make sequence
							 (literal "&")
							 (process-children)
							 (literal ";"))))
   ((equal? class (normalize "numcharref")) ($mono-seq$ (make sequence
							  (literal "&#")
							  (process-children)
							  (literal ";"))))
   ((equal? class (normalize "paramentity"))
    (if (or (has-ancestor-member? (current-node)
				  (list (normalize "link")))
	    (node-list-empty? target))
	($mono-seq$ (make element gi: "NOBR"
			  (literal "%")
			  (process-children)
			  (literal ";")))
	(make element gi: "A"
	      attributes: (list (list "HREF" (href-to target)))
	      ($mono-seq$ (make element gi: "NOBR"
				(literal "%")
				(process-children)
				(literal ";"))))))

   ((equal? class (normalize "pi"))
    ($mono-seq$ (make element gi: "NOBR"
		      (literal "<?")
		      (process-children)
		      (literal "?>"))))
   ((equal? class (normalize "starttag"))
    ($mono-seq$ (make element gi: "NOBR"
		      (literal "<")
		      (process-children)
		      (literal ">"))))
   ((equal? class (normalize "sgmlcomment"))
    ($mono-seq$ (make element gi: "NOBR"
		      (literal "<!--")
		      (process-children)
		      (literal "-->"))))
]]>
  (else ($charseq$)))))

(element ulink
  (let ((role (attribute-string "role")))
    (if (equal? (normalize role) (normalize "embed"))
	(let ((content (read-entity (attribute-string "url"))))
	  (make element gi: "PRE"
		(literal content)))
	(make element gi: "A"
	      attributes: (list
			   (list "HREF" (attribute-string (normalize "url")))
			   (list "TARGET" "_top"))
	      (process-children)))))

;; fix the title page

(define (book-titlepage-recto-elements)
  (list (normalize "title")
	(normalize "subtitle")
	(normalize "corpauthor")
	(normalize "authorgroup")
	(normalize "author")
	(normalize "releaseinfo")
	(normalize "pubdate")
	(normalize "copyright")
	(normalize "legalnotice")
	(normalize "publisher")))

(define (book-titlepage-separator side)
  (if (equal? side 'recto)
      (if html-help
	  (empty-sosofo)
	  (make empty-element gi: "HR"))
      (empty-sosofo)))

(mode book-titlepage-recto-mode
  (element title
    (make sequence
      (make element gi: "H1"
	    attributes: (list (list "CLASS" (gi))
			      (list "ALIGN" "CENTER"))
	    (make element gi: "A"
		  attributes: (list (list "NAME" (element-id)))
		  (process-children-trim)))))

  (element subtitle
    (make element gi: "H2"
	  attributes: (list (list "CLASS" (gi))
			    (list "ALIGN" "CENTER"))
	  (process-children-trim)))

  (element authorgroup
    (make sequence
      (process-children)))

  (element author
    (let ((author-name  (author-string))
	  (author-affil (select-elements (children (current-node))
					 (normalize "affiliation"))))
      (make sequence
	(if (first-sibling? (current-node))
	    (make element gi: "P"
		  attributes: '(("ALIGN" "CENTER"))
		  (make element gi: "I"
			(make element gi: "FONT"
			      attributes: '(("SIZE" "-1"))
			(literal "by"))))
	    (empty-sosofo))

	(if (last-sibling? (current-node))
	    (make element gi: "P"
		  attributes: '(("ALIGN" "CENTER"))
		  (make element gi: "I"
			(make element gi: "FONT"
			      attributes: '(("SIZE" "-1"))
			(literal "and"))))
	    (empty-sosofo))

	(make element gi: "H3"
	      attributes: (list (list "CLASS" (gi))
				(list "ALIGN" "CENTER"))
	      (literal author-name))
	(process-node-list author-affil))))

  (element pubdate
    (make sequence
      (make element gi: "H4"
	    attributes: '(("ALIGN" "CENTER"))
	    (process-children))))

  (element releaseinfo
    (make sequence
      (make element gi: "H4"
	    attributes: '(("ALIGN" "CENTER"))
	    (process-children))))

  (element copyright
    (let ((years (select-elements (descendants (current-node))
				  (normalize "year")))
	  (holders (select-elements (descendants (current-node))
				    (normalize "holder")))
	  (legalnotice (select-elements (children (parent (current-node)))
					(normalize "legalnotice"))))
      (make element gi: "P"
	    attributes: (list
			 (list "CLASS" (gi))
			 (list "ALIGN" "CENTER"))
	    (if (and %generate-legalnotice-link%
		     (not (node-list-empty? legalnotice)))
		(make sequence
		  (make element gi: "A"
			attributes: (list
				     (list "HREF"
					   ($legalnotice-link-file$
					    (node-list-first legalnotice))))
			(literal (gentext-element-name (gi (current-node)))))
		  (literal " ")
		  (literal (dingbat "copyright"))
		  (literal " ")
		  (process-node-list years)
		  (literal (string-append " " (gentext-by) " "))
		  (process-node-list holders))
		(make sequence
		  (literal (gentext-element-name (gi (current-node))))
		  (literal " ")
		  (literal (dingbat "copyright"))
		  (literal " ")
		  (process-node-list years)
		  (literal (string-append " " (gentext-by) " "))
		  (process-node-list holders))))))

  (element publisher
    (let* ((cities (select-elements (descendants (current-node))
				   (normalize "city")))
	   (firstcity (node-list-first cities))
	   (restcities (node-list-rest cities)))
      (make element gi: "p"
	    attributes: '(("class" "publisher"))
	    (process-node-list firstcity)
	    (let loop ((cities restcities))
	      (if (node-list-empty? cities)
		  (empty-sosofo)
		  (make sequence
		    (literal " * ")
		    (process-node-list (node-list-first cities))
		    (loop (node-list-rest cities))))))))

  (element city
    (process-children))

)

(define ($refentry-body$)
  (let* ((role (attribute-string (normalize "role") (current-node)))
	 (rev  (attribute-string (normalize "revision") (current-node)))
	 (imgf (cond
		((equal? rev "3.1") "figures/rev_3.1.gif")
		((equal? rev "4.0") "figures/rev_4.0.gif")
		((equal? rev "5.0") "figures/rev_5.0.gif")
		(else "MISSING_REVISION_FIGURE"))))
    (make sequence
      (make element gi: "H1"
	    (if (equal? role "new")
		(make sequence
		  (make empty-element gi: "IMG"
			attributes: (list (list "SRC" imgf)
					  (list "ALT"
						(string-append "(" rev ")"))))
		  (make entity-ref name: "nbsp"))
		(empty-sosofo))
	    (element-title-sosofo (current-node)))
      (process-children))))

(element (refsect2 title)
  (let* ((role (attribute-string (normalize "role") (parent (current-node))))
	 (rev  (attribute-string (normalize "revision")
				 (parent (current-node))))
	 (imgf (cond
		((equal? rev "3.1") "figures/rev_3.1.gif")
		((equal? rev "4.0") "figures/rev_4.0.gif")
		((equal? rev "5.0") "figures/rev_5.0.gif")
		(else "MISSING_REVISION_FIGURE")))
	 (tgi  "H3"))
    (make element gi: tgi
	  (if (equal? role "fu")
	      (make sequence
		(make empty-element gi: "IMG"
		      attributes: (list (list "SRC" imgf)
					(list "ALT"
					      (string-append "(" rev ")"))))
		(make entity-ref name: "nbsp"))
	      (empty-sosofo))
	  (process-children))))

(element (appendix bibliography)
  (make sequence
    (make element gi: "A"
	  attributes: (list (list "NAME" (element-id)))
	  (empty-sosofo))
    (bibliography-content)))

(element comment
  (if show-comments
      (make element gi: "P"
	    attributes: '(("CLASS" "COMMENT"))
	    (make element gi: "FONT"
		  attributes: '(("COLOR" "RED"))
		  (process-children)))
      (empty-sosofo)))

</style-specification-body>
</style-specification>

<external-specification id="docbook" document="docbook.dsl">

</style-sheet>
