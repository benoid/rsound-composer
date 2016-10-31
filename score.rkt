#lang racket

(require "../define-argcheck.rkt"
         "note-length.rkt"
         "note.rkt")
(provide (all-defined-out))

;; Write test for guard
(struct time-signature [beats-per-measure
                        type-of-beat]
  #:guard (lambda (beats-per-measure
                    type-of-beat
                    name)
            (if (and (exact-nonnegative-integer? beats-per-measure)
                     (exact-nonnegative-integer? type-of-beat)
                     (or (= (modulo type-of-beat 2) 0)
                         (= type-of-beat 1)))
              (values beats-per-measure type-of-beat)
              (error "invalid arguments: expected arguments of type:
                   <exact-nonnegative-intager> where
                   type-of-beat is 1 or is divisible by 2" ))))


(define (key-signature k) k)

; Score
(struct struct-score [section-list])
(define score? struct-score?)
(define score-section-list struct-score-section-list)
(define (score . sections)
  (struct-score sections))

; Section
(struct struct-section 
  [time-sig key-sig tempo instrument-part-list])

;; Write test for guard
;; Make key-sig a keyword
(define (section time-sig 
                 #:assert-time-sig [assert-time-sig? #t] 
                 key-sig 
                 #:tempo [tempo 120]
                 . instrument-parts)
  (let ([new-section 
          (struct-section time-sig key-sig tempo instrument-parts)])
      (if (and assert-time-sig? 
               (not 
                 (andmap 
                   (lambda (ip)
                     (instr-part-is-valid? ip time-sig)) 
                   instrument-parts)))
        (error 
          "one or more measures do not match the section time signature")

    new-section)))


(define section-time-sig struct-section-time-sig)
(define section-key-sig struct-section-key-sig)
(define section-tempo struct-section-tempo)
(define section-instr-part-list struct-section-instrument-part-list)

;; Instrument Part
(struct struct-instrument-part [instrument measure-list])
(define instrument-part? struct-instrument-part?)
(define instr-part-instrument struct-instrument-part-instrument)
(define instr-part-measure-list struct-instrument-part-measure-list)
(define (instrument-part instrument . measures)
  (struct-instrument-part instrument measures))

;; Needs test
(define (instr-part-is-valid? instr-part time-sig)
  (cond ((not (instrument-part? instr-part)) 
         (error 
           "expected argument 1 to be of type: <#struct-instrument-part>"))
        ((not (time-signature? time-sig))
         (error 
           "expected argument 2 to be of type: <#time-signature>"))
        (else 
          (andmap (lambda (m)
                    (measure-is-valid? m time-sig))
                  (instr-part-measure-list instr-part)))))


;; Write test for guard
(struct struct-measure [notes]
  #:guard (lambda (notes name)
            (if (list? notes)
              (values notes)
              (error "expected list"))))

(define measure? struct-measure?)
(define measure-notes struct-measure-notes)
(define (measure . notes)
  (struct-measure notes))

;; Needs test
(define (measure-is-valid? meas time-sig)
  (cond ((not (measure? meas)) 
         (error "expected argument 1 to be of type: <#struct-measure>"))
        ((not (time-signature? time-sig))
         (error "expected argument 2 to be of type: <#time-signature>"))
        (else 
          (equal? 
            (foldl (lambda (n v)
                      (if (not (note? n))
                        (error "expected list of type: <#note>")
                        (+ (note-length->fraction ((note-duration n) 0)) v)))
                   0
                   (measure-notes meas))
            (/ (time-signature-beats-per-measure time-sig) 
               (time-signature-type-of-beat time-sig))))))
