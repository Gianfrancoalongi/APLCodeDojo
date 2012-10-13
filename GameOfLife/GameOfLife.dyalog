:NameSpace GOL

∇ Z ← Neighbors Input;Tmp;Moves
        Tmp ← ¯1 ⊖ ¯1 ⌽ (2 + ⍴ Input) ↑ Input
        Moves ← , ¯2 + ⍳ 3 3
        Moves ← ( (⊂(0 0)) ≢¨ Moves ) / Moves
        Tmp ← ⊃ +/ { ⍵[1] ⌽  ⍵[2] ⊖ Tmp } ¨ Moves
        Z ← Tmp[1 + ⍳ ⍴ Input]
∇

∇ Z ← NextGen Matrix;NghBrs;UnderPopulation;OverCrowding;Life
        NghBrs ← Neighbors Matrix
        UnderPopulation ← 2 ∘.> NghBrs
        OverCrowding ← 3 ∘.< NghBrs
        Life ← 3 ∘.= NghBrs
        Z ← Life ∨ Matrix ∧ ~ UnderPopulation ∨ OverCrowding
∇

:EndNameSpace