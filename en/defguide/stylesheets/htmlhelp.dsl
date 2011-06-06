<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY docbook.dsl PUBLIC "-//Norman Walsh//DOCUMENT DocBook HTML Stylesheet//EN" CDATA dsssl>
<!ENTITY dbautoc.dsl SYSTEM "hhautoc.dsl">
]>

<style-sheet>
<style-specification use="docbook">
<style-specification-body>

;; $Id$

(define (extract-gi args)
  (let ((gi (member gi: args)))
    (if gi
	(car (cdr gi))
	"")))

(define (extract-node args)
  (let ((node (member node: args)))
    (if node
	(car (cdr node))
	#f)))

(define (extract-attributes args)
  (let ((attr (member attributes: args)))
    (if attr
	(car (cdr attr))
	'())))

(define (extract-sosofos args)
  (let loop ((l args) (results '()))
    (if (null? l)
	results
	(if (not (keyword? (car l)))
	    (loop (cdr l) (append results (list (car l))))
	    (loop (cdr (cdr l)) results)))))

(define (make-element #!rest args)
  ;; Args _MUST_ be '( gi: "gi" attributes: '() sosofo...) where sosofo
  ;; is optional.
  (let* ((node       (if (extract-node args)
			 (extract-node args)
			 (current-node)))
	 (giname     (extract-gi args))
	 (attr       (extract-attributes args))
	 (sosofo     (extract-sosofos args)))
    (sosofo-append
      (make formatting-instruction data: (string-append "<" giname))
      (if (null? attr)
	  (empty-sosofo)
	  (let loop ((a attr))
	    (if (null? a)
		(empty-sosofo)
		(make sequence
		  (let* ((attrlist (car a))
			 (name (car attrlist))
			 (value (car (cdr attrlist))))
		    (make formatting-instruction 
		      data: (string-append " " name "=\"" (if value value "whatthe") "\"")))
		  (loop (cdr a))))))
      
      (make formatting-instruction data: ">")
      (newline giname)

      (if sosofo
	  (apply sosofo-append sosofo)
	  (current-node))

      (make formatting-instruction data: (string-append "</" giname ">"))
      (newline giname))))

(define (make-empty-element #!rest args)
  ;; Args _MUST_ be '( gi: "gi" attributes: '() sosofo)
  (let* ((giname (extract-gi args))
	 (attributes (extract-attributes args))
	 (attr attributes))
    (sosofo-append
      (make formatting-instruction data: (string-append "<" giname))
      (if (null? attr)
	  (empty-sosofo)
	  (let loop ((a attr))
	    (if (null? a)
		(empty-sosofo)
		(make sequence
		  (make formatting-instruction 
		    data: (string-append " " 
					 (car (car a)) 
					 "=\"" 
					 (car (cdr (car a)))
					 "\""))
		  (loop (cdr a))))))

      (make formatting-instruction data: ">")
      (newline giname))))

;; ######################################################################
;; Epic-specific configuration

(define ($generate-chapter-toc$) #f)
(define ($generate-part-toc$) #f)
(define ($generate-book-toc$) #f)
(define ($generate-set-toc$) #f)

(define %generate-book-toc% #t)
(define %generate-reference-toc% #f)
(define %generate-part-toc% #f)
(define %generate-set-toc% #t)

(define %section-autolabel% #f)
(define %chapter-autolabel% #f)

(define (chunk-skip-first-element-list) '())

(define (header-navigation nd #!optional (navlist (empty-node-list)))
  (empty-sosofo))

;(define (footer-navigation nd)
;  (empty-sosofo))

(define ($paragraph$ #!optional (para-wrapper "P"))
  (let ((footnotes (select-elements (descendants (current-node)) (normalize "footnote")))
	(tgroup (have-ancestor? (normalize "tgroup"))))
    (make sequence
      (make-element gi: para-wrapper
	    attributes: '(("CLASS" "PARA"))
	    (process-children))
      (if (or tgroup (node-list-empty? footnotes))
	  (empty-sosofo)
	  (make-element gi: "BLOCKQUOTE"
		attributes: (list
			     (list "DIV" "FOOTNOTES"))
		(with-mode footnote-mode
		  (process-node-list footnotes)))))))

;; ##############################

&dbautoc.dsl;

;; ##############################

(define %htmlhelp-index% "Index.hhk")
(define %htmlhelp-toc% "Contents.hhc")

(element helplink
  (let* ((title  (data (current-node)))
	 (target (element-with-id (attribute-string "topiclink")))
	 (href  (if (node-list-empty? target)
		    ""
		    (href-to target))))
    (make-element gi: "LI"
	  (make-element gi: "OBJECT"
		attributes: '(("type" "text/sitemap"))
		(make-empty-element gi: "param"
		      attributes: (list (list "name" "Name")
					(list "value" title)))
		(make-empty-element gi: "param"
		      attributes: (list (list "name" "Local")
					(list "value" href)))))))

;; ##############################

(define (make-contents-hhc) 
  (make entity
    system-id: %htmlhelp-toc%
    (make document-type
      name: "HTML"
      public-id: "-//IETF//DTD HTML//EN")
    (make-element gi: "HTML"
	  (make-element gi: "HEAD"
		(make formatting-instruction data: "&#60;!-- Sitemap 1.0 -->"))
	  (make-element gi: "BODY"
		(make-element gi: "OBJECT"
		      attributes: '(("type" "text/site properties"))
		      (make-empty-element gi: "param"
			    attributes: '(("name" "ImageType")
					  ("value" "Folder"))))
		(make-element gi: "UL"
		      (make-element gi: "LI"
			    (build-tocentry (current-node)))
		      (build-toc (current-node) (toc-depth (current-node))))))))

;; ##############################

(element set
  (let* ((setinfo  (select-elements (children (current-node)) (normalize "setinfo")))
	 (ititle   (select-elements (children setinfo) (normalize "title")))
	 (title    (if (node-list-empty? ititle)
		       (select-elements (children (current-node)) (normalize "title"))
		       (node-list-first ititle)))
	 (nl       (titlepage-info-elements (current-node) setinfo))
	 (tsosofo  (with-mode head-title-mode
		     (process-node-list title))))
    (html-document 
     tsosofo
     (make-element gi: "DIV"
	   attributes: '(("CLASS" "SET"))
	   (if %generate-set-titlepage%
	       (make sequence
		 (set-titlepage nl 'recto)
		 (set-titlepage nl 'verso))
	       (empty-sosofo))
	   
	   (if (not (generate-toc-in-front))
	       (process-children)
	       (empty-sosofo))
	   
	   (if %generate-set-toc%
	       (make-contents-hhc)
	       (empty-sosofo))
	   
	   (if (generate-toc-in-front)
	       (process-children)
	       (empty-sosofo))))))

(element book 
  (let* ((bookinfo  (select-elements (children (current-node)) (normalize "bookinfo")))
	 (ititle   (select-elements (children bookinfo) (normalize "title")))
	 (title    (if (node-list-empty? ititle)
		       (select-elements (children (current-node)) (normalize "title"))
		       (node-list-first ititle)))
	 (nl       (titlepage-info-elements (current-node) bookinfo))
	 (tsosofo  (with-mode head-title-mode
		     (process-node-list title)))
	 (dedication (select-elements (children (current-node)) (normalize "dedication"))))
    (html-document 
     tsosofo
     (make-element gi: "DIV"
	   attributes: '(("CLASS" "BOOK"))
	   (if %generate-book-titlepage%
	       (make sequence
		 (book-titlepage nl 'recto)
		 (book-titlepage nl 'verso))
	       (empty-sosofo))
	  
	   (if (node-list-empty? dedication)
	       (empty-sosofo)
	       (with-mode dedication-page-mode
		 (process-node-list dedication)))

	   (if (not (generate-toc-in-front))
	       (process-children)
	       (empty-sosofo))
	  
	   (if %generate-book-toc%
	       (if (node-list-empty? (parent (current-node)))
		   (make-contents-hhc)
		   (empty-sosofo))
	       (empty-sosofo))
	  
	   (if (generate-toc-in-front)
	       (process-children)
	       (empty-sosofo))))))

(element refmeta
  (process-node-list (select-elements (children (current-node)) "indexterm")))

(element indexterm
  (let* ((primary (select-elements (children (current-node)) "primary"))
	 (secondary (select-elements (children (current-node)) "secondary"))
	 (tertiary (select-elements (children (current-node)) "tertiary"))
	 (pterm (data primary))
	 (sterm (if secondary
		    (string-append 
		     (data primary)
		     ", "
		     (data secondary))
		    ""))
	 (tterm (if tertiary
		    (string-append
		     (data primary)
		     ", "
		     (data secondary)
		     ", " 
		     (data tertiary))
		    "")))
    (make-element gi: "OBJECT"
	  attributes: '(("type" "application/x-oleobject")
			("classid" "clsid:1e2a7bd0-dab9-11d0-b93a-00c04fc99f9e"))
	  (make sequence
	    (make-empty-element gi: "param"
		  attributes: (list (list "name" "Keyword")
				    (list "value" pterm)))
	    (if (not (node-list-empty? secondary))
		(make sequence
		  (make-empty-element gi: "param"
			attributes: (list (list "name" "Keyword")
					  (list "value" sterm)))
		  (if (not (node-list-empty? tertiary))
		      (make-empty-element gi: "param"
			    attributes: (list (list "name" "Keyword")
					      (list "value" tterm)))
		      (empty-sosofo)))
		(empty-sosofo))))))

;; ##############################

(root
 (make sequence
   (process-children)
   (with-mode filelist
     (process-children))
   (with-mode manifest
     (process-children))))

;; ##############################

(define (println #!optional (text ""))
  (make formatting-instruction data: (string-append text "
")))

(define html-block-elements 
  '("HTML" "HEAD" 
	   "TITLE" "META" "LINK" 
	   "BODY" "DIV" "H1" "P"
	   "OBJECT" "param"))

(define (newline #!optional (gi ""))
  (if (or (equal? gi "") (member gi html-block-elements))
      (make formatting-instruction data: "&#13;")
      (empty-sosofo)))

(mode filelist
  ;; this mode is really just a hack to get at the root element
  (root (process-children))

  (default 
    (if (node-list=? (current-node) (sgml-root-element))
	(let* ((rootgi (case-fold-down (gi (sgml-root-element))))
	       (proj   (string-append "the" rootgi ".hhp"))
	       (cproj  (string-append "the" rootgi ".chm"))
	       (topic  (html-base-filename (sgml-root-element)))
	       (index  %htmlhelp-index%)
	       (toc    %htmlhelp-toc%))
	  (make sequence
	    (make entity
	      system-id: proj
	      (make sequence
		(println "[OPTIONS]")
		(println "Auto Index=Yes")
		(println "Compatibility=1.1")
		(println (string-append "Compiled file=" cproj))
		(println (string-append "Contents file=" toc))
		(println (string-append "Default topic=" topic))
		(println "Full-text search=Yes")
		(println (string-append "Index file=" index))
		(println "Language=0x409 English (United States)")
		(newline)
		(println "[FILES]")
		(let loop ((node (current-node)))
		  (if (node-list-empty? node)
		      (empty-sosofo)
		      (make sequence
			(println (html-file node))
			(loop (next-chunk-element node)))))))
	    (make entity
	      system-id: index
	      (empty-sosofo))))
	(empty-sosofo))))

(mode manifest
  ;; this mode is really just a hack to get at the root element
  (root (process-children))

  (default 
    (if (node-list=? (current-node) (sgml-root-element))
	(if html-manifest
	    (make entity
	      system-id: html-manifest-filename
	      (make sequence
		(println %htmlhelp-toc%)
		(let loop ((node (current-node)))
		  (if (node-list-empty? node)
		      (empty-sosofo)
		      (make sequence
			(println (html-file node))
			(loop (next-chunk-element node)))))))
	    (empty-sosofo))
	(empty-sosofo))))

</style-specification-body>
</style-specification>

<external-specification id="docbook" document="docbook.dsl">

</style-sheet>
