#!/usr/bin/env gosh
;; 
;;  NAME
;;      easy_view_bookmarkfile.scm
;; 
;;  SYNOPSIS
;;      easy_view_bookmarkfile.scm  input-bookmark-html-file
;; 
;;  DESCRIPTION
;;      Some web browsers export bookmark HTML file.
;;      Its file can be displayed by web browser.
;;      This program changes bookmark file to be easy to view.
;;      The output file name is generated automatically.
;; 
;;  VERSION
;;      0.9.0
;;
;;  REQUIREMENT
;;      Gauche (an implementation of the Scheme programming language)
;;          https://practical-scheme.net/gauche/index.html
;;
;;        Gauche also runs on Windows with MinGW.
;;        UNIX commands can run on MinGW.
;; 
;; 
;;  LICENSE 
;;      Copyright (c) 2018 Hidetomo Tanaka
;;      Released under the MIT license
;;      http://opensource.org/licenses/mit-license.php
;; 


(define input_port '() )
(define output_filename '() )
(define output_port '() )
(define folder_depth 0 )
(define DD_flg #f )


(define (write_1line line_str)
  (display line_str output_port)
  (newline output_port)
  )


(define (modify_DL_tag line_str)
   ;; judgement whether it is a line of <DL>
   (if (not (rxmatch #/<DL>/i  line_str) )
      (begin
	;; If it is a mismatched line, return false.
	#f
	)
      (begin
	;; Change <DL> to <ul>.
	(set! line_str (regexp-replace #/<DL>/i  line_str  "<ul>") )
	;; Delete <p>.
	(set! line_str (regexp-replace #/<p>/i  line_str  "") )
	;; Add 1 to the variable folder_depth.
	(set! folder_depth (+ folder_depth 1))
	;; Write the modified line to the output file.
	(write_1line line_str)
	;; Return true
	#t
	)
      )
)


(define (modify_end_DL_tag line_str)
   ;; judgement whether it is a line of </DL>
   (if (not (rxmatch #/<\/DL>/i  line_str) )
      (begin
	;; If it is a mismatched line, return false.
	#f
	)
      (begin
	;; Change </DL> to </ul>.
	(set! line_str (regexp-replace #/<\/DL>/i  line_str  "</ul>") )
	;; Subtract 1 from the variable folder_depth.
	(set! folder_depth (- folder_depth 1))
	;; Write the modified line to the output file.
	(write_1line line_str)
	;; Return true
	#t
	)
      )
)



(define (modify_DT_H3_str line_str)
   ;; judgement whether it is a line of <DT><H3
   (if (not (rxmatch #/<DT> *<H3/i  line_str) )
      (begin
	;; If it is a mismatched line, return false.
	#f
	)
      (begin
	;; Add <p> before <DT>.
	(set! line_str (regexp-replace #/<DT>/i  line_str  "<p><DT>") )
	;; Insert "    ######"  before </H3>,
	;; and print the value of the variable folder_depth.
	(let ((repl_str "")
	      (depth_str (number->string folder_depth))
	      )
	      (set! repl_str (string-append "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" 
					    "######" depth_str "</H3>"))
	      (set! line_str (regexp-replace #/<\/H3>/i  line_str  repl_str) )
	      )
	;; Add </p> after </H3>.
	(if (rxmatch #/<\/DT>/i  line_str)
	    (begin
	      (set! line_str (regexp-replace #/<\/DT>/i  line_str  "</DT></p>") )
	      )
	    (begin
	      (set! line_str (regexp-replace #/<\/H3>/i  line_str  "</H3></p>") )
	      )
	    )
	;; Write the modified line to the output file.
	(write_1line line_str)
	;; Return true
	#t
	)
      )
)




(define (modify_DT_A_HREF_str line_str)
   ;; judgement whether it is a line of <DT><A HREF=
   (if (not (rxmatch #/<DT><A +HREF *=/i  line_str) )
      (begin
	;; If it is a mismatched line, return false.
	#f
	)
      (begin
	;; Change <DT> to <li>.
	(set! line_str (regexp-replace #/<DT>/i  line_str  "<li>") )
	;; Add </li> at the end of the line.
	(set! line_str  (string-append line_str "</li>") )
	;; Delete ICON_URI=...
	(set! line_str (regexp-replace #/ +ICON_URI *= *\".*\"/i
				       line_str  "") )
	;; Delete ICON=...
	(set! line_str (regexp-replace #/ +ICON *= *\".*\"/i  line_str  "") )
	;; Write the modified line to the output file.
	(write_1line line_str)
	;; Return true
	#t
	)
      )
)



(define (modify_DD_tag_1st line_str)
   ;; judgement whether it is a line of <DD>
   (if (not (rxmatch #/<DD>/i  line_str) )
      (begin
	;; If it is a mismatched line, return false.
	#f
	)
      (begin
	;; Since the line of <DD> is deleted,
	;;  it is not written to the output file.

	;; Set DD_flg.
	(set! DD_flg  #t)
	;; Return true
	#t
	)
      )
)


(define (modify_DD_tag_2nd line_str)
  (if (not DD_flg)
      (begin
	;; If it is not in the process of <DD>
	#f
	)
      (begin
	;; If processing of <DD> is in progress

	;; judgement whether the line of the next HTML tag has started
	(if (not (rxmatch #/^[\x20\t]*<\/*[A-Z][A-Z0-9]*[>\x20]/i  line_str) )
	    (begin
	      ;; If it is a mismatched line,
	      ;;  delete the line, assuming that line is 
	      ;;   a character string of continuation of <DD>.
	      ;; So do not write to the output file.
	      
	      ;; Return true
	      #t
	      )
	    (begin
	      ;; Since the line of the next HTML tag has started, 
	      ;; This line is processed by a subsequent program.
	      
	      ;; Clear DD_flg
	      (set! DD_flg  #f)
	      ;; Return false
	      #f
	      )
	    )
	)
      )
)



(define (procedure_one_line line_str)

  (cond
   ( (modify_DD_tag_2nd  line_str) #t )
   ( (modify_DL_tag  line_str) #t )
   ( (modify_end_DL_tag  line_str) #t )
   ( (modify_DT_H3_str  line_str) #t )
   ( (modify_DT_A_HREF_str  line_str) #t )
   ( (modify_DD_tag_1st  line_str) #t )
   ( else
     ;; Write the read line to the output file without change.
     (write_1line line_str)
     #t
     )
   )
  
  )


(define (read_bookmark_file)
  (set! folder_depth 0 )
  (set! DD_flg  #f)

  (let read_loop ((line_str (read-line input_port)))
    (when (not (eof-object? line_str))
	  (procedure_one_line line_str)
	  (read_loop (read-line input_port))
	  )
    )
  )


(define (print_file_open_error filename)
  (format (current-error-port)
          "couldn't open input file: ~a\n" filename)
  )


(define (make_output_file_name filename_org)
  (define match_obj (rxmatch #/\.html?/i  filename_org) )
  (if (match_obj)
      (begin 
	(regexp-replace #/\.html?/i  filename_org 
			(string-append "_esvwbk" (match_obj)) )
	)
      (begin 
	(string-append filename_org ".esvwbk" )
	)
      )
  )


(define (change_bookmark_easy_read input_filename)
  (guard (exc [(<error> exc)  
	       (print_file_open_error input_filename)  (exit 2) ])
	 (set! input_port (open-input-file input_filename))
	 )

  (set! output_filename (make_output_file_name  input_filename) )
  (set! output_port (open-output-file output_filename))

  (print (string-append "Output file name:  " output_filename) )
  (read_bookmark_file)

  (close-input-port input_port)
  (close-output-port output_port)
  )


(define (print_usage )
  (format (current-error-port)
          "Usage:  easy_view_bookmarkfile.scm  input-bookmark-html-file\n" )
  (exit 2)
  )


(define (main args)
  (if (or (null? (cdr args)) (length>? args 2) )
      (print_usage )
      )
  
  (change_bookmark_easy_read (list-ref args 1) )
)

