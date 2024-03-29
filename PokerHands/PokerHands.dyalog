:NameSpace Poker

∇ Z ← WhiteHand Versus BlackHand
        Z ← ⊃ 'Tie' 'White wins' 'Black wins' [ (Score WhiteHand) Compare (Score BlackHand) ]
∇


Rank ← { 'High Card'  'Pair'  'Two Pairs'  'Three of a kind'  'Straight'  'Flush'  'Full House'  'Four of a kind'  'Straight Flush' ⍳ ⍵ }

∇ Z ← LeftScore Compare RightScore;LR;RR;Diff
        :If LeftScore ≡ RightScore
                Z ← 1       
        :Else
                LR ← Rank 1∘⌷ LeftScore
                RR ← Rank 1∘⌷ RightScore
                :If LR = RR     
                        Diff ← ⊃ -/ 1∘↓ ¨ LeftScore RightScore
                        :If 2=|≡Diff
                                Diff ← ⊃ Diff
                        :EndIf                                
                        Diff ← (1 ⍳ ⍨ 0 < Diff) (1 ⍳ ⍨ 0 > Diff)
                        Z ← 1 + Diff ⍳ ⌊ / Diff
                :Else
                        Z ← 1 + LR RR ⍳ LR ⌈ RR
                :EndIf
        :EndIf
                
∇
        
∇ Z ← Score Hand;VecHand;G;S
        VecHand ← Card2Vec ¨ Hand
        G ← ValuesGrouped VecHand
        S ← ⍴ G
        :If 5 = S
                :If SameColor VecHand
                        :If Ladder VecHand                                
                                Z ← 'Straight Flush' (⊃ ⊃ 1 ⌷ G)
                        :Else                       
                                Z ← 'Flush' (⊃,/G)
                        :EndIf
                :ElseIf Ladder VecHand
                        Z ← 'Straight' (⊃⊃1∘⌷ G)
                :Else                        
                        Z ← 'High Card' (⊃,/G)
                :EndIf
        :ElseIf 2 = S
            :If (4 ∊ ⊃∘⍴ ¨ G) 
                    Z ← 'Four of a kind' (⊃ ⊃ G[ (4 = ⊃∘⍴ ¨ G) / ⍳ ⍴ G ]) 
            :ElseIf (2 ∊ ⊃∘⍴ ¨ G) ∧ (3 ∊ ⊃∘⍴ ¨ G) 
                    Z ← 'Full House' (⊃ ⊃ G[ (3 = ⊃∘⍴ ¨ G) / ⍳ ⍴ G ])
            :EndIf
        :ElseIf 3 = S
            :If (3 ∊ ⊃∘⍴ ¨ G)
                    Z ← 'Three of a kind' (⊃ ⊃ G[ (3 = ⊃∘⍴ ¨ G) / ⍳ ⍴ G ])
            :ElseIf (2 2 1) ≡ ⊃∘⍴ ¨ G[⍒ ⊃∘⍴ ¨ G]
                    G ← G[⍒ ⊃∘⍴ ¨ G]
                    Z ← 'Two Pairs' ( (⊃ ⊃ 1∘⌷ G) (⊃ ⊃ 2∘⌷ G) (⊃ ⊃ 3∘⌷ G) )
            :EndIf
        :ElseIf 4 = S
            G ← G[⍒ ⊃∘⍴ ¨ G]
            Z ← 'Pair' ( (⊃ ⊃ 1 ↑ G),(⊃,/ 1 ↓ G) )
        :EndIf
∇
        
∇ Z ← SameColor VecHand
        Z ← 1 = ⍴ ∪ 2∘⌷ ¨ VecHand
∇

∇ Z ← Ladder VecHand;Values;SortSubtract;First;Rest
        Values ← SortedValues VecHand
        SortSubtract ← | ¨ Values - (¯1⌽Values)
        First ← SortSubtract[1]
        Rest ← ⊃ ×/ 1 ↓ SortSubtract
        Z ← First = ¯1 + (⍴ SortSubtract) ∧ 1=Rest
∇

∇ Z ← Card2Vec Card;Rank;Suite
        Rank ← 1 + '23456789TJQKA' ⍳ Card[1]
        Suite ← 'CDHS' ⍳ Card[2]
        Z ← (Rank Suite)
