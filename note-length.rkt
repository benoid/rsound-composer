#lang racket
(require "../define-argcheck.rkt")

(provide (except-out (all-defined-out)
                     dotted
                     double-dotted))

(struct note-length [name frames])

(define/argcheck (bpm-to-frames [tempo number? "number"])
  (if (= tempo 0) 
    0
  (round (* (/ 60 tempo) 44100))))

(define/argcheck (whole-note [tempo number? "number"])
  (note-length 
    'WholeNote 
    (* (bpm-to-frames tempo) 4)))

(define/argcheck (half-note [tempo number? "number"])
  (note-length 
    'HalfNote 
    (* (bpm-to-frames tempo) 2)))

(define/argcheck (quarter-note [tempo number? "number"])
  (note-length 
    'QuarterNote 
    (bpm-to-frames tempo)))

(define/argcheck (eighth-note [tempo number? "number"])
  (note-length 
    'EighthNote 
    (round (* (bpm-to-frames tempo) 0.5))))

(define/argcheck (sixteenth-note [tempo number? "number"])
  (note-length 
    'SixteenthNote 
    (round (* (bpm-to-frames tempo) 0.25))))

(define/argcheck (thirtysecond-note [tempo number? "number"])
  (note-length 
    'ThirtysecondNote 
    (round (* (bpm-to-frames tempo) 0.125))))

(define/argcheck (dotted [nl note-length? "note-length"])
  (note-length
    (string->symbol 
      (string-join 
        (list "Dotted" (symbol->string (note-length-name nl)))""))
    (round (* (note-length-frames nl) 1.5))))

(define/argcheck (double-dotted [nl note-length? "note-length"])
  (note-length
    (string->symbol 
      (string-join 
        (list "DoubleDotted" (symbol->string (note-length-name nl)))""))
    (round (* (note-length-frames nl) 1.75))))

;; Needs test
(define (subdivision base-length-proc subdivision)
  (lambda (tempo)
    (let ([base-length (base-length-proc tempo)])
      (note-length
        (string->symbol
          (string-join
            (list
              "Subdivision" 
              (number->string subdivision)
              (symbol->string (note-length-name base-length)))))
        (round (/ (note-length-frames base-length) subdivision ))))))


(define (dotted-whole-note tempo)
  (dotted (whole-note tempo)))
(define (dotted-half-note tempo)
  (dotted (half-note tempo)))
(define (dotted-quarter-note tempo)
  (dotted (quarter-note tempo)))
(define (dotted-eighth-note tempo)
  (dotted (eighth-note tempo)))
(define (dotted-sixteenth-note tempo)
  (dotted (sixteenth-note tempo)))
(define (dotted-thirtysecond-note tempo)
  (dotted (thirtysecond-note tempo)))

(define (double-dotted-whole-note tempo)
  (double-dotted (whole-note tempo)))
(define (double-dotted-half-note tempo)
  (double-dotted (half-note tempo)))
(define (double-dotted-quarter-note tempo)
  (double-dotted (quarter-note tempo)))
(define (double-dotted-eighth-note tempo)
  (double-dotted (eighth-note tempo)))
(define (double-dotted-sixteenth-note tempo)
  (double-dotted (sixteenth-note tempo)))
(define (double-dotted-thirtysecond-note tempo)
  (double-dotted (thirtysecond-note tempo)))

;; Update test to include subdivision
(define/argcheck (note-length->fraction
                   [nl note-length? "note-length"])
  (cond 
        ((eq? (note-length-name nl) 'WholeNote) 1)
        ((eq? (note-length-name nl) 'HalfNote) 1/2)
        ((eq? (note-length-name nl) 'QuarterNote) 1/4)
        ((eq? (note-length-name nl) 'EighthNote) 1/8)
        ((eq? (note-length-name nl) 'SixteenthNote) 1/16)
        ((eq? (note-length-name nl) 'ThirtysecondNote) 1/32)

        ((eq? (note-length-name nl) 'DottedWholeNote) 3/2)
        ((eq? (note-length-name nl) 'DottedHalfNote) 3/4)
        ((eq? (note-length-name nl) 'DottedQuarterNote) 3/8)
        ((eq? (note-length-name nl) 'DottedEighthNote) 3/16)
        ((eq? (note-length-name nl) 'DottedSixteenthNote) 3/32)

        ((eq? (note-length-name nl) 'DoubleDottedWholeNote) 7/4)
        ((eq? (note-length-name nl) 'DoubleDottedHalfNote) 7/8)
        ((eq? (note-length-name nl) 'DoubleDottedQuarterNote) 7/16)
        ((eq? (note-length-name nl) 'DoubleDottedEighthNote) 7/32)
        ((string=? 
           (substring (symbol->string (note-length-name nl)) 0 11)
           "Subdivision")
         (let* ([note-length-name-str 
                  (symbol->string (note-length-name nl))]
                [subdivision 
                 (string->number 
                   (list-ref 
                     (string-split note-length-name-str " ") 1))]
                [base-length-symbol
                  (string->symbol
                    (string-trim 
                      (string-trim 
                          note-length-name-str 
                                 "Subdivision " #:right? #f)
                                 (string-append (number->string subdivision) " ") 
                                 #:right? #f))])
                (/ (note-length->fraction 
                     (note-length base-length-symbol 0)) subdivision)))

        (else (error "invalid note length: " (note-length-name nl)))))

        
