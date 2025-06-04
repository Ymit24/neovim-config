;; config/nvim/queries/shadow/highlights.scm

;; Comments
(comment) @comment

;; Instructions and their components
(address_instruction
  (at_sign) @operator
  (number) @number
  ;; Corrected part for labels in address instructions
)

(compute_instruction
  (destination) @variable.builtin  ;; Registers/destinations
  (expression) @variable          ;; The computation part
  (jmp) @keyword.conditional      ;; Jump mnemonics
)

(label_instruction
  (label) @label                  ;; Definition of a label
  ":" @punctuation.delimiter      ;; The colon for label definition
)

;; Components used within instructions
(number) @number
(label) @variable                 ;; General usage of a label (e.g., in expressions, if applicable)
(register) @variable.builtin      ;; A, D, M, 1 are built-in registers
(operator) @operator              ;; +, -, &, |, ~

;; Specific keywords/mnemonics
(jmp) @keyword.conditional         ;; JMP, JEQ, JLT, etc.
(at_sign) @operator                ;; The '@' symbol
(destination) @variable.builtin    ;; _, A, D, M as destinations

;; Punctuation
"=" @operator                      ;; Assignment operator
"#" @comment                       ;; Comment start
