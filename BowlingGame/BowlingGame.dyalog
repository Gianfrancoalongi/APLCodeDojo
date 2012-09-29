:Namespace Bowling

∇ Z ← Calculate (Basic Bonus);ExtraBallBonus;Tmp;Indices
        ExtraBallBonus ← BonusPerFrame ¨ Basic
        Tmp ← ⍉ ↑ ↑ (,/Basic,Bonus) (,/ExtraBallBonus,((⍴Bonus)⍴0))
        Indices ← ⍳ 1 ⊃ ⍴ Tmp        
        Tmp ← +/ { Tmp[⍵;1] + +/ (Tmp[⍵;2] ↑ ⍵ ↓ Tmp)[;1] } ¨ Indices
        Z ← Tmp - +/⊃Bonus
∇

∇ Z ← Parse Str;Bonus;FirstTenFrames;Frames
        ⎕ML ← 3
        Frames ← ('|' ≠ Str) ⊂ Str
        ⎕ML ← 0
        FirstTenFrames ← 10 ↑ Frames
        Bonus  ← 10 ↓ Frames
        FT ← PinsPerBall ¨ FirstTenFrames
        :If 0 = ⍴ Bonus
                Z ← FT ⍬
        :Else
                Bonus ← C2I ¨ Bonus
                Z ← FT Bonus
        :EndIf
∇

∇ Z ← PinsPerBall Frame;First;Second
        :If 'X' = 1 ⊃ Frame
                Z ← 10
        :Else
                First ← C2I 1 ⊃ Frame
                Second ← 2 ⊃ Frame
                :If '/' = Second  
                        Z ← First,(10 - First)               
                :ElseIf '-' = Second
                        Z ← First,0
                :EndIf
        :EndIf
∇

∇ Z ← BonusPerFrame Frame
        :If 0 = (≡ Frame)
                Z ← 2
        :Else
                :If 0 = 2 ⊃ Frame   
                        Z ← 0 0
                :Else
                        Z ← 0 1
                :EndIf
        :EndIf
∇

∇ Z ← C2I Chr
        Z ← ¯1 + '0123456789X' ⍳ Chr
∇

⍝ )clear
⍝ ⎕←⎕SE.SALT.Load '/home/gianfranco/APL/CodeDojo/BowlingGame/*.dyalog'
⍝ #.Bowling.Test
∇ Z ← Test
        Z ← Calculate Parse '9-|9-|9-|9-|9-|9-|9-|9-|9-|9-||'
        Z ← Z,Calculate Parse 'X|X|X|X|X|X|X|X|X|X||XX'
        Z ← Z,Calculate Parse '5/|5/|5/|5/|5/|5/|5/|5/|5/|5/||5'
∇

:EndNamespace