:NameSpace CalcS

∇ Z ← CalcStats InputVector;Len
        Len ← ⍴ InputVector
        Z ← (⌊/InputVector) (⌈/InputVector) Len ((+/InputVector)÷Len)
∇

:EndNameSpace