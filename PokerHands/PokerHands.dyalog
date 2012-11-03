:NameSpace Poker
        
∇ Z ← Score Hand;VecHand;P
        VecHand ← Card2Vec ¨ Hand
        G ← ValuesGrouped VecHand
        S ← ⍴ G
        :If 5 = S
            :If Ladder VecHand ∧ SameColor VecHand
                    Z ← 'Straight Flush' (⊃ ⊃ 1 ⌷ G)
            :ElseIf SameColor VecHand
                    Z ← 'Flush' (⊃,/G)
            :ElseIf Ladder VecHand
                    Z ← 'Straight' (⊃⊃1∘⌷ G)
            :EndIf
        :ElseIf 2 = S
            :If (4 ∊ ⊃∘⍴ ¨ G) 
                    Z ← 'Four of a kind' (⊃ ⊃ G[ (4 = ⊃∘⍴ ¨ G) / ⍳ ⍴ G ]) 
            :ElseIf (2 ∊ ⊃∘⍴ ¨ G) ∧ (3 ∊ ⊃∘⍴ ¨ G) 
                    Z ← 'Full House' (⊃ ⊃ G[ (3 = ⊃∘⍴ ¨ G) / ⍳ ⍴ G ])
            :EndIf
        :Else
            Z ← 0
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

∇ Z ← Amount SameValue VecHand;Groups
        Groups ← ValuesGrouped VecHand
        Z ← ⊃ ∨ / Amount∘=∘⍴ ¨ Groups         
∇

∇ Z ← Amount Pairs VecHand;Groups
        Groups ← ValuesGrouped VecHand
        Z ← Amount = ⊃ +/ 2∘=∘⍴ ¨ Groups
∇

∇ Z ← AllPairs VecHand;Groups;PairBitVector;OtherBitVector;Pairs
        Groups ← ValuesGrouped VecHand
        PairBitVector ← ⊃ ,/ 2∘=∘⍴ ¨ Groups        
        OtherBitVector ← ~ PairBitVector
        :If 0 = + / PairBitVector 
                Pairs ← ⍬
        :Else
                Pairs ← Groups[PairBitVector/⍳⍴Groups]
        :EndIf
        Others ← ⊃ ,/ Groups[OtherBitVector / ⍳ ⍴ Groups]
        Z ← (⌽Pairs) (⌽Others)
∇
        

∇ Z ← ValuesGrouped VecHand
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
        Z ,← 1 = Ladder ((1 3) (2 2) (3 1))
        Z ,← 1 = Ladder ((2 2) (3 2) (1 2))
        Z ,← 1 = Ladder ((3 2) (2 2) (1 2))
        Z ,← 0 = Ladder ((1 2) (2 2) (4 2))
        Z ,← 0 = Ladder ((1 1) (2 2) (4 3))
        Z ,← 0 = Ladder ((2 3) (3 3) (5 3) (8 3) (10 3))
        Z ,← 'Straight Flush' 6 ≡ Score '2H' '3H' '4H' '5H' '6H'        
        Z ,← 'Four of a kind' 2 ≡ Score '2H' '2C' '2D' '2S' '3D'
        Z ,← 'Full House' 2 ≡ Score '2H' '2H' '2H' 'AS' 'AS'
        Z ,← 'Flush' (8 6 5 3 2) ≡ Score '3H' '2H' '6H' '8H' '5H'
        Z ,← 'Straight' 8 ≡ Score '4H' '5D' '6S' '7C' '8H'
        ⍝ Z ,← 'Straight' ≡ Score '2H' '3H' '5H' '8H' '2H'
        ⍝ Z ,← 'High' (13 11 10 4 2) ≡ Score '2H' 'KC' 'TS' 'JD' '4C'
        ⍝ Z ,← 'Pair' 2 (13 10 3) ≡ Score '2H' '2H' '3D' 'TC' 'KS'
        ⍝ Z ,← 'Pair' 14 (4 3 2) ≡ Score 'AH' '2H' '3D' '4C' 'AS'
        ⍝ Z ,← 'Two pairs' ((3 3) (2 2)) 10 ≡ Score '2H' '2C' '3D' '3S' 'TC'
        ⍝ Z ,← 'Three of a kind' 2 ≡ Score '2H' '2C' '2D' '3S' '1D'
∇
:EndNameSpace
