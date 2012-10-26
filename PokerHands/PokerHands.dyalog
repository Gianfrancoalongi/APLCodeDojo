:NameSpace Poker
        
∇ Z ← Black RankHands White;SB;SW
        Z ← (Score Black) Won (Score White)
∇
        
∇ Z ← Score Hand;VecHand;SortIndices;Suites;Sorted;SortedValues
        VecHand ← Card2Vec ¨ Hand
        ⍝ Check for Straight Flush
        :If Ladder VecHand ∧ SameColor VecHand
                Z ← 'Straight Flush'
        :ElseIf 4 SameValue VecHand 
                Z ← 'Four of a kind'
        :Else
                Z ← 0
        :EndIf
∇
        
∇ Z ← SameColor VecHand
        Z ← 1 = ⍴ ∪ 1∘↓ ¨ VecHand
∇

∇ Z ← Ladder VecHand;SortIndices;Sorted;Values;SortSubtract;First;Rest
        SortIndices ← ⍋ 1∘⌷ ¨ VecHand
        Sorted ← VecHand[SortIndices]
        Values ← 1∘⌷ ¨ Sorted
        SortSubtract ← | ¨ Values - (¯1⌽Values)
        First ← SortSubtract[1]
        Rest ← ∪ 1 ↓ SortSubtract
        Z ← First = ¯1 + (⍴ SortSubtract) ∧ 1=Rest
∇

∇ Z ← Card2Vec Card;Suite;Rank
        Rank ← 1 + '23456789TJQKA' ⍳ Card[1]
        Suite ← 'CDHS' ⍳ Card[2]
        Z ← (Rank Suite)
∇

∇ Z ← Amount SameValue VecHand;SortIndices;Sorted;Values;Groups
        SortIndices ← ⍋ 1∘⌷ ¨ VecHand
        Sorted ← VecHand[SortIndices]
        Values ← 1∘⌷ ¨ Sorted
        ⎕ML ← 3
        Groups ← Values ⊂ Values
        ⎕ML ← 0        
        Z ← ⊃ ∨ / Amount∘=∘⍴ ¨ Groups         
∇

∇ Z ← ScoreBlack Won ScoreWhite
        :If ScoreBlack = ScoreWhite
                Z ← 'Tie'
        :Else
                Z ← ('Black' 'White')[ (ScoreBlack 1) ⌈ (ScoreWhite 2)  ]
                Z ←, 'Wins'
        :EndIf
∇


∇ Z ← Test
        Z ← ⍬
        Z ← 1 = SameColor ((1 2) (2 2) (3 2))
        Z ← Z, 0 = SameColor ((1 2) (2 1) (3 2))
        Z ← Z, (2 1) ≡ Card2Vec '2C'
        Z ← Z, (14 2) ≡ Card2Vec 'AD'
        Z ← Z, (10 3) ≡ Card2Vec 'TH'
        Z ← Z, 1 = Ladder ((1 2) (2 2) (3 2))
        Z ← Z, 1 = Ladder ((1 3) (2 2) (3 1))
        Z ← Z, 1 = Ladder ((2 2) (3 2) (1 2))
        Z ← Z, 1 = Ladder ((3 2) (2 2) (1 2))
        Z ← Z, 0 = Ladder ((1 2) (2 2) (4 2))
        Z ← Z, 0 = Ladder ((1 1) (2 2) (4 3))
        Z ← Z, 'Straight Flush' ≡ Score '2H' '3H' '4H' '5H' '6H'
        Z ← Z, 1 = 3 SameValue ((1 2) (1 3) (1 4) (2 3))
        Z ← Z, 0 = 3 SameValue ((1 2) (2 3) (1 4) (2 3))
        Z ← Z, 0 = 3 SameValue ((1 2) (1 3) (1 4) (1 3))
        Z ← Z, 'Four of a kind' ≡ Score '2H' '2C' '2D' '2S' '3D'
∇
:EndNameSpace