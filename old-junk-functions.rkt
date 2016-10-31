
;; The default whole note length is the
;; length of an RSound piano tone
(define default-whole-note-length 132300)

;; Adjust the global whole-note length
(define (set-whole-note-length l)
  (set! default-whole-note-length (round l)))

;; Return the length of a whole note in frames
(define (whole-note-length)
  (* default-whole-note-length 1.15))

;; Return 0.5 the value of whole-note-length
(define (half-note-length)
  (round (* (whole-note-length) 0.5)))

;; Return 0.75 the value of whole-note-length
(define (dotted-half-note-length)
  (round (* (whole-note-length) 0.75)))

;; Return 0.25 the value of whole-note-length
(define (quarter-note-length)
  (round (* (whole-note-length) 0.25)))

;; Return 0.375 the value of whole-note-length
(define (dotted-quarter-note-length)
  (round (* (whole-note-length) 0.375)))

;; Return 0.4375 the value of whole-note-length
(define (double-dotted-quarter-note-length)
  (round (* (whole-note-length) 0.4375)))

;; Return 0.125 the value of whole-note-length
(define (eighth-note-length)
  (round (* (whole-note-length) 0.125)))

;; Return 0.1875 the value of whole-note-length
(define (dotted-eighth-note-length)
  (round (* (whole-note-length) 0.1875)))

;; Return 0.0625 the value of whole-note-length
(define (sixteenth-note-length)
  (round (* (whole-note-length) 0.0625)))

;; Return 0.09375 the value of whole-note-length
(define (dotted-sixteenth-note-length)
  (round (* (whole-note-length) 0.09375)))

;; Return 0.03125 the value of whole-note-length
(define (thirtysecond-note-length)
