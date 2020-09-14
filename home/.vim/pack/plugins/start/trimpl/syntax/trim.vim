if exists("b:current_syntax")
    finish
endif

let s:trim_cpo_save = &cpo
set cpo&vim

syn keyword trimType                    char int numeric string list datetime trigger
syn match   trimType                    "_.*_\s"
syn match   trimTrigger                 "\#trigger"

" 
syn keyword trimRepeat                  break continue do for return while
syn keyword trimConditional             else if switch
syn keyword trimLabel                   case default
syn match   trimOperatorError           display +::+
"syn match   trimGlobal                  display +global::+

syn match   trimLabel                   display +^\s*\I\i*\s*:\([^:]\)\@=+

syn keyword trimConstant                SYSDATE false FALSE null NULL true TRUE
"BLOCK CONST DEAD FIELD FORM GOBJECT IDENT MENU POST REPORT TITLE TRIGGER
syn match   trimConstant                "TEXT \- .*$"

"syn keyword trimSQL                     FROM WHERE AND SELECT GROUP INTO ORDER JOIN LET IN ON EQUALS BY ASC DESC

syn match   trimContextualStatement     /\<yield[[:space:]\n]\+\(return\|break\)/me=s+5
syn match   trimContextualStatement     /\<where\>[^:]\+:/me=s+5

syn match   trimClass                   contained       /\<[A-Z][a-z]\w\+/ nextgroup=trimGeneric
syn match   trimIface                   contained       /\<I[A-Z][a-z]\w\+/ nextgroup=trimGeneric
syn region  trimEnclosed                start="(" end=")" contains=trimConstant, trimType, trimString, trimVerbatimString, trimCharacter,
                                                                 \ trimNumber,trimIface,trimClass,trimNewDecleration,trimUnspecifiedStatement, trimComment, trimPreCondit

syn region  trimAttribute               start="^\s*\[" end="\]\s*" contains=trimString, trimVerbatimString, trimCharacter, trimNumber, trimType

syn region  trimComment                 start="/\*"  end="\*/" contains=@trimCommentHook,@Spell
syn match   trimComment                 "//.*$" contains=@trimCommentHook,@Spell

syn region  trimPreCondit               start="#\s*\(define\|undef\|if\|elif\|else\|endif\|line\|error\|include\|warning\)"
                                                  \ skip="\\$"
                                                  \ end="$" contains=trimComment keepend
syn region  trimRegion                  matchgroup=trimPreCondit start="^\s*#\s*region.*$"
                                                  \ end="^\s*#\s*endregion" transparent fold contains=TOP

syn match   trimSpecialError            contained "\\."
syn match   trimSpecialCharError        contained "[^']"

syn match   trimSpecialChar             contained +\\["\\'0abfnrtvx]+

syn match   trimUnicodeNumber           +\\\(u\x\{4}\|U\x\{8}\)+        contained contains=trimUnicodeSpecifier
syn match   trimUnicodeSpecifier        +\\[uU]+ contained
syn region  trimVerbatimString          start=+@"+ end=+"+ skip=+""+    contains=trimVerbatimSpec,@Spell
syn match   trimVerbatimSpec            +@"+he=s+1                      contained
syn region  trimString                  start=+"+  end=+"+ end=+$+      contains=trimSpecialChar,trimSpecialError,trimUnicodeNumber,@Spell
syn match   trimCharacter               "'[^']*'"                       contains=trimSpecialChar,trimSpecialCharError
syn match   trimCharacter               "'\\''"                         contains=trimSpecialChar
syn match   trimCharacter               "'[^\\]'"
syn match   trimNumber                  "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>"
syn match   trimNumber                  "\parm\.[0-9]*"

syn match   trimFunction                "\zs\(\k\w*\)*\s*\ze("

"syn match   trimGlobal                  "g\.[\w-_]+"
syn match   trimGlobal                  "[gG]\.[a-zA-Z0-9\-\_]*"

hi def link trimType                    Type
hi def link trimTypeDecleration         StorageClass
hi def link trimInterfaceDecleration    StorageClass
hi def link trimNewDecleration          StorageClass
hi def link trimStorage                 StorageClass
hi def link trimRepeat                  Repeat
hi def link trimConditional             Conditional
hi def link trimLabel                   Label
hi def link trimModifier                StorageClass
hi def link trimConstant                Constant
hi def link trimException               Exception
hi def link trimUnspecifiedStatement    Statement
hi def link trimUnsupportedStatement    Statement
hi def link trimUnspecifiedKeyword      Keyword
hi def link trimSQL                     Keyword
hi def link trimAsync                   Keyword
hi def link trimContextualStatement     Statement
hi def link trimOperatorError           Error
hi def link trimAttribute               PreProc
hi def link trimComment                 Comment

hi def link trimSpecialError            Error
hi def link trimSpecialCharError        Error
hi def link trimString                  String
hi def link trimVerbatimString          String
hi def link trimVerbatimSpec            SpecialChar
hi def link trimPreCondit               PreCondit
hi def link trimCharacter               Character
hi def link trimSpecialChar             SpecialChar
hi def link trimNumber                  Number
hi def link trimUnicodeNumber           SpecialChar
hi def link trimUnicodeSpecifier        SpecialChar
hi def link trimTypeOf                  Keyword
hi def link trimFunction                Function
hi def link trimTrigger                 PreProc

hi def link trimGlobal                  Label

let b:current_syntax = "trim"

let &cpo = s:trim_cpo_save
unlet s:trim_cpo_save

