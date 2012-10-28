:NameSpace Poker
        
∇ Z ← Score Hand;VecHand;P
        VecHand ← Card2Vec ¨ Hand
        P ← AllPairs VecHand
        :If Ladder VecHand ∧ SameColor VecHand
                Z ← 'Straight Flush'
        :ElseIf 4 SameValue VecHand 
                Z ← 'Four of a kind'
        :ElseIf 2 SameValue VecHand ∧ 3 SameValue VecHand
                Z ← 'Full House'
        :ElseIf SameColor VecHand
                Z ← 'Straight'
        :ElseIf 3 SameValue VecHand
                Z ← 'Three of a kind'
        :ElseIf 2 Pairs VecHand
                Z ← 'Two pairs'
        :ElseIf 1 ≡ ⍴ 1 ⌷ P
                Z ← 'Pair' (1 ⌷ P) (1 ↓ P) 
        :Else
                Z ← 'High' (⌽ SortedValues VecHand)
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
                Pairs ← ⊃ Groups[PairBitVector/⍳⍴Groups]
        :EndIf
        Others ← ⊃ ,/ Groups[OtherBitVector / ⍳ ⍴ Groups]
        Z ← Pairs (⌽Others)
∇
        

∇ Z ← ValuesGrouped VecHand
        Values ← SortedValues VecHand
        ⎕ML ← 3
        Z ← Values ⊂ Values
        ⎕ML ← 0
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
        Z ,← 1 = 3 SameValue ((1 2) (1 3) (1 4) (2 3))
        Z ,← 0 = 3 SameValue ((1 2) (2 3) (1 4) (2 3))
        Z ,← 0 = 3 SameValue ((1 2) (1 3) (1 4) (1 3))
        Z ,← 1 = 2 Pairs ((1 2) (1 3) (2 2) (2 3))
        Z ,← 0 = 2 Pairs ((1 2) (1 3) (1 4) (2 2))
        Z ,← (⍬ (3 2 1)) ≡ AllPairs ((1 3) (2 2) (3 3))
        Z ,← 'High' (13 11 10 4 2) ≡ Score '2H' 'KC' 'TS' 'JD' '4C'
        Z ,← 'Pair' 2 (13 10 3) ≡ Score '2H' '2H' '3D' 'TC' 'KS'
        Z ,← 'Two pairs' ≡ Score '2H' '2C' '3D' '3S' 'TC'
        Z ,← 'Straight Flush' ≡ Score '2H' '3H' '4H' '5H' '6H'
        Z ,← 'Four of a kind' ≡ Score '2H' '2C' '2D' '2S' '3D'
        Z ,← 'Full House' ≡ Score '2H' '2H' '2H' 'AS' 'AS'
        Z ,← 'Straight' ≡ Score '2H' '3H' '5H' '8H' '2H'
        Z ,← 'Three of a kind' ≡ Score '2H' '2C' '2D' '3S' '1D'
∇
:EndNameSpace
