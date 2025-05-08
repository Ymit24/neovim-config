; "function" @keyword
; "begin" @keyword
; "end" @keyword
; "with" @keyword
; "return" @keyword
; "returns" @keyword
; "if" @keyword
; "while" @keyword
; "is" @keyword

;; Keywords
(function_definition (identifier)) @function.defintion
;; (constant_declaration (constant_keyword)) @keyword
"structure" @keyword
"constant" @constant
"function_pointer" @keyword
"returns" @keyword
"begin" @keyword
"end" @keyword
"with" @keyword
"assembly" @keyword
"raw_assembly" @keyword
"if" @keyword
"while" @keyword
"return" @keyword
;
; ;; Types
(type) @type
(identifier) @variable
(macro (function_call name: (identifier) @constant.builtin)) @constant.builtin
(string) @string
(number) @number
(comment) @comment

; (type) @type
; (_type_with_modifiers) @type
;
; ;; Function Calls
; (function_call (identifier) @function)
;
; ;; Constants
; (constant_declaration (identifier) @constant.builtin)
; (constant_declaration "=" @operator)
;
; ;; Identifiers
; (identifier) @variable
;
; ;; Strings
; (string) @string
;
; ;; Numbers
; (number) @number
;
; ;; Operators
; (binary_expression
;   ("+" @operator)
;   ("-" @operator)
;   ("*" @operator)
;   ("/" @operator)
;   ("or" @operator)
;   ("and" @operator)
;   ("<" @operator)
;   (">" @operator)
;   ("<=" @operator)
;   (">=" @operator)
;   ("==" @operator)
;   ("!=" @operator))
;
; ;; Comments
; (comment) @comment
;
; ;; Struct and Structure Fields
; (struct_field (identifier) @field)
; (structure_field (identifier) @field)
;
; ;; Assembly Instructions (generic for now)
; (_assembly_instruction) @keyword
;
; ;; Array Access
; (array_access (identifier) @variable)
; (array_access "[" @punctuation.bracket)
; (array_access "]" @punctuation.bracket)
;
; ;; Function Definition
; (function_definition
;   (identifier) @function.definition)
;
; ;; Parameters
; (parameter_list (identifier) @variable.parameter)
;
; ;; Type Casting
; (type_cast "as" @keyword)
; (type_cast "(" @punctuation.bracket)
; (type_cast ")" @punctuation.bracket)
