<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY docbook.dsl PUBLIC "-//Norman Walsh//DOCUMENT DocBook Print Stylesheet//EN" CDATA dsssl>
]>

<style-sheet>
<style-specification id="print" use="docbook">
<style-specification-body>

(define show-comments #f)

(define read-entity
  (external-procedure "UNREGISTERED::James Clark//Procedure::read-entity"))

(define (book-titlepage-verso-elements)
  (list (normalize "title") 
	(normalize "subtitle") 
	(normalize "corpauthor") 
	(normalize "authorgroup") 
	(normalize "author") 
	(normalize "editor")
	(normalize "edition") 
	(normalize "pubdate") 
	(normalize "releaseinfo")
	(normalize "copyright")
	(normalize "abstract") 
	(normalize "legalnotice") 
	(normalize "revhistory")))

(define %refentry-generate-name% #f)
(define %refentry-function% #f)
(define %generate-titlepage% #f)
(define %generate-toc% #f)
(define %generate-lot-list% '())
(define %refentry-new-page% #f)
(define %two-side% #t)
(define %refentry-keep% #f)

(define %cals-rule-default% "1")

(define %line-spacing-factor% 1.1)

(define %verbatim-size-factor% 0.9)

(define %graphic-default-extension% "gif")

;; ------

(define (first-page-center-footer gi)
  (let* ((docinfo (select-elements (children (current-node))
				   (normalize "docinfo")))
	 (relinfo (select-elements (children docinfo)
				   (normalize "releaseinfo"))))
    (if (node-list-empty? relinfo)
	(empty-sosofo)
	(literal (data relinfo)))))

(define (page-center-footer gi)
  (first-page-center-footer gi))

;; ------

(define (gentext-usen-xref-strings giname)
  (case giname
    (("APPENDIX") (if %chapter-autolabel%
		      "Appendix %n, %t"
		      "the appendix called %t"))
    (("ARTICLE") (string-append %gentext-usen-start-quote%
				"%t"
				%gentext-usen-end-quote%))
    (("BIBLIOGRAPHY") "%t")
    (("BOOK") "%t")
    (("CHAPTER") (if %chapter-autolabel%
		     "Chapter %n, %t"
		     "the chapter called %t"))
    (("EQUATION") "Equation %n")
    (("EXAMPLE") "Example %n")
    (("FIGURE") "Figure %n")
    (("INFORMALTABLE") "%kg %kn")
    (("LISTITEM") "%n")
    (("PART") "Part %n")
    (("PREFACE") "%t")
    (("PROCEDURE") "Procedure %n, %t")
    (("SECT1") (if %section-autolabel% 
		   "Section %n" 
		   "the section called %t"))
    (("SECT2") (if %section-autolabel% 
		   "Section %n" 
		   "the section called %t"))
    (("SECT3") (if %section-autolabel% 
		   "Section %n" 
		   "the section called %t"))
    (("SECT4") (if %section-autolabel% 
		   "Section %n" 
		   "the section called %t"))
    (("SECT5") (if %section-autolabel% 
		   "Section %n" 
		   "the section called %t"))
    (("STEP") "step %n")
    (("TABLE") "Table %n")
    (("TITLE") "%kg %kn")
    (else (string-append "[xref to " 
			 (if giname 
			     giname
			     "non-existant element")
			 " unsupported]"))))

;(declare-initial-value top-margin	5pi)
;(declare-initial-value bottom-margin	6pi)
;(declare-initial-value footer-margin	4pi)

;(define %visual-acuity% "tiny")
;(define %page-n-columns% 2)
;(define %paper-type% "USlandscape")
;(define %left-margin% 4pi)
;(define %right-margin% 4pi)

(element REFENTRY 
  (make display-group
    keep: %refentry-keep%
    (if %refentry-new-page%
	(make simple-page-sequence
	  page-number-format: ($page-number-format$)
	  use: default-text-style
	  left-header:   ($left-header$)
	  center-header: ($center-header$)
	  right-header:  ($right-header$)
	  left-footer:   ($left-footer$)
	  center-footer: ($center-footer$)
	  right-footer:  ($right-footer$)
	  input-whitespace-treatment: 'collapse
	  quadding: %default-quadding%
	  ($refentry-title$)
	  (process-children))
	(make sequence
	  (make rule
	    orientation: 'horizontal
	    line-thickness: 2pt)
	  ($refentry-title$)
	  ($block-container$)))
    (make-endnotes)))

;;(element (SYNOPSIS SGMLTAG) ($charseq$))

(element sgmltag
  (let* ((class (if (attribute-string (normalize "class"))
		    (attribute-string (normalize "class"))
		    (normalize "element")))
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
	 (target  (element-with-id linkend))
;	 (err     (if (node-list-empty? target)
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
	(make link 
	  destination: (node-list-address target)
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
	($mono-seq$ (make sequence
		      (literal "%") 
		      (process-children) 
		      (literal ";")))
	(make link
	  destination: (node-list-address target)
	  ($mono-seq$ (make sequence
			(literal "%")
			(process-children)
			(literal ";"))))))
   
   ((equal? class (normalize "pi")) ($mono-seq$ (make sequence 
						  (literal "<?")
						  (process-children)
						  (literal "?>"))))
   ((equal? class (normalize "starttag")) ($mono-seq$ (make sequence 
							(literal "<") 
							(process-children)
							(literal ">"))))
   ((equal? class (normalize "sgmlcomment")) ($mono-seq$ (make sequence 
							   (literal "<!--")
							   (process-children)
							   (literal "-->"))))
]]>
  (else ($charseq$)))))


(element ulink 
  (let* ((url          (attribute-string (normalize "url")))
	 (content      (data (current-node)))
	 (data-is-url? (and (> (string-length content) 6)
			    (or (equal? (substring content 0 6) "ftp://")
				(equal? (substring content 0 6) "http:/")))))
    (if data-is-url?
	($italic-seq$)
	(make sequence
	  ($charseq$)
	  ($italic-seq$ (literal " (" url ")"))))))

(element COMMENT
  (let* ((colr-space (color-space 
		      "ISO/IEC 10179:1996//Color-Space Family::Device RGB"))
	 (red        (color colr-space 1 0 0)))
    (if show-comments
	(make sequence
	  color: red
	  start-indent: 0pt
	  ($italic-seq$))
	(empty-sosofo))))

(element EMPHASIS
  (if (equal? (normalize (attribute-string "ROLE")) (normalize "bold"))
      ($bold-seq$)
      ($italic-seq$)))

(element OPTION
  ($italic-seq$))

(element COMMAND
  ($italic-seq$))

(element PHRASE 
  (let ((rev (attribute-string "REVISIONFLAG")))
    (if (equal? rev "DELETED")
	(make score
	  type: 'through
	  (process-children))
	(process-children))))

(element (ENTRY SIMPLELIST) 
  (make paragraph
    (process-children)))

(element (ENTRY SIMPLELIST MEMBER) 
  (make sequence
    (if (equal? (child-number) 1)
	(empty-sosofo)
	(make paragraph-break))
    (process-children)))

(element (refsynopsisdiv variablelist varlistentry term)
  (let ((termlength
	  (attribute-string (normalize "termlength") (ancestor (normalize "variablelist")))))
    (make paragraph
	  font-weight: 'bold
	  space-before: %para-sep%
	  end-indent: (if termlength
			  (- %text-width% (measurement-to-length termlength))
			  0pt)
	  (process-children))))

(define ($refentry-title$)
  ;; all this work, just to make the icons appear if it's a new element
  (let* ((role (attribute-string (normalize "role") (current-node)))
	 (rev  (attribute-string (normalize "revision") (current-node)))
	 (imgf (cond
		((equal? rev "3.1") "figures/rev_3.1.eps")
		((equal? rev "4.0") "figures/rev_4.0.eps")
		((equal? rev "5.0") "figures/rev_5.0.eps")
		(else "MISSING_REVISION_FIGURE"))))
	 (refmeta       (select-elements (children (current-node))
				    (normalize "refmeta")))
	 (refentrytitle (select-elements (children refmeta)
					 (normalize "refentrytitle")))
	 (refnamediv    (select-elements (children (current-node))
					 (normalize "refnamediv")))
	 (refdescriptor (select-elements (children refnamediv)
					 (normalize "refdescriptor")))
	 (refname       (select-elements (children refnamediv)
					 (normalize "refname")))
	 (title         (if (node-list-empty? refentrytitle)
			    (if (node-list-empty? refdescriptor)
				(node-list-first refname)
				refdescriptor)
			    refentrytitle))
	 (slevel (SECTLEVEL)) ;; the true level in the section hierarchy
	 (hlevel (if (> slevel 2) 2 slevel)) ;; limit to sect2 equiv.
	 (hs (HSIZE (- 4 hlevel))))
    (make paragraph
      font-family-name: %title-font-family%
      font-weight: 'bold
      font-size: hs
      line-spacing: (* hs %line-spacing-factor%)
      space-before: (* hs %head-before-factor%)
      space-after: (* hs %head-after-factor%)
      start-indent: %body-start-indent%
      first-line-start-indent: (- %body-start-indent%)
      quadding: 'start
      heading-level: (if %generate-heading-level% 2 0)
      keep-with-next?: #t

      ;; I can't actually get images working for EPS
;      (if (equal? role "new")
;	  (make sequence
;	    (make external-graphic
;	      entity-system-id: imgf
;	      display?: #f
;	      display-alignment: 'start)
;	    (literal "\no-break-space;"))
;	  (empty-sosofo))
      (if (equal? role "new")
	  (make sequence
	    font-weight: 'bold
	    (literal "(" rev ")")
	    (literal "\no-break-space;"))
	  (empty-sosofo))
      
      (process-node-list (children title))

      (if %refentry-function%
	  (sosofo-append
	   (literal "\no-break-space;")
	   (process-first-descendant (normalize "manvolnum")))
	  (empty-sosofo)))))

(define ($section-title$)
  ;; all this work, just to make the icons appear if there's an FU comment
  ;; on a refsect2...
  (let* ((role (attribute-string (normalize "role") (current-node)))
	 (rev  (attribute-string (normalize "revision") (current-node)))
	 (imgf (cond 
		((equal? rev "3.1") "figures/rev_3.1.eps")
		((equal? rev "4.0") "figures/rev_4.0.eps")
		((equal? rev "5.0") "figures/rev_5.0.eps")
		(else "MISSING_REVISION_FIGURE")))
	 (sect (current-node))
	 (info (info-element))
	 (exp-children (if (node-list-empty? info)
			   (empty-node-list)
			   (expand-children (children info) 
					    (list (normalize "bookbiblio") 
						  (normalize "bibliomisc")
						  (normalize "biblioset")))))
	 (parent-titles (select-elements (children sect) (normalize "title")))
	 (info-titles   (select-elements exp-children (normalize "title")))
	 (titles        (if (node-list-empty? parent-titles)
			    info-titles
			    parent-titles))
	 (subtitles     (select-elements exp-children (normalize "subtitle")))
	 (renderas (inherited-attribute-string (normalize "renderas") sect))
	 (hlevel                          ;; the apparent section level;
	  (if renderas                    ;; if not real section level,
	      (string->number             ;;   then get the apparent level
	       (substring renderas 4 5))  ;;   from "renderas",
	      (SECTLEVEL)))
	 (hs (HSIZE (- 4 hlevel))))
    (make sequence
      (make paragraph
	font-family-name: %title-font-family%
	font-weight:  (if (< hlevel 5) 'bold 'medium)
	font-posture: (if (< hlevel 5) 'upright 'italic)
	font-size: hs
	line-spacing: (* hs %line-spacing-factor%)
	space-before: (* hs %head-before-factor%)
	space-after: (if (node-list-empty? subtitles)
			 (* hs %head-after-factor%)
			 0pt)
	start-indent: (if (or (>= hlevel 3)
			      (member (gi) (list (normalize "refsynopsisdiv") 
						 (normalize "refsect1") 
						 (normalize "refsect2") 
						 (normalize "refsect3"))))
			  %body-start-indent%
			  0pt)
	first-line-start-indent: 0pt
	quadding: %section-title-quadding%
	keep-with-next?: #t
	heading-level: (if %generate-heading-level% (+ hlevel 1) 0)

;	(if (and (equal? (gi sect) (normalize "refsect2"))
;		 (equal? role "fu"))
;	    (make sequence
;	      (make external-graphic
;		entity-system-id: imgf
;		display?: #f
;		display-alignment: 'start)
;	      (literal "\no-break-space;"))
;	    (empty-sosofo))
	(if (and (equal? (gi sect) (normalize "refsect2"))
		 (equal? role "fu"))
	    (make sequence
	      font-weight: 'bold
	      (literal "(" rev ")")
	      (literal "\no-break-space;"))
	    (empty-sosofo))

	;; SimpleSects are never AUTO numbered...they aren't hierarchical
	(if (string=? (element-label (current-node)) "")
	    (empty-sosofo)
	    (literal (element-label (current-node)) 
		     (gentext-label-title-sep (gi sect))))
	(element-title-sosofo (current-node)))
      (with-mode section-title-mode
	(process-node-list subtitles))
      ($section-info$ info))))

(element (appendix bibliography)
  (bibliography-content))

(define ($process-cell$ entry preventry row overhang)
  (let* ((colnum    (cell-column-number entry overhang))
	 (lastcellcolumn (if (node-list-empty? preventry)
			     0
			     (- (+ (cell-column-number preventry overhang)
				   (hspan preventry))
				1)))
	 (lastcolnum (if (> lastcellcolumn 0)
			 (overhang-skip overhang lastcellcolumn)
			 0))
	 (font-name (if (have-ancestor? (normalize "thead") entry)
			%title-font-family%
			%body-font-family%))
	 (weight    (if (have-ancestor? (normalize "thead") entry)
			'bold
			'medium))
	 (align     (cell-align entry colnum))
	 (row       (parent entry)))

    (make sequence
      ;; This is a little bit complicated.  We want to output empty cells
      ;; to skip over missing data.  We start count at the column number
      ;; arrived at by adding 1 to the column number of the previous entry
      ;; and skipping over any MOREROWS overhanging entrys.  Then for each
      ;; iteration, we add 1 and skip over any overhanging entrys.
      (let loop ((count (overhang-skip overhang (+ lastcolnum 1))))
	(if (>= count colnum)
	    (empty-sosofo)
	    (make sequence
	      ($process-empty-cell$ count row)
	      (loop (overhang-skip overhang (+ count 1))))))

      ;; Now we've output empty cells for any missing entries, so we 
      ;; are ready to output the cell for this entry...
      (make table-cell 
	column-number: colnum
	n-columns-spanned: (hspan entry)
	n-rows-spanned: (vspan entry)

	cell-row-alignment: (cell-valign entry colnum)

	cell-after-column-border: (if (cell-colsep entry colnum)
				      calc-table-cell-after-column-border
				      #f)
	
	cell-after-row-border: (if (cell-rowsep entry colnum)
				   (if (last-sibling? (parent entry))
				       calc-table-head-body-border
				       calc-table-cell-after-row-border)
				   #f)

	cell-before-row-margin: (if (equal? (attribute-string 
					     (normalize "role") 
					     row)
					    "PE")
				    0pt
				    %cals-cell-before-row-margin%)
	cell-after-row-margin: (if (equal? (attribute-string 
					     (normalize "role") 
					     row)
					    "PE")
				    0pt
				    %cals-cell-after-row-margin%)
	cell-before-column-margin: %cals-cell-before-column-margin%
	cell-after-column-margin: %cals-cell-after-column-margin%
	start-indent: %cals-cell-content-start-indent%
	end-indent: %cals-cell-content-end-indent%
	(if (equal? (gi entry) (normalize "entrytbl"))
	    (make paragraph 
	      (literal "ENTRYTBL not supported."))
	    (make paragraph
	      font-family-name: font-name
	      font-weight: weight
	      quadding: align
	      (process-node-list (children entry))))))))

</style-specification-body>
</style-specification>

<external-specification id="docbook" document="docbook.dsl">

</style-sheet>
