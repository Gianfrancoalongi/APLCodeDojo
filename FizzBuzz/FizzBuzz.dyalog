:NameSpace FB

∇ Z ← FizzBuzz Num;R
        R ← 0 = ¨ 3 5  ∘.| Num
        R ← R / ⍳ 2
        :If ⍬ ≡ R
                Z ← Num
        :Else
                Z ← ⊃ ,/ 'Fizz' 'Buzz' [ R ]
        :EndIf
∇

∇ Z ← Test 
        Z ← FizzBuzz ¨ ⍳ 20
∇

:EndNameSpace