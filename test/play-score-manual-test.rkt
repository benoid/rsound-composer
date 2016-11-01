#lang racket

(require "../composer-rsound.rkt")

(define sect
    (section
      (time-signature 4 4) 
      #:assert-time-sig #t
      (key-signature "") 
      #:tempo 180
      (instrument-part
        [vgame-synth-instrument 4]
        (measure
          (note 'G  3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'Bb 3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'G  3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'Bb 3 eighth-note)
          (note 'D  4 eighth-note))
        (measure
          (note 'G  3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'Bb 3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'G  3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'Bb 3 eighth-note)
          (note 'D  4 eighth-note))
        (measure
          (note 'G  3 eighth-note)
          (note 'Eb 4 eighth-note)
          (note 'C  4 eighth-note)
          (note 'Eb 4 eighth-note)
          (note 'G  3 eighth-note)
          (note 'Eb 4 eighth-note)
          (note 'C  4 eighth-note)
          (note 'Eb 4 eighth-note))
        (measure
          (note 'G  3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'Bb 3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'G  3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'Bb 3 eighth-note)
          (note 'D  4 eighth-note))
        (measure
          (note 'G  3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'Bb 3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'G  3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'Bb 3 eighth-note)
          (note 'D  4 eighth-note))
        (measure
          (note 'G  3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'Bb 3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'G  3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'Bb 3 eighth-note)
          (note 'D  4 eighth-note))
        (measure
          (note 'G  3 eighth-note)
          (note 'Eb 4 eighth-note)
          (note 'C  4 eighth-note)
          (note 'Eb 4 eighth-note)
          (note 'G  3 eighth-note)
          (note 'Eb 4 eighth-note)
          (note 'C  4 eighth-note)
          (note 'Eb 4 eighth-note))
        (measure
          (note 'G  3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'Bb 3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'G  3 eighth-note)
          (note 'D  4 eighth-note)
          (note 'Bb 3 eighth-note)
          (note 'D  4 eighth-note)))
      (instrument-part
        [vgame-synth-instrument 1]
        (measure
          (note 'D  5 eighth-note)
          (eighth-rest)
          (note 'D  5 eighth-note)
          (eighth-rest)
          (note 'D  5 eighth-note)
          (note 'Bb 4 eighth-note)
          (note 'G  4 eighth-note)
          (note 'Bb 4 eighth-note))
        (measure
          (eighth-rest)
          (note 'D  5 dotted-quarter-note)
          (note 'D  5 quarter-note)
          (note 'C  5 eighth-note)
          (note 'Bb 4 eighth-note))
        (measure
          (note 'C  5 eighth-note)
          (eighth-rest)
          (note 'C  5 eighth-note)
          (note 'D  5 eighth-note)
          (note 'C  5 eighth-note)
          (note 'Bb  4 eighth-note)
          (note 'A  4 eighth-note)
          (note 'C  5 eighth-note))
        (measure
          (eighth-rest)
          (note 'Bb 4 quarter-note)
          (note 'A  4 eighth-note)
          (note 'G  4 eighth-note)
          (note 'D 4 eighth-note)
          (note 'G 4 eighth-note)
          (note 'Bb 4 eighth-note))
        (measure
          (note 'D  5 eighth-note)
          (eighth-rest)
          (note 'D  5 eighth-note)
          (eighth-rest)
          (note 'D  5 eighth-note)
          (note 'Bb 4 eighth-note)
          (note 'G  4 eighth-note)
          (note 'Bb 4 eighth-note))
        (measure
          (eighth-rest)
          (note 'D  5 dotted-quarter-note)
          (note 'D  5 quarter-note)
          (note 'C  5 eighth-note)
          (note 'Bb 4 eighth-note))
        (measure
          (note 'C  5 eighth-note)
          (eighth-rest)
          (note 'C  5 eighth-note)
          (note 'D  5 eighth-note)
          (note 'C  5 eighth-note)
          (note 'Bb  4 eighth-note)
          (note 'A  4 eighth-note)
          (note 'F#  4 eighth-note))
        (measure
          (note 'G 4 half-note)
          (eighth-rest)
          (note 'D 4 eighth-note)
          (note 'G 4 eighth-note)
          (note 'Bb 4 eighth-note)))))

(define scr
  (score
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect
    sect))

(play-score scr)
(display "ctl-D to quit")
(read)

