#lang racket

(require "../define-argcheck.rkt"
         "note.rkt"
         "note-length.rkt")

(provide (except-out (all-defined-out)
                     make-rest))

(define/argcheck (make-rest 
                   [duration 
                    procedure? 
                    "note-length-procedure")
  (note 'Rest 0 duration))

(define/argcheck (rest? [n note? "note"])
  (equal? (note-letter n) 'Rest))

(define (whole-rest)
  (make-rest whole-note))
(define (half-rest)
  (make-rest half-note))
(define (quarter-rest)
  (make-rest quarter-note))
(define (eighth-rest)
  (make-rest eighth-note))
(define (sixteenth-rest)
  (make-rest sixteenth-note))
(define (thirtysecond-rest)
  (make-rest thirtysecond-note))

(define (dotted-whole-rest)
  (make-rest dotted-whole-note))
(define (dotted-half-rest)
  (make-rest dotted-half-note))
(define (dotted-quarter-rest)
  (make-rest dotted-quarter-note))
(define (dotted-eighth-rest)
  (make-rest dotted-eighth-note))
(define (dotted-sixteenth-rest)
  (make-rest dotted-sixteenth-note))

(define (double-dotted-whole-rest)
  (make-rest double-dotted-whole-note))
(define (double-dotted-half-rest)
  (make-rest double-dotted-half-note))
(define (double-dotted-quarter-rest)
  (make-rest double-dotted-quarter-note))
(define (double-dotted-eighth-rest)
  (make-rest double-dotted-eighth-note))

