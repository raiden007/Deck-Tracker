//
//  TagsGraphsCollectionView.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 27/10/15.
//  Copyright © 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TagsGraphsCollectionCell"

class TagsGraphsCollectionView: UICollectionViewController {
    
    var dateIndex = -1
    var deckName = ""
    var indexOfSelectedGraph = -1
    let data = ["All", "Warrior", "Paladin", "Shaman", "Hunter", "Druid", "Rogue", "Mage", "Warlock", "Priest"]
    var filteredGames:[Game] = []
    var filteredTags:[String] = []
    var gamesBreakedDownByTags:[[Game]] = []
    var winRateArray:[Int] = []
    var gamesWonArray:[Int] = []
    var gamesLostArray:[Int] = []
    var filteredGamesAndTags:[Game] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        getDateIndex()
        getDeckName()
        getGraphsClicked()
        getTagName()
        setupGamesFilteredByTag()
        self.collectionView!.reloadData()
    }
    
    func getDateIndex() {
        dateIndex = NSUserDefaults.standardUserDefaults().integerForKey("Date Index")
        //print("Date Index is: " + String(dateIndex))
    }
    
    func getDeckName() {
        if let _ =  NSUserDefaults.standardUserDefaults().stringForKey("Deck Name") as String! {
            deckName = NSUserDefaults.standardUserDefaults().stringForKey("Deck Name") as String!
        } else {
            deckName = ""
        }
        //print("Deck Name is: " + deckName)
    }
    
    func getGraphsClicked() {
        if let _ = NSUserDefaults.standardUserDefaults().integerForKey("Index Of Selected Graph") as Int! {
            indexOfSelectedGraph = NSUserDefaults.standardUserDefaults().integerForKey("Index Of Selected Graph")
        }
        
        let opponentSelected = data[indexOfSelectedGraph]
        
        filteredGames = Data.sharedInstance.getStatisticsGamesTotal(dateIndex, deck: deckName, opponent: opponentSelected)
    }
    
    func getTagName() {

        var allTags:[String] = []
        
        for game in filteredGames {
            allTags.append(game.getTag())
        }
        
        
        filteredTags = Array(Set(allTags))
        filteredTags.sortInPlace()
        
        print(filteredTags)
        
        var indexOfEmptyTag = -1
        
        for var i = 0; i < filteredTags.count; i++ {
            if filteredTags[i] == "" {
                indexOfEmptyTag = i
            }
        }
        
        if indexOfEmptyTag != -1 {
            filteredTags[indexOfEmptyTag] = "Not selected"
        }
        
        print(filteredTags)
        
    }
    
    func setupGamesFilteredByTag() {
        
        winRateArray = []
        gamesWonArray = []
        gamesLostArray = []
        
        for var i = 0; i < filteredTags.count; i++ {
        // Create an array with only the relevant games
            filteredGamesAndTags = []
            
            for game in filteredGames {
                if filteredTags[i] == game.getTag() {
                    filteredGamesAndTags.append(game)
                }
            }
            
            getStatistics()
            
        }
        // Add Stats for when you have no tags
        filteredGamesAndTags = []
        for game in filteredGames {
            if game.getTag() == "" {
                filteredGamesAndTags.append(game)
            }
        }
        
        getStatistics()
        
    }
    
    func getStatistics () {
        var gamesWon = 0
        for game in filteredGamesAndTags {
            if game.win == true {
                gamesWon++
            }
        }
        
        let totalGames = filteredGamesAndTags.count
        var winRate = 0.0
        if totalGames != 0 {
            winRate =  Double(gamesWon) / Double(totalGames) * 100
        }
        let winRateInt = Int(winRate)
        
        winRateArray.append(winRateInt)
        gamesWonArray.append(gamesWon)
        let gamesLost = filteredGamesAndTags.count - gamesWon
        gamesLostArray.append(gamesLost)
        
        //print(winRateArray)
        //print(gamesWonArray)
        //print(gamesLostArray)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if filteredTags.count == 0 {
            return 1
        } else {
            return filteredTags.count
        }
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! TagsGraphsCollectionCell
        if filteredTags.count == 0 {
            cell.tagLabel.hidden = true
            cell.label.text = "No data"
            cell.winInfoLabel.hidden = true
        } else {
            cell.tagLabel.text = "Tag: " + String(filteredTags[indexPath.row])
            cell.label.text = String(winRateArray[indexPath.row]) + " %"
            cell.winInfoLabel.text = String(gamesWonArray[indexPath.row]) + " - " + String(gamesLostArray[indexPath.row])
        }
        cell.backgroundColor = UIColor.grayColor()
        
    
        // Configure the cell
    
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = collectionView.bounds.size.width
        var cellWidth = (width / 2) - 5
        //print(cellWidth)
        
        if cellWidth > 300 {
            cellWidth = 200
        }
        
        return CGSizeMake(cellWidth, cellWidth)
        
    }
}
