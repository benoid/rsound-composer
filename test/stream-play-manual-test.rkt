#lang racket

(require "../composer-rsound.rkt")

(provide (all-defined-out))

(define scr
  (score
    (section 
      (time-signature 4 4) 
      (key-signature "") 
      #:tempo 120
      (instrument-part
        [vgame-synth-instrument 4]
        (measure
          (note 'C 4 eighth-note)
          (note 'D 4 eighth-note)
          (note 'E 4 eighth-note)
          (note 'F 4 eighth-note)
          (note 'G 4 eighth-note)
          (note 'E 4 eighth-note)
          (note 'C 4 eighth-note)
          (note 'B 3 eighth-note))
        (measure
          (note 'C 4 eighth-note)
          (note 'D 4 eighth-note)
          (note 'E 4 eighth-note)
          (note 'F 4 eighth-note)
          (note 'G 4 eighth-note)
          (note 'E 4 eighth-note)
          (note 'C 4 quarter-note)))
      (instrument-part
        [vgame-synth-instrument 4]
        (measure
          (note 'C 4 eighth-note)
          (note 'B 3 eighth-note)
          (note 'C 4 eighth-note)
          (note 'D 4 eighth-note)
          (note 'B 3 eighth-note)
          (note 'C 4 eighth-note)
          (note 'A 3 eighth-note)
          (note 'G 3 eighth-note))
        (measure
          (note 'C 4 eighth-note)
          (note 'B 3 eighth-note)
          (note 'C 4 eighth-note)
          (note 'D 4 eighth-note)
          (note 'B 3 eighth-note)
          (note 'C 4 eighth-note)
          (note 'A 3 eighth-note)
          (note 'G 3 eighth-note))))))


(play-score scr)
(display "ctl-D to quit")
(read)

