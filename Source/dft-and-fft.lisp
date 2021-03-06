
;-------------------------------------------------------------------------------
;
;  dft-and-fft.lisp
;
;  a collection of Lisp functions concerning the discrete Fourier transform ...
;  Note:  before compiling and loading dft-and-fft.lisp,
;         you should compile and load (in the order listed)
;            sapa-package.lisp and utilities.lisp
;
;  6/3/93
;
;  SAPA, Version 1.0; Copyright 1993, Donald B. Percival, All Rights Reserved
;
;  Use and copying of this software and preparation of derivative works
;  based upon this software are permitted.  Any distribution of this
;  software or derivative works must comply with all applicable United
;  States export control laws.
;  package :SAPA (:USE :COMMON-LISP)))

;  This software is made available AS IS, and no warranty -- about the
;  software, its performance, or its conformity to any
;  specification -- is given or implied. 
;
;  Comments about this software can be addressed to dbp@apl.washington.edu
;-------------------------------------------------------------------------------

;;; The functions dft! and inverse-dft! implement the discrete Fourier
;;; transform and its inverse using, respectively, Equations (110a)
;;; and (111a) of the SAPA book.  They work on vectors of real
;;; or complex-valued numbers.  The vectors can be of any length.
;;; When the length of the input vector is a power of 2, these functions
;;; use fft!, a fast Fourier transform algorithm based upon one in Marple's
;;; 1987 book; when the length is not a power of 2, they use a chirp
;;; transform algorithm (as described in Section 3.10 of the SAPA book).
;;; Both functions return their results in the input vector and hence
;;; whip out whatever its contents were ---  hence we attach
;;; the stylistic "!" to the function names as a reminder
;;; that the function is mangling something given to it.

(defun dft! (x &key (N (length x)) (sampling-time 1.0))
  "Given:
   [1] x (required) <=> a vector of real or complex-valued numbers
   [2] N (keyword; length of x) ==> number of points in dft
   [3] sampling-time (keyword; 1.0)   
   returns:
   [1] x, with contents replaced by
      the discrete Fourier transform of x, namely,
                            N-1
      X(n) =  sampling-time SUM x(t) exp(-i 2 pi n t/N)
                            t=0
   Note: see Equation (110a) of the SAPA book."
  (cond
   ((power-of-2 N)
    (fft! x :N N))
   (t
    (dft-chirp! x :N N)))
  (when (not (= sampling-time 1.0))
    (dotimes (i N)
      (setf (aref x i) (* sampling-time (aref x i)))))
  x)
    
(defun inverse-dft! (X &key (N (length X)) (sampling-time 1.0))
  "Given:
   [1] X (required) <=> a vector of real or complex-valued numbers
   [2] N (keyword; length of ) ==> number of points in inverse dft
   [3] sampling-time (keyword; 1.0) 
   returns:
   [1] X, with contents replaced by the inverse discrete Fourier transform of X, namely, N-1
       x(t) =  (N sampling-time)^{-1} SUM X(n) exp(i 2 pi n t/N)
                                      n=0
   Note: see Equation (111a) of the SAPA book."
  (let ((1-over-N*sampling-time (/ (* N sampling-time))))
    (dotimes (i N)
      (setf (aref x i) (conjugate (aref x i))))
    (cond
     ((power-of-2 N)
      (fft! x :N N))
     (t
      (dft-chirp! x :N N)))
    (dotimes (i N x)
      (setf (aref x i) (* 1-over-N*sampling-time
                          (conjugate (aref x i)))))))

(defparameter +use-pre-fft-with-cache-p+ nil)

