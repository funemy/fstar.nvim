" Vim syntax file
" Language:     F* (including the Pulse DSL)
" Filenames:    *.fst *.fsti
" Maintainers:  Michael Lowell Roberts <mirobert at microsoft dot com>
" URL:          https://fstar-lang.org
"
" Originally based on the ocaml.vim syntax file distributed with Vim.
" Keyword lists follow the F* lexer (FStarC.Parser.LexFStar) and the Pulse
" parser (PulseSyntaxExtension.Parser); highlighting categories follow the
" F* VS Code extension's fstar.tmLanguage.json.
"
" Distributed under the VIM LICENSE. Please refer to the LICENSE file or
" visit <http://vimdoc.sourceforge.net/htmldoc/uganda.html> for details.

if exists("b:current_syntax")
  finish
endif

" F* is case sensitive.
syn case match

" Items that may only appear via nextgroup / inside specific regions.
syn cluster  fstarContained contains=fstarTodo,fstarModule,fstarModuleAlias


" ---------------------------------------------------------------------------
" Identifiers
" Consuming identifiers as one item keeps the operator/number patterns below
" from firing in the middle of a word (e.g. the "0" in "var_0").
syn match    fstarLCIdentifier "\<\%(\l\|_\)\%(\w\|'\)*"
" Type variables: 'a, 'b, ...
syn match    fstarLCIdentifier "'\%(\l\|_\)\%(\w\|'\)*"


" ---------------------------------------------------------------------------
" Punctuation and operators
" Single-character items first; multi-character items are defined afterwards
" so that they take priority when both start at the same column.
syn match    fstarKeyChar      "!"
syn match    fstarKeyChar      ";"
syn match    fstarKeyChar      "\~"
syn match    fstarKeyChar      "?"
syn match    fstarKeyChar      "\*"
syn match    fstarKeyChar      "="
" Implicit argument marker: #a, #1.0R
syn match    fstarKeyChar      "#"
" A bare "|" (not the tail of a |] |) |} closer).
syn match    fstarKeyChar      "|\ze\%([^\]})]\|$\)"
syn match    fstarAnyVar       "\<_\>"

syn match    fstarOperator     "\^"
syn match    fstarOperator     "@"
syn match    fstarOperator     "<"
syn match    fstarOperator     ">"
syn match    fstarOperator     ":"
syn match    fstarOperator     "::"
syn match    fstarOperator     "&&"
syn match    fstarOperator     "||"
syn match    fstarOperator     "/\\"
syn match    fstarOperator     "\\/"
syn match    fstarOperator     "=="
syn match    fstarOperator     "=!="
syn match    fstarOperator     "<>"
syn match    fstarOperator     "<:"
syn match    fstarOperator     "<|"
syn match    fstarOperator     "|>"
syn match    fstarOperator     "<-"
syn match    fstarOperator     "==>"
syn match    fstarOperator     "<==>"
" Pulse: separating conjunction and magic wand
syn match    fstarOperator     "\*\*"
syn match    fstarOperator     "@==>"
" Unicode operators accepted by the F* lexer
syn match    fstarOperator     "[∀∃∧∨¬≠≤≥→⟹⟸⇔∘]"
syn match    fstarKeyword      "λ"

syn match    fstarFunDef       "->"
syn match    fstarRefAssign    ":="

" Backtick infix application:  a `Int32.add` b
syn match    fstarInfixOp      "`\%(\u\%(\w\|'\)*\.\)*\%(\l\|_\)\%(\w\|'\)*`"

syn keyword  fstarOperator     not


" ---------------------------------------------------------------------------
" Errors: closing delimiters without a matching opener.  The fstarEncl regions
" below consume properly matched closers, so only stray ones remain visible.
syn match    fstarBraceErr     "|\=}"
syn match    fstarBrackErr     "|\=\]"
syn match    fstarParenErr     "|\=)"
syn match    fstarCommentErr   "\*)"

if exists("g:fstar_noend_error")
  syn match  fstarKeyword      "\<end\>"
else
  syn match  fstarEndErr       "\<end\>"
endif


