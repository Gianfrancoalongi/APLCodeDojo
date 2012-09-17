:Namespace Anagrams

∇ Z ← Combinations String;Char;PosOfChar;AllOthers;Res
        Z ← ⍬
        :If (0 = ⍴ ⍴ String)
                Z ← String,⍬
        :ElseIf (1 = ⍴ String)
                Z ← String
        :Else
                :For Char :In String                
                        PosOfChar ← String ⍳ Char                
                        AllOthers ← (PosOfChar ≠ ⍳ ⍴ String) / String
                        Res ← Combinations AllOthers
                        Z ← Z,({ Char,⍵} ¨ Res)
                :EndFor
        :EndIf
∇

:EndNamespace