" Adds new syntax rules for start screen
" to enable custom logo highlighting

syntax match StartifyHeaderBackground "\v\+" containedin=StartifyHeader
highlight link StartifyHeaderBackground Function