" ---------------------------------------------------------------------------
" Enclosing delimiters
" These regions nest freely, which is what makes Pulse's C-like
" `if (..) { .. } else { .. }` blocks work: every "}" closes the innermost
" "{" and nothing else may swallow it.
syn region   fstarEncl transparent matchgroup=fstarKeyword start="("   matchgroup=fstarKeyword end=")"   contains=ALLBUT,@fstarContained,fstarParenErr
syn region   fstarEncl transparent matchgroup=fstarKeyword start="(|"  matchgroup=fstarKeyword end="|)"  contains=ALLBUT,@fstarContained,fstarParenErr
syn region   fstarEncl transparent matchgroup=fstarKeyword start="{"   matchgroup=fstarKeyword end="}"   contains=ALLBUT,@fstarContained,fstarBraceErr
syn region   fstarEncl transparent matchgroup=fstarKeyword start="{|"  matchgroup=fstarKeyword end="|}"  contains=ALLBUT,@fstarContained,fstarBraceErr
syn region   fstarEncl transparent matchgroup=fstarKeyword start="\["  matchgroup=fstarKeyword end="\]"  contains=ALLBUT,@fstarContained,fstarBrackErr
syn region   fstarEncl transparent matchgroup=fstarKeyword start="\[|" matchgroup=fstarKeyword end="|\]" contains=ALLBUT,@fstarContained,fstarBrackErr

" begin ... end
syn region   fstarEnd matchgroup=fstarKeyword start="\<begin\>" matchgroup=fstarKeyword end="\<end\>" contains=ALLBUT,@fstarContained,fstarEndErr


" ---------------------------------------------------------------------------
" Keywords

" F* keywords (FStarC.Parser.LexFStar).  Note that "if" and "then" are plain
" keywords: an `if` region ending at `then` would never terminate in Pulse,
" whose conditionals are `if c { .. } else { .. }`.
syn keyword  fstarKeyword  and as assert attributes by calc class decreases
syn keyword  fstarKeyword  effect eliminate else ensures exception exists
syn keyword  fstarKeyword  forall fun function if in inline
syn keyword  fstarKeyword  inline_for_extraction instance introduce irreducible
syn keyword  fstarKeyword  layered_effect let logic match new new_effect noeq
syn keyword  fstarKeyword  noextract of opaque polymonadic_bind
syn keyword  fstarKeyword  polymonadic_subcomp private quote range_of rec
syn keyword  fstarKeyword  reifiable reflectable reify requires returns
syn keyword  fstarKeyword  set_range_of sub_effect synth then total try type
syn keyword  fstarKeyword  unfold unfoldable unopteq val when with

" module M / open M.N / include M / friend M / module A = B.C
syn keyword  fstarKeyword  nextgroup=fstarModule skipwhite module open include friend
syn match    fstarModule       "\u\%(\w\|'\)*\%(\.\u\%(\w\|'\)*\)*" contained skipwhite nextgroup=fstarModuleAlias
syn match    fstarModuleAlias  "=" contained skipwhite nextgroup=fstarModule

" Pulse keywords (PulseSyntaxExtension.Parser), plus the older `parallel` and
" `with_invariants` forms.
syn keyword  fstarPulseKeyword fn mut while invariant predicate divergent each
syn keyword  fstarPulseKeyword rewrite norewrite fold atomic ghost unobservable
syn keyword  fstarPulseKeyword opens show_proof_state preserves
syn keyword  fstarPulseKeyword goto label return continue break defer
syn keyword  fstarPulseKeyword parallel with_invariants

" Escape hatches: the proof is not complete while these are present.
syn keyword  fstarEscapeHatch  admit assume magic unsafe_coerce

syn keyword  fstarBoolean  true false True False

syn keyword  fstarType     unit bool int nat pos string char list option exn
syn keyword  fstarType     array ref erased
syn keyword  fstarType     int8 int16 int32 int64 uint8 uint16 uint32 uint64
syn keyword  fstarType     Type Type0 eqtype prop Tot GTot Lemma
syn keyword  fstarType     slprop


" ---------------------------------------------------------------------------
" Constructors and module paths
syn match    fstarConstructor  "(\s*)"
syn match    fstarConstructor  "\[\s*\]"
syn match    fstarConstructor  "\<\u\%(\w\|'\)*"
syn match    fstarModPath      "\<\u\%(\w\|'\)* *\."he=e-1


" ---------------------------------------------------------------------------
" Literals

" Integers with the F* machine-integer suffixes: 1y 2uy 3s 4us 5l 6ul 7L 8uL 9sz 10z
syn match    fstarNumber       "\<\d\+\%([uU]\=[yslL]\|sz\|z\)\=\>"
syn match    fstarNumber       "\<0[xX]\x\+\%([uU]\=[yslL]\|sz\|z\|LF\)\=\>"
syn match    fstarNumber       "\<0[oO]\o\+\%([uU]\=[yslL]\|sz\|z\)\=\>"
syn match    fstarNumber       "\<0[bB][01]\+\%([uU]\=[yslL]\|sz\|z\)\=\>"
" Floats and reals (1.5, 1e10, 2.0R)
syn match    fstarFloat        "\<\d\+\.\d*\%([eE][-+]\=\d\+\)\=R\=\>"
syn match    fstarFloat        "\<\d\+[eE][-+]\=\d\+\>"

" Characters: 'a', '\n', '\x41', 'λ'
syn match    fstarCharacter    +'[^\\']'+
syn match    fstarCharacter    +'\\\%([\\"'bfntrv0]\|x\x\x\|u\x\x\x\x\)'+

