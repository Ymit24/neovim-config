;; Highlights for Monkey language

;; Program structure
(program) @none

;; Statements
(letStatement
  "let" @keyword.declaration
  name: (identifier) @variable
  "=" @operator
  value: (expression) @expression
  ";" @punctuation.delimiter)

(returnStatement
  "return" @keyword.return
  returnValue: (expression) @expression
  ";" @punctuation.delimiter)

(expressionStatement
  (expression) @expression
  ";" @punctuation.delimiter)

;; Expressions
(identifier) @variable

(integerLiteral) @number
(stringLiteral) @string
(booleanLiteral) @boolean

(prefixExpression
  operator: [ "!" "-" ] @operator
  right: (expression) @expression)

(infixExpression
  left: (expression) @expression
  operator: [ "+" "-" "*" "/" "<" ">" "==" "!=" ] @operator
  right: (expression) @expression)

"if" @keyword.conditional
"else" @keyword.conditional
"fn" @keyword.function
"return" @keyword.return

; (ifExpression
;   "if" @keyword.conditional
;   condition: (expression) @conditional
;   consequence: (blockStatement) @block
;   (elseClause
;     "else" @keyword.conditional
;     alternative: (blockStatement)? @block
;     alternative: (ifExpression)? @conditional.clause))

(functionLiteral
  "fn" @keyword.function
  parameters: (functionParameters
    "(" @punctuation.bracket
    (identifier) @parameter
    ("," @punctuation.delimiter (identifier) @parameter)*
    ")" @punctuation.bracket)
  body: (blockStatement) @block)

(callExpression
  function: (expression) @function.call
  arguments: (callArguments
    "(" @punctuation.bracket
    (expression) @argument
    ("," @punctuation.delimiter (expression) @argument)*
    ")" @punctuation.bracket))

(arrayLiteral
  "[" @punctuation.bracket
  (expression) @expression
  ("," @punctuation.delimiter (expression) @expression)*
  "]" @punctuation.bracket)

(indexExpression
  left: (expression) @expression
  "[" @punctuation.bracket
  index: (expression) @number
  "]" @punctuation.bracket)

(hashLiteral
  "{" @punctuation.bracket
  (hashPair
    key: (expression) @string
    ":" @operator
    value: (expression) @expression)
  ("," @punctuation.delimiter
    (hashPair
      key: (expression) @string
      ":" @operator
      value: (expression) @expression))*
  "}" @punctuation.bracket)

(groupedExpression
  "(" @punctuation.bracket
  (expression) @expression
  ")" @punctuation.bracket)

;; Blocks
(blockStatement
  "{" @punctuation.bracket
  (statement)* @statement
  "}" @punctuation.bracket)

;; Delimiters and operators
";" @punctuation.delimiter
"(" @punctuation.bracket
")" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket
"," @punctuation.delimiter
":" @operator
"=" @operator
"!" @operator
"-" @operator
"+" @operator
"*" @operator
"/" @operator
"<" @operator
">" @operator
"==" @operator
"!=" @operator
