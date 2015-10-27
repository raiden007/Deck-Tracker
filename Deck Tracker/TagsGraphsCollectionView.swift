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
        //getStatistics()
        self.collectionView!.reloadData()
    }
    
    func getDateIndex() {
        dateIndex = NSUserDefaults.standardUserDefaults().integerForKey("Date Index")
        print("Date Index is: " + String(dateIndex))
    }
    
    func getDeckName() {
        if let _ =  NSUserDefaults.standardUserDefaults().stringForKey("Deck Name") as String! {
            deckName = NSUserDefaults.standardUserDefaults().stringForKey("Deck Name") as String!
        } else {
            deckName = ""
        }
        print("Deck Name is: " + deckName)
    }
    
    func getGraphsClicked() {
        if let _ = NSUserDefaults.standardUserDefaults().integerForKey("Index Of Selected Graph") as Int! {
            indexOfSelectedGraph = NSUserDefaults.standardUserDefaults().integerForKey("Index Of Selected Graph")
        }
        
        let opponentSelected = data[indexOfSelectedGraph]
        //print(opponentSelected)
        
        filteredGames = Data.sharedInstance.getStatisticsGamesTotal(dateIndex, deck: deckName, opponent: opponentSelected)
        print(filteredGames)
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
        if filteredGames.count == 0 {
            return 1
        } else {
            return filteredGames.count
        }
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! TagsGraphsCollectionCell
        if filteredGames.count == 0 {
            cell.tagLabel.hidden = true
            cell.label.text = "No data"
        } else {
           cell.label.text = "aaa"
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