;;;  The following code is a Lisp version (with modifications) of
;;;  the FFT routines on pages 54--6 of ``Digital Spectral Analysis with
;;;  Applications'' by Marple, 1987.  The function fft! only works
;;;  for sample sizes which are powers of 2.
;;;  If the vector used as input to fft!  has elements x(0), ..., x(N-1),
;;;  the vector is modified on output to have elements X(0), ..., X(N-1),
;;;  where:
;;;                 N-1
;;;         X(k) =  SUM x(n) exp(-i 2 pi n k/N)
;;;                 n=0
;;;
;;;  If +use-pre-fft-with-cache-p+ is true, the complex exponential table
;;;  for N=2^P is stored in an array of length N pointed to by the P-th element
;;;  of *sapa-cached-pre-fft-arrays*.  The intent here is to speed things up
;;;  and reduce garbage collection (at the expense of extra storage), but the
;;;  timing speed up in MCL is only about 10% using the cache.
;;;
(defun fft! (complex-vector &key (N (length complex-vector)))
  "given:
   [1] complex-vector (required) <=> a vector of real or complex-valued numbers
   [2] N (keyword; length of complex-vector) ==> number of points (must be a power of 2)
       computes the discrete Fourier transform of complex-vector using a fast Fourier 
       transform algorithm and returns:
   [1] complex-vector, with contents replaced by
       the discrete Fourier transform of the input, namely, 
                N-1
       X(n) =   SUM x(t) exp(-i 2 pi n t/N)
                t=0
   Note: see Equation (110a) of the SAPA book with the sampling time set to unity."
  (let ((exponent (power-of-2 n))
        (W (if +use-pre-fft-with-cache-p+
             (pre-fft-with-cache n)
             (pre-fft n)))
        (MM 1)
        (LL n)
        NN JJ
        c1 c2)
    (dotimes (k exponent)
      (setf NN (/ LL 2)
            JJ MM)
      (do* ((i 0 (+ i LL))
            (kk NN (+ i NN)))
           ((>= i N))
        (setf c1 (+ (aref complex-vector i) (aref complex-vector kk))
              (aref complex-vector kk)
              (- (aref complex-vector i) (aref complex-vector kk))
              (aref complex-vector i) c1))
      (cond
       ((> NN 1)
        (do ((j 1 (1+ j)))
            ((>= j NN))
          (setf c2 (svref W JJ))
          (do* ((i j (+ i LL))
                (kk (+ j NN) (+ i NN)))
               ((>= i N))
            (setf c1 (+ (aref complex-vector i) (aref complex-vector kk))
                  (aref complex-vector kk)
                  (* (- (aref complex-vector i) (aref complex-vector kk))
                     c2)
                  (aref complex-vector i) c1))
          (incf jj MM))
        (setf LL NN)
        (setf MM (* MM 2)))))
    (let ((j 0)
          (nv2 (/ n 2))
          k)
      (dotimes (i (1- N))
        (if (< i j)
          (setf c1 (aref complex-vector j)
                (aref complex-vector j) (aref complex-vector i)
                (aref complex-vector i) c1))
        (setf k nv2)
        (loop
          (if (> k j) (return))
          (decf j k)
          (divf k 2))
        (incf j k)))
    complex-vector))

(defun inverse-fft! (complex-vector &key (N (length complex-vector)))
  "Given:
   [1] complex-vector (required) <=> a vector of real or complex-valued numbers
   [2] N (keyword; length of ) ==> number of points in inverse dft (must be a power of 2)
       computes the inverse discrete Fourier transform of complex-vector using a fast Fourier
       transform algorithm and returns:
   [1] complex-vector, with contents replaced by
       the inverse discrete Fourier transform of
       the input X(n), namely,
                   N-1
       x(t) =  1/N SUM X(n) exp(i 2 pi n t/N)
                   n=0
   Note: see Equation (111a) of the SAPA book with the sampling time set to unity."
  (dotimes (i N)
    (setf (aref complex-vector i)
          (conjugate (aref complex-vector i))))
  (fft! complex-vector :N N)
  (dotimes (i N complex-vector)
    (setf (aref complex-vector i)
          (/ (conjugate (aref complex-vector i)) N))))

(defun dft-chirp! (complex-vector &key (N (length complex-vector)))
  "Given:
   [1] complex-vector (required) <=> a vector of real or complex-valued numbers
   [2] N (keyword; length of complex-vector) ==> number of points (must be a power of 2)
       computes the discrete Fourier transform of complex-vector using a chirp transform 
       algorithm and returns:
   [1] complex-vector, with contents replaced by
       the discrete Fourier transform of the input, namely,
                N-1
       X(n) =   SUM x(t) exp(-i 2 pi n t/N)
                t=0

   Note: see Equation (110a) of the SAPA book with the sampling time set to unity and
      also Section 3.10 for a discussion on the chirp transform algorithm."
  (let* ((N-pot (next-power-of-2 (1- (* 2 N))))
         (chirp-data (make-array N-pot :initial-element 0.0))
         (chirp-factors (make-array N-pot :initial-element 0.0))
         (N-1 (1- N))
         (pi-over-N (/ pi N))
         (j 1)
         (N-pot-1-j (1- N-pot)))
    ;;; copy data into chirp-data, where it will get multiplied
    ;;; by the approriate chirp factors ...
    (copy-vector complex-vector chirp-data :end N)
    (setf (svref chirp-factors 0) 1.0
          (aref complex-vector 0) 1.0)
    ;;; note that, at the end of this dotimes form, complex-vector
    ;;; contains the complex conjugate of the chirp factors
    (dotimes (k N-1)
      (multf (svref chirp-data j)
             (setf (aref complex-vector j)
                   (conjugate
                    (setf (svref chirp-factors j)
                          (setf (svref chirp-factors N-pot-1-j)
                                (exp (complex 0.0 (* pi-over-N j j))))))))
      (incf j)
      (decf N-pot-1-j))
    (fft! chirp-data)
    (fft! chirp-factors)
    (dotimes (i N-pot)
      (multf (svref chirp-data i) (svref chirp-factors i)))
    (inverse-fft! chirp-data)
    (dotimes (i N complex-vector)
      (multf (aref complex-vector i) (svref chirp-data i)))))

