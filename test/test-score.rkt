#lang racket

(require rackunit
         rackunit/text-ui
         "../composer.rkt")

; Test time signature
;
; Test section guard
;
; Test instrument part guard
;
; Test measure is valid

(define good-measure1
  (measure
    (note 'C 5 whole-note)))
(define good-measure2
  (measure
    (note 'C 5 half-note)
    (note 'C 5 quarter-note)
    (note 'C 5 eighth-note)
    (note 'C 5 dotted-sixteenth-note)
    (note 'C 5 thirtysecond-note)))

(define good-measure3
  (measure
    (note 'C 5 (subdivision half-note 3))
    (note 'C 5 (subdivision half-note 3))
    (note 'C 5 (subdivision half-note 3))
    (note 'C 5 (subdivision quarter-note 5))
    (note 'C 5 (subdivision quarter-note 5))
    (note 'C 5 (subdivision quarter-note 5))
    (note 'C 5 (subdivision quarter-note 5))
    (note 'C 5 (subdivision quarter-note 5))
    (note 'C 5 quarter-note)))

(define bad-measure1 ;; Measure is too long
  (measure
    (note 'C 5 (subdivision half-note 2))
    (note 'C 5 (subdivision half-note 2))
    (note 'C 5 (subdivision half-note 2))
    (note 'C 5 (subdivision quarter-note 5))
    (note 'C 5 (subdivision quarter-note 5))
    (note 'C 5 (subdivision quarter-note 5))
    (note 'C 5 (subdivision quarter-note 5))
    (note 'C 5 (subdivision quarter-note 5))
    (note 'C 5 quarter-note)))

(define bad-measure1 ;; Measure contains a non-note valud
  (measure
    "I'm a string!"
    (note 'C 5 (subdivision half-note 2))
    (note 'C 5 (subdivision half-note 2))
    (note 'C 5 (subdivision half-note 2))
    (note 'C 5 (subdivision quarter-note 5))
    (note 'C 5 (subdivision quarter-note 5))
    (note 'C 5 (subdivision quarter-note 5))
    (note 'C 5 (subdivision quarter-note 5))
    (note 'C 5 (subdivision quarter-note 5))
    (note 'C 5 quarter-note)))

(define score-tests
  (test-suite
    "score tests"
    (test-case
      "test create time signature")
      (let (;; These should all be created without error
            [commmon-time-sig1 (time-signature 4 4)]  
            [commmon-time-sig2 (time-signature 2 4)]  
            [commmon-time-sig3 (time-signature 3 4)]  
            [commmon-time-sig4 (time-signature 6 8)]  
            [commmon-time-sig5 (time-signature 3 8)]  
            [commmon-time-sig6 (time-signature 2 2)])
        (check-exn exn:fail?
                   (lambda ()
                     (time-signature "A" 4)))
        (check-exn exn:fail?
                   (lambda ()
                     (time-signature 0 4)))
        (check-exn exn:fail?
                   (lambda ()
                     (time-signature 4 0)))
    (test-case
      "test measure is valid")

    (test-case
      "test instrument part guard")
    (test-case
      "test section guard")))
