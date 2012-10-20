:NameSpace MINE

∇ Z ← HintField Matrix;NeighBors;MinesIndices
        NeighBors ← MinesCloseBy Matrix 
        NeighBors[ ⎕ ← (,Matrix) / (,⍳⍴Matrix) ] ← '*'
        Z ← NeighBors
∇

∇ Z ← MinesCloseBy Matrix;Tmp;Movements
        Tmp ← ¯1 ⌽ ¯1 ⊖ (2 + ⍴ Matrix) ↑ Matrix 
        Movements ← (, ¯2 + ⍳ 3 3) /⍨ (4⍴1),0,4⍴1
        Tmp ← ⊃ +/ { ⍵[1] ⌽ ⍵[2] ⊖ Tmp } ¨ Movements
        Z ← Tmp[1 + ⍳ ⍴ Matrix]
∇

:EndNameSpace