;;;  Everything below here consists of internal symbols in the SAPA package
;;;  and should be regarded as "dirty laundry" ...
(defun pre-fft (n &key (complex-exp-vector nil))
  (if (power-of-2 n)
      (let* ((the-vector (if complex-exp-vector complex-exp-vector
                           (make-array n)))
             (s (/ (* 2 pi) n))
             (c1 (complex (cos s) (- (sin s))))
             (c2 (complex 1.0 0.0)))
        (dotimes (i n the-vector)
          (setf (aref the-vector i) c2
                c2 (* c2 c1))))))

;;; Saves results up to size (expt 2 31) = 2147483648
(defvar *sapa-cached-pre-fft-arrays* (make-array 32 :initial-element nil))

(defun pre-fft-with-cache (n)
  (declare (special *sapa-cached-pre-fft-arrays*))
  (let ((the-exponent (power-of-2 n)))
    (if (numberp the-exponent)
        (cond
         ;;; if the following cond clause is true, the effect is
         ;;; to return a pointer to the cached array
         ((aref *sapa-cached-pre-fft-arrays* the-exponent))
         (t
          (setf (aref *sapa-cached-pre-fft-arrays* the-exponent)
                (pre-fft n)))))))


;;;  The following code is a Lisp version (with modifications) of
;;;  the FFT routines on pages 36 to 38 of ``Modern Spectrum Estimation:
;;;  Theory and Application'' by Kay, 1988.
;;;  It only works for sample sizes that are powers of 2.
;;;  If the vector used as input to fft! has elements x(0), ..., x(N-1),
;;;  the vector is modified on output to have elements X(0), ..., X(N-1),
;;;  where:
;;;
;;;                 N-1
;;;         X(k) =  SUM x(n) exp(-i 2 pi n k/N)
;;;                 n=0
;;;
;;;  In MCL 2.0, it is slower than fft! (based upon Marple's
;;;  fft routine) by about a factor of 4.  This code can be speed up
;;;  by about 40% by creating a cache for the bit reversing operation, but
;;;  this still is not competitive with Marple's routine.
;;;
(defun fft-kay!
       (complex-vector
        &key
        (N (length complex-vector)))
  "given:
   [1] complex-vector (required)
       <=> a vector of real or complex-valued numbers
   [2] N (keyword)
       ==> length of vector (default = the length of complex-vector)
returns:
   [1] same complex vector used as input,
       but with contents altered to contain
       its Fourier transform"
  (let ((exponent (power-of-2 N))
        (scratch (make-array N))
        (N-1 (1- N))
        num J L)
    (declare (dynamic-extent scratch))
    ;;; This assertion fails if N is not a power of two 
    (assert exponent
            ()
            "vector input to fft! not a power of 2 (~A, ~D)"
            complex-vector N)
    (setf (svref scratch 0) (aref complex-vector 0)
          (svref scratch N-1) (aref complex-vector N-1))
    ;;; bit reverse the data (see Oppenheim and Schafer, 1989, p. 594)
    (dotimes (i (1- N-1))
      (setf num (1+ i)
            J 0
            L N)
      (dotimes (k exponent)
        (divf L 2)
        (when (>= num L)
          (incf j (expt 2 k))
          (decf num L)))
      (setf (svref scratch (1+ i)) (aref complex-vector j)))
    ;;; main computational loop ...
    (let ((ldft 1)
          (ndft N)
          (minus-two-pi (* -2 pi))
          arg w NP Nq save)
      (declare (dynamic-extent ldft ndft minus-two-pi
                               arg w NP Nq save))
      (dotimes (k exponent)
        (multf ldft 2)
        (divf ndft 2)
        (dotimes (i ndft)
          (dotimes (j (/ ldft 2))
            (setf arg (/ (* minus-two-pi j) ldft)
                  W (complex (cos arg) (sin arg))
                  NP (+ j (* ldft i))
                  NQ (+ NP (/ ldft 2))
                  save (+ (svref scratch NP)
                          (* W (svref scratch NQ)))
                  (svref scratch NQ) (- (svref scratch NP)
                                        (* W (svref scratch NQ)))
                  (svref scratch NP) save)))))
    ;;; overright original vector ...
    (dotimes (i N complex-vector)
      (setf (aref complex-vector i) (svref scratch i)))))

(defun inverse-fft-kay!
       (complex-vector
        &key
        (N (length complex-vector)))
  "given:
   [1] complex-vector (required)
       <=> a vector of real or complex-valued numbers
   [2] N (keyword)
       ==> length of vector (default = the length of complex-vector)
returns:
   [1] same complex vector used as input,
       but with contents altered to contain
       its inverse Fourier transform"
  (dotimes (i N)
    (setf (aref complex-vector i)
          (conjugate (aref complex-vector i))))
  (fft-kay! complex-vector)
  (dotimes (i N complex-vector)
    (setf (aref complex-vector i)
          (/ (conjugate (aref complex-vector i)) N))))

