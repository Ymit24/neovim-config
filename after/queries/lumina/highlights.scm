(function_declaration 
  name: (identifier) @function
  (parameter_list
    ((identifier) @variable))
)

(function_declaration
  (parameter_list
    self: (_) @keyword
    )
  )

((return_type (_) @type))

((identifier) @identifier)

((primitive_type) @type)
((array_type) @type)
((reference_type) @type)

((variable_declaration mutability: (_) @keyword))

((number) @number)

(struct_declaration
  name: (_) @variable)

(exp_literal (string) @string)

(compiler_directive (_) @macro)

(exp_literal (scoped_identifier) @variable)

(["*" "&" "+" "(" ")" "[" "]" ] @operator)
([
  "fn"
  "struct"
  "with"
  "extend"
  "extension"
  "return"
  "case"
  "if"
  "for"
  "export"
  "import"
  "and"
  "from"
  ] @keyword)
