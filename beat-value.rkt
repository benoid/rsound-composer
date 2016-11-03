#lang racket
(require "../define-argcheck.rkt")

(provide (except-out (all-defined-out)
                     dotted
                     double-dotted))

(struct beat-value [name frames])

(define (beat-value-procedure? beat-value-proc)
  (if (and (procedure? beat-value-proc)
           (= (procedure-arity beat-value-proc) 1))
    (let ([nl (beat-value-proc 1)])
      (if (beat-value? nl) #t #f))
    #f))

(define/argcheck (bpm-to-frames [tempo exact-positive-integer? "exact-positive-integer?"])
  (if (= tempo 0) 
    0
  (round (* (/ 60 tempo) 44100))))

(define/argcheck (whole-note [tempo exact-positive-integer? "exact-positive-integer?"])
  (beat-value 
    'WholeNote 
    (* (bpm-to-frames tempo) 4)))

(define/argcheck (half-note [tempo exact-positive-integer? "exact-positive-integer?"])
  (beat-value 
    'HalfNote 
    (* (bpm-to-frames tempo) 2)))

(define/argcheck (quarter-note [tempo exact-positive-integer? "exact-positive-integer?"])
  (beat-value 
    'QuarterNote 
    (bpm-to-frames tempo)))

(define/argcheck (eighth-note [tempo exact-positive-integer? "exact-positive-integer?"])
  (beat-value 
    'EighthNote 
    (round (* (bpm-to-frames tempo) 0.5))))

(define/argcheck (sixteenth-note [tempo exact-positive-integer? "exact-positive-integer?"])
  (beat-value 
    'SixteenthNote 
    (round (* (bpm-to-frames tempo) 0.25))))

(define/argcheck (thirtysecond-note [tempo exact-positive-integer? "exact-positive-integer?"])
  (beat-value 
    'ThirtysecondNote 
    (round (* (bpm-to-frames tempo) 0.125))))

(define/argcheck (dotted [nl beat-value? "beat-value"])
  (beat-value
    (string->symbol 
      (string-join 
        (list "Dotted" (symbol->string (beat-value-name nl)))""))
    (round (* (beat-value-frames nl) 1.5))))

(define/argcheck (double-dotted [nl beat-value? "beat-value"])
  (beat-value
    (string->symbol 
      (string-join 
        (list "DoubleDotted" (symbol->string (beat-value-name nl)))""))
    (round (* (beat-value-frames nl) 1.75))))

;; Needs test
(define (subdivision base-length-proc subdivision)
  (lambda (tempo)
    (let ([base-length (base-length-proc tempo)])
      (beat-value
        (string->symbol
          (string-join
            (list
              "Subdivision" 
              (number->string subdivision)
              (symbol->string (beat-value-name base-length)))))
        (round (/ (beat-value-frames base-length) subdivision ))))))


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
(define/argcheck (beat-value->fraction
                   [nl beat-value? "beat-value"])
  (cond 
        ((eq? (beat-value-name nl) 'WholeNote) 1)
        ((eq? (beat-value-name nl) 'HalfNote) 1/2)
        ((eq? (beat-value-name nl) 'QuarterNote) 1/4)
        ((eq? (beat-value-name nl) 'EighthNote) 1/8)
        ((eq? (beat-value-name nl) 'SixteenthNote) 1/16)
        ((eq? (beat-value-name nl) 'ThirtysecondNote) 1/32)

        ((eq? (beat-value-name nl) 'DottedWholeNote) 3/2)
        ((eq? (beat-value-name nl) 'DottedHalfNote) 3/4)
        ((eq? (beat-value-name nl) 'DottedQuarterNote) 3/8)
        ((eq? (beat-value-name nl) 'DottedEighthNote) 3/16)
        ((eq? (beat-value-name nl) 'DottedSixteenthNote) 3/32)

        ((eq? (beat-value-name nl) 'DoubleDottedWholeNote) 7/4)
        ((eq? (beat-value-name nl) 'DoubleDottedHalfNote) 7/8)
        ((eq? (beat-value-name nl) 'DoubleDottedQuarterNote) 7/16)
        ((eq? (beat-value-name nl) 'DoubleDottedEighthNote) 7/32)
        ((string=? 
           (substring (symbol->string (beat-value-name nl)) 0 11)
           "Subdivision")
         (let* ([beat-value-name-str 
                  (symbol->string (beat-value-name nl))]
                [subdivision 
                 (string->number 
                   (list-ref 
                     (string-split beat-value-name-str " ") 1))]
                [base-length-symbol
                  (string->symbol
                    (string-trim 
                      (string-trim 
                          beat-value-name-str 
                                 "Subdivision " #:right? #f)
                                 (string-append (number->string subdivision) " ") 
                                 #:right? #f))])
                (/ (beat-value->fraction 
                     (beat-value base-length-symbol 1)) subdivision)))

        (else (error "invalid note length: " (beat-value-name nl)))))

        
