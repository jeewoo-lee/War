import Foundation

enum Suit: Int {
    case spade = 1, heart, diamond, clover
}

enum Value: Int {
    case two = 2, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
}

struct Card {
    var value: Value
    var suit: Suit
    
    
}

struct Hand {
    var cards: [Card]
    //drawing cards
    mutating func draw() -> Card? {
        if let drawnCard = cards.first {
            self.cards.remove(at: 0)
            return drawnCard
            
        } else {
            return nil
        }
    }
    
}

struct Deck {
    let totalCards = 52
    var fullDeck: [Card] = []
    init() {
        for suit in 1...4 {
            for value in 2...14 {
                fullDeck.append(Card(value: Value(rawValue: value)!, suit: Suit(rawValue: suit)!))
            }
        }
    }
    
}



struct War {
    var deckOfCards = Deck()
    
    var playerHand = Hand(cards: [])
    var computerHand = Hand(cards: [])
    var countTurns = 1
    var isGameOver = true
    
    //array for bounty at war
    var computerBounty: [Card] = []
    var playerBounty: [Card] = []
    
    
    
    mutating func shuffle(deck: [Card]) -> [Card]{
        var fullDeck = deck
        var x = 0
        while x < 52 {
            // Player's hand
            if fullDeck.count > 0 {
                var chosenCard = Int.random(in: 0...(fullDeck.count - 1))
                playerHand.cards.append(fullDeck[chosenCard])
                fullDeck.remove(at: chosenCard)
                
                //Computer's hand
                chosenCard = Int.random(in: 0...(fullDeck.count - 1))
                computerHand.cards.append(fullDeck[chosenCard])
                fullDeck.remove(at: chosenCard)
            }
            
            x += 1
        }
        return fullDeck
    }
    
    mutating func war(computerCard: Card, playerCard: Card) {
        print("WAR")
        
        if computerHand.cards.count < 4 {
            
            //whoIsWinner(winner: "Player")
            
        } else if playerHand.cards.count < 4 {
          
           // whoIsWinner(winner: "Computer")
            
        } else {
            //add the top card into bounty for three times
            for _ in 1 ... 3 {
                // add the computer's top card to bounty
                computerBounty.append(computerHand.cards[0])
                computerHand.cards.remove(at: 0)
                
                // add the player's top card to bounty
                playerBounty.append(playerHand.cards[0])
                playerHand.cards.remove(at: 0)
            }
            // Draw top cards to compare
            let computerMiddle = computerHand.cards[0]
            let playerMiddle = playerHand.cards[0]
            computerHand.cards.remove(at: 0)
            playerHand.cards.remove(at: 0)
            
            // compare
            if computerMiddle.value.rawValue > playerMiddle.value.rawValue {
                
                computerHand.cards.append(contentsOf: computerBounty)
                computerHand.cards.append(contentsOf: playerBounty)
                computerHand.cards.append(computerMiddle)
                computerHand.cards.append(playerMiddle)
                
                // remove cards from bounties
                computerBounty.removeAll()
                playerBounty.removeAll()
                
                //display winner
                print("Computer won this turn")
            } else if computerMiddle.value.rawValue < playerMiddle.value.rawValue {
                
                playerHand.cards.append(contentsOf: computerBounty)
                playerHand.cards.append(contentsOf: playerBounty)
                playerHand.cards.append(computerMiddle)
                playerHand.cards.append(playerMiddle)
                
                // remove cards from bounties
                computerBounty.removeAll()
                playerBounty.removeAll()
                
                //display winner
                print("Player won this turn")
            } else {
                //when it's tie it repeats the process
                computerBounty.append(computerMiddle)
                playerBounty.append(playerMiddle)
                war(computerCard: computerMiddle, playerCard: playerMiddle)
                
            }

        }
    }
    
    mutating func playTheGame() {
        //see if computer and player have enough card
        if computerHand.cards.count < 4{
            whoIsWinner(winner: "Player")
            
        }
        else if playerHand.cards.count < 4{
            whoIsWinner(winner: "Computer")
            
        }
        else {
            //If they have enough caads, start to compare
            //Place cards into middle
            let computerMiddle = computerHand.cards[0]
            let playerMiddle = playerHand.cards[0]
            
            //display what cards they have
            print("Computer has \(computerMiddle.suit) \(computerMiddle.value)")
            print("Player has \(playerMiddle.suit) \(playerMiddle.value)")
           
            
            if computerMiddle.value.rawValue < playerMiddle.value.rawValue{
                playerHand.cards.append(computerMiddle)
                playerHand.cards.remove(at: 0)
                computerHand.cards.remove(at: 0)
                playerHand.cards.append(playerMiddle)
                
                //display winner
                print("Player won this turn")
                
            }
            else if playerMiddle.value.rawValue > computerMiddle.value.rawValue{
                computerHand.cards.append(playerMiddle)
                computerHand.cards.remove(at: 0)
                playerHand.cards.remove(at: 0)
                computerHand.cards.append(computerMiddle)
                
                //display winner
                print("Computer won this turn")
            }
            else
            {
                war(computerCard: computerMiddle, playerCard: playerMiddle)
            }
             
            print("========================================================")
        }
    }
    
    mutating func whoIsWinner(winner: String) {
        isGameOver = true
        if winner == "Player"
        {
            print("========================================================")
            print("VICTORY")
            
        }
        else
        {
            print("========================================================")
            print("DEFEATED")

        }
    }
    
    mutating func startTheGame() {
        while isGameOver == true {
            shuffle(deck: deckOfCards.fullDeck)
            isGameOver = false
        }
        
        while isGameOver == false {
             
            if countTurns == 1 {
                print("It's 1st turn")
                
            } else if countTurns == 2 {
                print("It's 2nd turn")
                
            } else if countTurns == 3 {
                print("It's 3rd turn")
                
            } else {
                print("It's \(countTurns)th turn")
                
            }

            print("Computer has \(computerHand.cards.count) cards")
            print("Player has \(playerHand.cards.count) cards")
            
            playTheGame()
            countTurns += 1
            
        }
    }
}

let deck = Deck()
let player = Hand(cards: [])
let computer = Hand(cards: [])
let computerBounty = Hand(cards: [])
let playerBounty = Hand(cards: [])
let count: Int = 1
var warGame = War(deckOfCards: deck, playerHand: player, computerHand: computer, countTurns: count, isGameOver: true, computerBounty: computerBounty.cards, playerBounty: playerBounty.cards)


warGame.startTheGame()










