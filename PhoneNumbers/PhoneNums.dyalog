:NameSpace PhoneNums

⍝ Consistent :: [[Int]] → 1 | 0
⍝ e.g Consistent ((4 3 2 4 5 5) (4 3 2) (9 1 1 1 2)) → 0
⍝     Consistent ((1 2 3 4) (1 2 1 3)) → 1
∇ Z ← Consistent Numbers;Tmp;Sizes;SortIndex;Num_Index;Parts;Hits

        Sizes ← ⊃,/ ⍴ ¨ Numbers

        SortIndex ← ⍋ Sizes

        Numbers ← Numbers[SortIndex]

        Num_Index ← ↓ Numbers,[1.5](⍳ ⍴ Numbers)

        Parts ← { (⍴ ⊃⍵[1])∘↑ ¨  ⍵[2] ↓ Numbers } ¨ Num_Index
        Parts ← ⊃,/Parts

        Hits ← { (⊂⍵) ∊ Parts  } ¨ Numbers

        Z ← ~ ∨/ Hits
∇

:EndNameSpace