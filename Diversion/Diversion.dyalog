:NameSpace Div

∇ Z ← Dec2Bin Dec
        Z ← 2 2 2 2 2 2 2 2 2 2 2 2 ⊤ Dec
∇

∇ Z ← AdjacentOnes Input
        Input ← 0,Input
        Z ← +⌿ ↑ Input (1 ⌽ Input)
        Z ← Z ⍳ 2
        Z ← Z < ⍴ Input
∇

∇ Z ← Sequences Digits
        Z  ← + / ~ AdjacentOnes ∘ Dec2Bin ¨ 0,⍳ (¯1 + 2*Digits)
∇

:EndNameSpace

⍝  #.Div.Sequences ¨ ⍳ 10                                                                                                                                                                                                      
⍝  2    3    5    8    13    21    34    55    89    144  
⍝ Fibonacci Sequence