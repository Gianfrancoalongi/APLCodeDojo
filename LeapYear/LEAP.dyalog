:NameSpace LEAP

∇ Z ← IsLeapYear Input;Res
        Res ← 4 100 400 ∘.| Input 
        Z ← (0=Res[1]) ∧ ( (0=Res[3]) ∨ (~0=Res[2]) )
∇

:EndNameSpace