∇

∇ Z ← ValuesGrouped VecHand;Values
        Values ← SortedValues VecHand
        ⎕ML ← 3
        Z ← Values ⊂ Values
        ⎕ML ← 0
        Z ← ⌽ Z
∇

∇ Z ← SortedValues VecHand;SortIndices;Sorted
        SortIndices ← ⍋ 1∘⌷ ¨ VecHand
        Sorted ← VecHand[SortIndices]
        Z ← 1∘⌷ ¨ Sorted
∇

∇ Z ← Test
        Z ← ⍬
        Z ,← 1 = SameColor ((1 2) (2 2) (3 2))
        Z ,← 0 = SameColor ((1 2) (2 1) (3 2))
        Z ,← (2 1) ≡ Card2Vec '2C'
        Z ,← (14 2) ≡ Card2Vec 'AD'
        Z ,← (10 3) ≡ Card2Vec 'TH'
        Z ,← 1 = Ladder ((1 2) (2 2) (3 2))
        Z ,← 1 = Ladder ((2 2) (3 2) (1 2))
        Z ,← 0 = Ladder ((1 2) (2 2) (4 2))
        Z ,← 'Straight Flush' 6 ≡ Score '2H' '3H' '4H' '5H' '6H'        
        Z ,← 'Four of a kind' 2 ≡ Score '2H' '2C' '2D' '2S' '3D'
        Z ,← 'Full House' 2 ≡ Score '2H' '2H' '2H' 'AS' 'AS'
        Z ,← 'Flush' (8 6 5 3 2) ≡ Score '3H' '2H' '6H' '8H' '5H'
        Z ,← 'Straight' 8 ≡ Score '4H' '5D' '6S' '7C' '8H'
        Z ,← 'Three of a kind' 3 ≡ Score '2H' '3D' '3C' '3S' '4H'
        Z ,← 'Two Pairs' (3 2 10) ≡ Score '2H' 'TS' '3C' '2D' '3S'
        Z ,← 'Pair' (2 6 5 4) ≡ Score '2H' '6D' '2C' '4C' '5S'
        Z ,← 'High Card' (10 9 8 4 3) ≡ Score '8S' '4C' 'TD' '9S' '3S'
        Z ,← 1 ≡ ('Straight Flush' 6) Compare ('Straight Flush' 6)
        Z ,← 2 ≡ ('Straight Flush' 6) Compare ('Straight Flush' 5)
        Z ,← 3 ≡ ('Straight Flush' 5) Compare ('Straight Flush' 6)
        Z ,← 1 ≡ ('Four of a kind' 2) Compare ('Four of a kind' 2)
        Z ,← 2 ≡ ('Four of a kind' 3) Compare ('Four of a kind' 2)
        Z ,← 3 ≡ ('Four of a kind' 2) Compare ('Four of a kind' 3)
        Z ,← 1 ≡ ('Full House' 2) Compare ('Full House' 2)
        Z ,← 2 ≡ ('Full House' 3) Compare ('Full House' 2)
        Z ,← 3 ≡ ('Full House' 2) Compare ('Full House' 3)
        Z ,← 1 ≡ ('Flush' 8 6 5 3 2) Compare ('Flush' 8 6 5 3 2)
        Z ,← 2 ≡ ('Flush' 9 6 5 3 2) Compare ('Flush' 8 6 5 3 2)
        Z ,← 3 ≡ ('Flush' 8 6 5 3 2) Compare ('Flush' 9 6 5 3 2)
        Z ,← 1 ≡ ('Straight' 8) Compare ('Straight' 8)
        Z ,← 2 ≡ ('Straight' 9) Compare ('Straight' 8)
        Z ,← 3 ≡ ('Straight' 8) Compare ('Straight' 9)
        Z ,← 1 ≡ ('Three of a kind' 3) Compare ('Three of a kind' 3)
        Z ,← 2 ≡ ('Three of a kind' 3) Compare ('Three of a kind' 2)
        Z ,← 3 ≡ ('Three of a kind' 2) Compare ('Three of a kind' 3)
        Z ,← 1 ≡ ('Two Pairs' 3 2 10) Compare ('Two Pairs' 3 2 10)
        Z ,← 2 ≡ ('Two Pairs' 4 2 10) Compare ('Two Pairs' 3 2 10)
        Z ,← 2 ≡ ('Two Pairs' 3 3 10) Compare ('Two Pairs' 3 2 10)
        Z ,← 2 ≡ ('Two Pairs' 3 2 11) Compare ('Two Pairs' 3 2 10)
        Z ,← 3 ≡ ('Two Pairs' 3 2 10) Compare ('Two Pairs' 4 2 10)
        Z ,← 3 ≡ ('Two Pairs' 3 2 10) Compare ('Two Pairs' 3 3 10)
        Z ,← 3 ≡ ('Two Pairs' 3 2 10) Compare ('Two Pairs' 3 2 11)
        Z ,← 1 ≡ ('Pair' 2 6 5 4) Compare ('Pair' 2 6 5 4)
        Z ,← 2 ≡ ('Pair' 3 6 5 4) Compare ('Pair' 2 6 5 4)
        Z ,← 2 ≡ ('Pair' 2 7 5 4) Compare ('Pair' 2 6 5 4)
        Z ,← 2 ≡ ('Pair' 2 6 6 4) Compare ('Pair' 2 6 5 4)
        Z ,← 2 ≡ ('Pair' 2 6 5 5) Compare ('Pair' 2 6 5 4)
        Z ,← 3 ≡ ('Pair' 2 6 5 4) Compare ('Pair' 3 6 5 4)
        Z ,← 3 ≡ ('Pair' 2 6 5 4) Compare ('Pair' 2 7 5 4)
        Z ,← 3 ≡ ('Pair' 2 6 5 4) Compare ('Pair' 2 6 6 4)
        Z ,← 3 ≡ ('Pair' 2 6 5 4) Compare ('Pair' 2 6 5 5)
        Z ,← 1 ≡ ('High Card' 10 9 8 4 3) Compare ('High Card' 10 9 8 4 3)
        Z ,← 2 ≡ ('High Card' 11 9 8 4 3) Compare ('High Card' 10 9 8 4 3)
        Z ,← 2 ≡ ('High Card' 10 10 8 4 3) Compare ('High Card' 10 9 8 4 3)
        Z ,← 2 ≡ ('High Card' 10 9 9 4 3) Compare ('High Card' 10 9 8 4 3)
        Z ,← 2 ≡ ('High Card' 10 9 8 5 3) Compare ('High Card' 10 9 8 4 3)
        Z ,← 2 ≡ ('High Card' 10 9 8 4 4) Compare ('High Card' 10 9 8 4 3)
        Z ,← 3 ≡ ('High Card' 10 9 8 4 3) Compare ('High Card' 11 9 8 4 3)
        Z ,← 3 ≡ ('High Card' 10 9 8 4 3) Compare ('High Card' 10 10 8 4 3)
        Z ,← 3 ≡ ('High Card' 10 9 8 4 3) Compare ('High Card' 10 9 9 4 3)
        Z ,← 3 ≡ ('High Card' 10 9 8 4 3) Compare ('High Card' 10 9 8 5 3)
        Z ,← 3 ≡ ('High Card' 10 9 8 4 3) Compare ('High Card' 10 9 8 4 4)
        Z ,← 2 ≡ ('Straight Flush' 6) Compare ('Four of a kind' 7)
        Z ,← 2 ≡ ('Straight Flush' 6) Compare ('Full House' 7)
        Z ,← 2 ≡ ('Straight Flush' 6) Compare ('Flush' (14 13 12 11 10))
        Z ,← 2 ≡ ('Straight Flush' 6) Compare ('Straight' 7)
        Z ,← 2 ≡ ('Straight Flush' 6) Compare ('Three of a kind' 7)
        Z ,← 2 ≡ ('Straight Flush' 6) Compare ('Two Pairs' 8 7 6)
        Z ,← 2 ≡ ('Straight Flush' 6) Compare ('Pair' 7 (5 4 3))
        Z ,← 2 ≡ ('Straight Flush' 6) Compare ('High Card' (7 5 4 3 2))
        Z ,← 3 ≡ ('Four of a kind' 7) Compare ('Straight Flush' 6)
        Z ,← 3 ≡ ('Full House' 7) Compare ('Straight Flush' 6) 
        Z ,← 3 ≡ ('Flush' 14 13 12 11 10) Compare ('Straight Flush' 6) 
        Z ,← 3 ≡ ('Straight' 7) Compare ('Straight Flush' 6) 
        Z ,← 3 ≡ ('Three of a kind' 7) Compare ('Straight Flush' 6) 
        Z ,← 3 ≡ ('Two Pairs' 8 7 6) Compare ('Straight Flush' 6) 
        Z ,← 3 ≡ ('Pair' 7 5 4 3) Compare ('Straight Flush' 6) 
        Z ,← 3 ≡ ('High Card' 7 5 4 3 2) Compare ('Straight Flush' 6)
        Z ,← 2 ≡ ('Four of a kind' 6) Compare ('Full House' 7)
        Z ,← 2 ≡ ('Four of a kind' 6) Compare ('Flush' 14 13 12 11 10)
        Z ,← 2 ≡ ('Four of a kind' 6) Compare ('Straight' 7)
        Z ,← 2 ≡ ('Four of a kind' 6) Compare ('Three of a kind' 7)
        Z ,← 2 ≡ ('Four of a kind' 6) Compare ('Two Pairs' 8 7 6)
        Z ,← 2 ≡ ('Four of a kind' 6) Compare ('Pair' 7 5 4 3)
        Z ,← 2 ≡ ('Four of a kind' 6) Compare ('High Card' 7 5 4 3 2)
        Z ,← 3 ≡ ('Full House' 7) Compare ('Four of a kind' 6)
        Z ,← 3 ≡ ('Flush' (14 13 12 11 10)) Compare ('Four of a kind' 6)
        Z ,← 3 ≡ ('Straight' 7) Compare ('Four of a kind' 6)
        Z ,← 3 ≡ ('Three of a kind' 7) Compare ('Four of a kind' 6)
        Z ,← 3 ≡ ('Two Pairs' 8 7 6) Compare ('Four of a kind' 6)
        Z ,← 3 ≡ ('Pair' 7 5 4 3) Compare ('Four of a kind' 6)
        Z ,← 3 ≡ ('High Card' 7 5 4 3 2) Compare ('Four of a kind' 6)
        Z ,← 2 ≡ ('Full House' 7) Compare ('Flush' 14 13 12 11 10)
        Z ,← 2 ≡ ('Full House' 7) Compare ('Straight' 7)
        Z ,← 2 ≡ ('Full House' 7) Compare ('Three of a kind' 7)
        Z ,← 2 ≡ ('Full House' 7) Compare ('Two Pairs' 8 7 6)
        Z ,← 2 ≡ ('Full House' 7) Compare ('Pair' 7 5 4 3)
        Z ,← 2 ≡ ('Full House' 7) Compare ('High Card' 7 5 4 3 2)
        Z ,← 3 ≡ ('Flush' 14 13 12 11 10) Compare ('Full House' 7)
        Z ,← 3 ≡ ('Straight' 7) Compare ('Full House' 7)
        Z ,← 3 ≡ ('Three of a kind' 7) Compare ('Full House' 7)
        Z ,← 3 ≡ ('Two Pairs' 8 7 6) Compare ('Full House' 7)
        Z ,← 3 ≡ ('Pair' 7 5 4 3) Compare ('Full House' 7)
        Z ,← 3 ≡ ('High Card' 7 5 4 3 2) Compare ('Full House' 7)
        Z ,← 'White wins' ≡ ('2C' '3H' '4S' '8C' 'AH') Versus ('2H' '3D' '5S' '9C' 'KD')
        Z ,← 'Black wins' ≡ ('2S' '8S' 'AS' 'QS' '3S') Versus ('2H' '4S' '4C' '2D' '4H')
        Z ,← 'Black wins' ≡ ('2C' '3H' '4S' '8C' 'KH') Versus ('2H' '3D' '5S' '9C' 'KD')
        Z ,← 'Tie' ≡ ('2D' '3H' '5C' '9S' 'KH') Versus ('2H' '3D' '5S' '9C' 'KD')
 ∇
:EndNameSpace
