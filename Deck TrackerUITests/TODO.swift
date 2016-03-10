//
//  TODO.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 03/03/16.
//  Copyright © 2016 Andrei Joghiu. All rights reserved.
//

import XCTest

class TODO: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    //TODO:
    
    // Decklist: check the correct image appears for each deck
    
    // Games lists elements (date, deck vs opponent image, WIN/LOSS etc)
    // Tags screen elements
    // When no data appears it looks different than with data
    // Add new game screens :
    // Date + back button
    // Choose deck + back button
    // Opponent Class + back button
    // Tags + back button
    // Edit game screen + back button
    // Edit game date + back button
    // deck + back button
    // class + back button
    // tags + back button
    
    // FLOWS:
    
//    1,
//    add a deck with all classes
//    validate this in new game screen
    
    
    //TODO: Reset test all elements
    //TODO: Reset everything flow
    //TODO: Reset all games flow
    //TODO: Reset all games and decks flow
    //TODO: Reset press cancel and check nothing was deleted
//
//    2.
    // add a game normally whatever settings and check on graphs
    // add a game 1 year ago + add a game 2 months ago and validate
    // add a game with current deck + add a game with a different deck than normal and validate both
    // add a game with coin win and another with coin loss and validate
    // add a game where you win and another when you lose (same opponent) + win other opponent + loss another opp and validate (50% win rate overall, 50% opponent, 100% opponent, 0% opponent, no data in rest)
    // add a game without tag and validate + validate in tags screen
    // add a game with tag and validate + tags
    // add: tag 1 - 0% win, tag 2 - 50% win, tag 3 - 100% win and validate + tags
    // add 30 games with tags and validate + all tags + each hero tag
    // add game, delete it and validate it was deleted
    
    // delete deck from new game screen
    // from edit screen
    
    // delete tag from mew game
    // delete from edit game
    
    // add game + validate. edit date for a game and validate
    // add game + validate. edit deck and validate
    // add game + validate. edit opp class and validate
    // add game + validate. edit coin and validate
    // add game + validate. edit win and validate
    // add game + validate. edit tag and validate
    
    // add game: tags screen: flow where you add a tag with the same name of an existing tag (done for decks with the same name)
    // same for edit game tags screen
    
    // When deleting a deck - choose cancel for alert - check that the recorded games are still there
    // same but choose YES - check the recorded games are deleted
    
    // Test iCloud sync somehow
    
}
