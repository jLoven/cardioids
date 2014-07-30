;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname cardiod_animation) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp")))))
;created by Jackie Loven
;May 2013

;creates a countdown timer from t in blue numbers
(define (render t)
  (text (number->string t) 200 "blue"))

;a ball is a structure with an x and y
(define-struct ball (x y))

;trace-circle traces a circle in blue
(define (trace-circle t)
  (place-image (circle 1 "solid" "blue")
               (+ 50 (* 40 (cos (/ t 1))))
               (+ 50 (* 40 (sin (/ t 1))))
               (empty-scene 100 100)))

;makes a ball at the coordinates of the parametric equation for each different cardioid
;with respect to the variable t
(define (new-ball1 t)
  (make-ball 
   (+ 150 (* 40 (- (* 2 (cos (/ t 10)))
                              (cos (* 0.3 (/ t 1))))))
   (+ 150 (* 40 (- (* 2 (sin (/ t 10)))
                              (sin (* 0.3 (/ t 1))))))))
(define (new-ball2 t)
  (make-ball 
   (+ 450 (* 40 (- (* 2 (cos (/ t 10)))
                              (cos (* 1 (/ t 10))))))
   (+ 150 (* 40 (- (* 2 (sin (/ t 10)))
                              (sin (* 1 (/ t 10))))))))

(define (new-ball3 t)
  (make-ball 
   (+ 150 (* 40 (- (* 2 (cos (/ t 10)))
                              (cos (* 5 (/ t 5))))))
   (+ 450 (* 40 (- (* 2 (sin (/ t 10)))
                              (sin (* 5 (/ t 5))))))))

(define (new-ball4 t)
  (make-ball 
   (+ 450 (* 40 (- (* 2 (cos (/ t 10)))
                              (cos (* 3.9 (/ t 1.5))))))
   (+ 450 (* 40 (- (* 2 (sin (/ t 10)))
                              (sin (* 3.9 (/ t 1.5))))))))


;defines add-ball as adding a new ball to the list for each cardiod with t as the length 
;of the list divided by 4
(define (add-ball1 alist)
  (cons (new-ball1 (/ (length alist) 4)) 
  (cons (new-ball2 (/ (length alist) 4))
  (cons (new-ball3 (/ (length alist) 4))
  (cons (new-ball4 (/ (length alist) 4)) alist)))))

;defines draw-all-balls as making an empty-scene with the appropriate dimensions
;then recursively adds balls to the scene from the list with the specified locations
(define (draw-all-balls alist)
  (cond [(empty? alist)(empty-scene 600 600)]
        [else (place-image (circle 5 "solid" (make-color (random 255) (random 255) (random 255)))
                           (ball-x (car alist))
                           (ball-y (car alist))
                           (draw-all-balls (cdr alist)))]))

;(define (draw-line t) 
;  (place-image (draw-solid-line 10 90 "red")
;               (empty-scene 100 100))) 
;((draw-line world) 10 90 "red")  


;big-bang calls an empty list and on-tick calls the add-ball1 function to add balls to the list,
;then draw-all-balls is called to trace the cardiods
(big-bang empty
          (on-tick add-ball1)
         
          (to-draw draw-all-balls))