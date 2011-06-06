<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN">

<style-sheet>
<style-specification>
<style-specification-body>

(element chapter
  (make simple-page-sequence
    top-margin: 1in
    bottom-margin: 1in
    left-margin: 1in
    right-margin: 1in
    font-size: 12pt
    line-spacing: 14pt
    min-leading: 0pt
    (process-children)))

(element title
  (make paragraph
    font-weight: 'bold
    font-size: 18pt
    (process-children)))

(element para
  (make paragraph
    space-before: 8pt
    (process-children)))

(element emphasis
  (if (equal? (attribute-string "role") "strong")
      (make sequence
	font-weight: 'bold
	(process-children))
      (make sequence
	font-posture: 'italic
	(process-children))))

(element (emphasis emphasis)
  (make sequence
    font-posture: 'upright
    (process-children)))

(define (super-sub-script plus-or-minus
               #!optional (sosofo (process-children)))
  (make sequence
    font-size: (* (inherited-font-size) 0.8)
    position-point-shift: (plus-or-minus (* (inherited-font-size) 0.4))
    sosofo))

(element superscript (super-sub-script +))
(element subscript (super-sub-script -))

</style-specification-body>
</style-specification>
</style-sheet>
