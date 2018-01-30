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
;;      This program is a script file. 
;;      if OS is Linux, you need to add execute permission to the file.
;;      The number of arguments is one.
;;      The output file name is generated automatically.
;;      if OS is Windows, launch the Command Prompt,
;;      and enter the command as follows:
;;              gosh  easy_view_bookmarkfile.scm  input-bookmark-html-file
;;      if OS is Windows10, please check the method of launch the Command 
;;      Prompt  by the internet.
;; 
;;  VERSION
;;      0.9.0
;;
;;  REQUIREMENT
;;      Gauche (an implementation of the Scheme programming language)
;;          https://practical-scheme.net/gauche/index.html
;;
;;        Gauche also runs on Windows with MinGW.
;;        Gauche runs using MinGW.
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
(define DD_flag #f )
(define DoNotEdit_flag #f )
(define windows_flag #f )



(define (my_newline port)
  (if windows_flag
      (begin
	(display "\x0d\x0a" port)
	)
      (begin
	(display "\x0a" port)
	)
      )
  )


(define (write_1line line_str)
  (display line_str output_port)
  (my_newline output_port)
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

	;; Write the mark of folder end to the output file.
	(if (>= folder_depth 1) 
	    (let ( (depth_str (number->string folder_depth))
		   (indentation_str ((rxmatch #/^\s*/i line_str)) )
		   )
	      (set! line_str (string-append indentation_str
					    "%%%%%%" depth_str) )
	      (write_1line line_str)
	      )
	    )
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
	;; Add </DT> after </H3>.
	(if (not (rxmatch #/<\/DT>/i  line_str) )
	    (begin
	      (set! line_str (regexp-replace #/<\/H3>/i  line_str  "</H3></DT>") )
	      )
	    )
	;; Add </p> after </DT>.
	(set! line_str (regexp-replace #/<\/DT>/i  line_str  "</DT></p>") )
	;; Delete ADD_DATE=...
	(set! line_str (regexp-replace #/ +ADD_DATE *= *\".*\"/i
				       line_str  "") )
	;; Delete LAST_MODIFIED=...
	(set! line_str (regexp-replace #/ +LAST_MODIFIED *= *\".*\"/i
				       line_str  "") )
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
	;; Delete ADD_DATE=...
	(set! line_str (regexp-replace #/ +ADD_DATE *= *\".*\"/i
				       line_str  "") )
	;; Delete LAST_MODIFIED=...
	(set! line_str (regexp-replace #/ +LAST_MODIFIED *= *\".*\"/i
				       line_str  "") )
	;; Delete LAST_VISIT=...
	(set! line_str (regexp-replace #/ +LAST_VISIT *= *\".*\"/i
				       line_str  "") )
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

	;; Set DD_flag.
	(set! DD_flag  #t)
	;; Return true
	#t
	)
      )
)


(define (modify_DD_tag_2nd line_str)
  (if (not DD_flag)
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
	      
	      ;; Clear DD_flag
	      (set! DD_flag  #f)
	      ;; Return false
	      #f
	      )
	    )
	)
      )
)



(define (modify_DOCTYPE_comment line_str)
   ;; judgement whether it is a line of <!DOCTYPE
   (if (not (rxmatch #/^ *<!DOCTYPE +/i  line_str) )
      (begin
	;; If it is a mismatched line, return false.
	#f
	)
      (begin
	;; set DOCTYPE 'DTD HTML 4.01'
	(set! line_str 
	      "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">" )

	;; Write the modified line to the output file.
	(write_1line line_str)
	;; Return true
	#t
	)
      )
)



(define (modify_DoNotEdit_comment_1st line_str)
   ;; judgement whether it is beginning of DoNotEdit comment
   (if (not (rxmatch #/<!-- *This +is +an +automatically +generated +file/i  line_str) )
      (begin
	;; If it is a mismatched line, return false.
	#f
	)
      (begin
	;; Since the line of DoNotEdit comment is deleted,
	;;  it is not written to the output file.

	;; Set DoNotEdit_flag.
	(set! DoNotEdit_flag  #t)
	;; Return true
	#t
	)
      )
)


(define (modify_DoNotEdit_comment_2nd line_str)
  (if (not DoNotEdit_flag)
      (begin
	;; If it is not in the process of DoNotEdit comment
	#f
	)
      (begin
	;; If processing of DoNotEdit comment is in progress

        ;; judgement whether it is end of DoNotEdit comment
	(if (not (rxmatch #/Do +Not +Edit! *-->/i  line_str) )
	    (begin
	      ;; If it is a mismatched line,
	      ;;  delete the line, assuming that line is 
	      ;;   middle of DoNotEdit comment.
	      ;; So do not write to the output file.
	      
	      ;; Return true
	      #t
	      )
	    (begin
	      ;; This line is end of DoNotEdit comment.
	      
	      ;; Clear DoNotEdit_flag
	      (set! DoNotEdit_flag  #f)
	      ;; Return true
	      #t
	      )
	    )
	)
      )
)



(define (procedure_one_line line_str)

  (cond
   ( (modify_DoNotEdit_comment_2nd  line_str) #t )
   ( (modify_DD_tag_2nd  line_str) #t )
   ( (modify_DL_tag  line_str) #t )
   ( (modify_end_DL_tag  line_str) #t )
   ( (modify_DT_H3_str  line_str) #t )
   ( (modify_DT_A_HREF_str  line_str) #t )
   ( (modify_DD_tag_1st  line_str) #t )
   ( (modify_DOCTYPE_comment  line_str) #t )
   ( (modify_DoNotEdit_comment_1st  line_str) #t )
   ( else
     ;; Write the read line to the output file without change.
     (write_1line line_str)
     #t
     )
   )

  )


(define (read_bookmark_file)
  (set! folder_depth 0 )
  (set! DD_flag  #f)
  (set! DoNotEdit_flag  #f)

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

  (cond-expand
   [gauche.os.windows
    (set! windows_flag #t)
    ]
   [else
    (set! windows_flag #f)
    ]
  )

  (if (or (null? (cdr args)) (length>? args 2) )
      (print_usage )
      )

  (change_bookmark_easy_read (list-ref args 1) )
)



