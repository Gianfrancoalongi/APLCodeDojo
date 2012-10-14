:NameSpace LCD

∇ Z ← Int2LCD Int
        Z ← ⊃ ,/↑ ¨ Num2LCD ¨ ⍕ Int
∇ 

∇ Z ← Num2LCD Num;Storage;Index
        Index ← '0123456789' ⍳ Num
        Storage ← ( '._.' '|.|' '|_|' ) ( '...' '..|' '..|' ) ( '._.' '._|' '|_.' ) ( '._.' '._|' '._|' ) ( '...' '|_|' '..|' ) ( '._.' '|_.' '._|' ) ( '._.' '|_.' '|_|' ) ( '._.' '..|' '..|' ) ( '._.' '|_|' '|_|' ) ( '._.' '|_|' '..|' )
        Z ← Index ⊃ Storage        
∇ 

:EndNameSpace