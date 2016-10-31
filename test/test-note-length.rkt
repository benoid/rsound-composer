#lang racket

(require rackunit
         rackunit/text-ui
         "../note-length.rkt")

(define tempo-list (for/list ([i (in-range 4 21)]) (* i 10)))

(define note-length-tests
  (test-suite
    "note-length-tests"
    ;; This test case needs to be updated to 
    ;; reflect the changes in the frame calculation
    ;; algorithm
#;    (test-case
      "bpm-to-frames converts bpm to frames"
      (let ([freq-list (list 29400
                            36750
                            44100
                            51450
                            58800
                            66150
                            73500
                            80850
                            88200
                            95550
                            102900
                            110250
                            117600
                            124950
                            132300
                            139650
                            147000)])
        (check = (length tempo-list) (length freq-list))
        (for ([t tempo-list]
              [f freq-list])
             (check-equal? (bpm-to-frames t) f "could not convert bpm to frames")
             (check-equal? (note-length-frames (whole-note t)) 
                           (* (bpm-to-frames t) 4)
                           "create whole note failed: frames") 
             (check-equal? (note-length-frames (half-note t)) 
                           (* (bpm-to-frames t) 2)
                           "create half-note failed: frames") 
             (check-equal? (note-length-frames (quarter-note t)) 
                           (bpm-to-frames t)
                           "create quarter note failed: frames") 
             (check-equal? (note-length-frames (eighth-note t)) 
                           (round (* (bpm-to-frames t) 0.5))
                           "create eighth note failed: frames")
             (check-equal? (note-length-frames (sixteenth-note t)) 
                           (round (* (bpm-to-frames t) 0.25))
                           "create sixteenth note failed: frames")
             (check-equal? (note-length-frames (thirtysecond-note t)) 
                           (round (* (bpm-to-frames t) 0.125))
                           "create thirtysecond note failed: frames")
             (check-equal? (note-length-frames 
                             (dotted-quarter-note t)) 
                           (round (* (bpm-to-frames t) 1.5))
                           "create dotted quarter note failed: frames")
             (check-equal? (note-length-frames 
                             (double-dotted-quarter-note t)) 
                           (round (* (bpm-to-frames t) 1.75))
                           "create double dotted quarter note failed: frames")
             (check-equal? (note-length-name
                             (whole-note t)) 
                             'WholeNote
                           "create whole note failed: name")
             (check-equal? (note-length-name
                             (quarter-note t)) 
                             'QuarterNote
                           "create: quarter note failed: name")
             (check-equal? (note-length-name
                             (eighth-note t)) 
                             'EighthNote
                           "create: eighth note failed: name")
             (check-equal? (note-length-name
                             (sixteenth-note t)) 
                             'SixteenthNote
                           "create: sixteenth note failed: name")
             (check-equal? (note-length-name
                             (thirtysecond-note t)) 
                             'ThirtysecondNote
                           "create: thirtysecond note failed: name")
             (check-equal? (note-length-name
                             (dotted-quarter-note t)) 
                             'DottedQuarterNote
                           "create dotted quarter note failed: name")
             (check-equal? (note-length-name
                             (double-dotted-quarter-note t)) 
                             'DoubleDottedQuarterNote
                           "create double dotted quarter note failed: name")
             )))
    (test-case
      "test note-length->fraction"
      (check-equal? (note-length->fraction (whole-note 0)) 1)
      (check-equal? (note-length->fraction (half-note 0)) 1/2)
      (check-equal? (note-length->fraction (quarter-note 0)) 1/4)
      (check-equal? (note-length->fraction (eighth-note 0)) 1/8)
      (check-equal? (note-length->fraction (sixteenth-note 0)) 1/16)
      (check-equal? (note-length->fraction (thirtysecond-note 0)) 1/32)

      (check-equal? (note-length->fraction (dotted-whole-note 0)) 3/2)
      (check-equal? (note-length->fraction (dotted-half-note 0)) 3/4)
      (check-equal? (note-length->fraction (dotted-quarter-note 0)) 3/8)
      (check-equal? (note-length->fraction (dotted-eighth-note 0)) 3/16)
      (check-equal? (note-length->fraction (dotted-sixteenth-note 0)) 3/32)

      (check-equal? (note-length->fraction (double-dotted-whole-note 0)) 7/4)
      (check-equal? (note-length->fraction (double-dotted-half-note 0)) 7/8)
      (check-equal? (note-length->fraction (double-dotted-quarter-note 0)) 7/16)
      (check-equal? (note-length->fraction (double-dotted-eighth-note 0)) 7/32)
      )
    ))

(run-tests note-length-tests)
       