syn region   fstarString       start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell


" ---------------------------------------------------------------------------
" Pragmas and language selectors:  #lang-pulse, #push-options "...", ...
syn match    fstarPragma       "^\s*#\%(lang-\w\+\|set-options\|reset-options\|push-options\|pop-options\|show-options\|restart-solver\|print-effects-graph\|check\|eval\)\>"
" Older embedded-DSL fences: ```pulse ... ```
syn match    fstarPragma       "^\s*```\w*\s*$"
syn match    fstarPragma       "%splice\%(_t\)\=\>"


" ---------------------------------------------------------------------------
" Comments (defined last so that "(*" wins over the "(" region).
syn region   fstarComment      start="(\*" end="\*)" contains=@Spell,fstarComment,fstarTodo
syn match    fstarCommentLine  "//.*$" contains=fstarTodo,@Spell
syn keyword  fstarTodo         contained TODO FIXME XXX NOTE


" ---------------------------------------------------------------------------
" Synchronization
" Brace blocks in Pulse (and long definitions in F*) can span hundreds of
" lines, so "start N lines back with an empty state" is not good enough.
" Instead, like python.vim, look back for a top-level declaration keyword in
" column 0 -- that is a point where no delimiter regions are open -- and
" parse forward from there.
syn sync minlines=50
syn sync match fstarDeclSync grouphere NONE "^\%(let\|and\|val\|type\|module\|open\|include\|friend\|effect\|new_effect\|layered_effect\|sub_effect\|polymonadic_bind\|polymonadic_subcomp\|class\|instance\|exception\|assume\|noeq\|unopteq\|irreducible\|inline_for_extraction\|noextract\|private\|unfold\|fn\|ghost\|atomic\|unobservable\|divergent\)\>"
syn sync match fstarPragmaSync grouphere NONE "^#\%(push-options\|pop-options\|set-options\|reset-options\|show-options\|restart-solver\|lang-\)"
syn sync match fstarCommentSync grouphere fstarComment "^(\*"


" ---------------------------------------------------------------------------
" Default highlighting
hi def link fstarBraceErr      Error
hi def link fstarBrackErr      Error
hi def link fstarParenErr      Error
hi def link fstarCommentErr    Error
hi def link fstarEndErr        Error

hi def link fstarComment       Comment
hi def link fstarCommentLine   Comment
hi def link fstarTodo          Todo

hi def link fstarModPath       Include
hi def link fstarModule        Include
hi def link fstarPragma        PreProc

hi def link fstarConstructor   Constant

hi def link fstarKeyword       Keyword
hi def link fstarPulseKeyword  Keyword
hi def link fstarFunDef        Keyword
hi def link fstarRefAssign     Keyword
hi def link fstarKeyChar       Keyword
hi def link fstarAnyVar        Keyword
hi def link fstarOperator      Keyword
hi def link fstarInfixOp       Keyword
hi def link fstarModuleAlias   Keyword
hi def link fstarEncl          Keyword

hi def link fstarEscapeHatch   Todo

hi def link fstarBoolean       Boolean
hi def link fstarCharacter     Character
hi def link fstarNumber        Number
hi def link fstarFloat         Float
hi def link fstarString        String
hi def link fstarType          Type

let b:current_syntax = "fstar"

" vim: ts=8
