;; $Id$
;;
;; This file is part of the Modular DocBook Stylesheet distribution.
;; See ../README or http://www.berkshire.net/~norm/dsssl/
;;

;; ========================== TABLE OF CONTENTS =========================

;; Returns the depth of auto TOC that should be made at the nd-level
(define (toc-depth nd)
  (cond ((string=? (gi nd) (normalize "set"))  4)
	((string=? (gi nd) (normalize "book")) 3)
	((string=? (gi nd) (normalize "chapter")) 2)
	((string=? (gi nd) (normalize "appendix")) 2)
	((string=? (gi nd) (normalize "preface")) 2)
	(else 1)))

(define (build-tocentry tocentry)
  (make-element gi: "OBJECT"
	attributes: (list (list "type" "text/sitemap"))
	(let* ((label    (if (equal? (element-label tocentry) "")
			     ""
			     (string-append
			      (element-label tocentry)
			      (gentext-label-title-sep
			       (gi tocentry)))))
	       (title    (element-title-string tocentry))
	       (name     (if (equal? label "")
			     title
			     (string-append
			      label title)))
	       (href     (href-to tocentry)))
	  (make sequence
	    (make-empty-element gi: "param"
		  attributes: (list (list "name" "Name")
				    (list "value" name)))
	    (make-empty-element gi: "param"
		  attributes: (list (list "name" "Local")
				    (list "value" href)))))))

(define (alpha toclist)
  (if (node-list-empty? toclist)
      toclist
      (let* ((first-title (element-title-string (node-list-first toclist)))
	     (first-letter (case-fold-up (substring first-title 0 1))))
	(let loop ((match (node-list-first toclist))
		   (rest (node-list-rest toclist)))
	  (if (node-list-empty? rest)
	      match
	      (let* ((next-title (element-title-string (node-list-first rest)))
		     (next-letter (case-fold-up (substring next-title 0 1))))
		(if (equal? first-letter next-letter)
		    (loop (node-list match (node-list-first rest))
			  (node-list-rest rest))
		    match)))))))

(define (alpha-rest toclist)
  (if (node-list-empty? toclist)
      toclist
      (let* ((first-title (element-title-string (node-list-first toclist)))
	     (first-letter (case-fold-up (substring first-title 0 1))))
	(let loop ((match (node-list-first toclist))
		   (rest (node-list-rest toclist)))
	  (if (node-list-empty? rest)
	      rest
	      (let* ((next-title (element-title-string (node-list-first rest)))
		     (next-letter (case-fold-up (substring next-title 0 1))))
		(if (equal? first-letter next-letter)
		    (loop (node-list match (node-list-first rest))
			  (node-list-rest rest))
		    rest)))))))

(define (build-toc-list nd depth toclist #!optional (chapter-toc? #f) (first? #t))
  (if (and (equal? (gi nd) (normalize "reference"))
	   (equal? (attribute-string (normalize "role") nd)
		   "folders"))
      (let alphaloop ((alist (alpha toclist)) 
		      (rest (alpha-rest toclist)))
	(if (node-list-empty? alist)
	    (empty-sosofo)
	    
	    (make sequence
	      
	      (make-element gi: "LI"
		    (make-element gi: "OBJECT"
			  attributes: '(("type" "text/sitemap"))
			  (make-empty-element gi: "param"
				attributes: (list (list "name" "Name")
						  (list "value" (case-fold-up (substring (element-title-string (node-list-first alist)) 0 1))))))
		    
		    (make-element gi: "UL"
			  (let loop ((nl alist))
			    (if (node-list-empty? nl)
				(empty-sosofo)
				(make-element gi: "LI"
				      (build-tocentry (node-list-first nl))
				      (build-toc (node-list-first nl) 
						 (- depth 1) chapter-toc? #f)
				      (loop (node-list-rest nl)))))))
	      (alphaloop (alpha rest) (alpha-rest rest)))))
      
      (let loop ((nl toclist))
	(if (node-list-empty? nl)
	    (empty-sosofo)
	    (make sequence
	      (make-element gi: "LI"
		    (build-tocentry (node-list-first nl))
		    (build-toc (node-list-first nl) 
			       (- depth 1) chapter-toc? #f))
	      (loop (node-list-rest nl)))))))

(define (build-toc nd depth #!optional (chapter-toc? #f) (first? #t))
  (let ((toclist (toc-list-filter 
		  (node-list-filter-by-gi (children nd)
					  (append (book-element-list)
						  (division-element-list)
						  (component-element-list)
						  (section-element-list))))))
    (if (or (<= depth 0) 
	    (node-list-empty? toclist)
	    (and chapter-toc?
		 (not %force-chapter-toc%)
		 (<= (node-list-length toclist) 1)))
	(empty-sosofo)
	(if first?
	    (build-toc-list nd depth toclist chapter-toc? first?)
	    (make-element gi: "UL"
		  (build-toc-list nd depth toclist chapter-toc? first?))))))





