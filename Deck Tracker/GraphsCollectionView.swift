//
//  GraphsCollectionView.swift
//  Deck Tracker
//
//  Created by Andrei Joghiu on 22/10/15.
//  Copyright © 2015 Andrei Joghiu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "GraphsCollectionCell"

@IBDesignable
class GraphsCollectionView: UICollectionViewController {
    
    var graphsTitle:[String] = ["All", "Warrior", "Paladin", "Shaman", "Hunter", "Druid", "Rogue", "Mage", "Warlock", "Priest"]
    var dateIndex = -1
    var deckName = ""
    var playerDeckLabelArray:[String] = []
    var playerDeckIcon = ""
    var opponentClasses = ["GenericSmall", "WarriorSmall", "PaladinSmall", "ShamanSmall", "HunterSmall", "DruidSmall", "RogueSmall", "MageSmall", "WarlockSmall", "PriestSmall"]
    var winRateArray:[Int] = []
    var gamesWonArray:[Int] = []
    var gamesLostArray:[Int] = []
    var gamesFilteredByOpponent:[[Game]] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        NotificationCenter.default.addObserver(self, selector: #selector(GraphsCollectionView.loadList(_:)),name:NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    @objc func loadList(_ notification: Notification){
        //Gets info on rows and reloads the table view
        loadData()
    }
    
    func loadData() {
        getDateIndex()
        getDeckName()
        getStatistics()
        self.collectionView!.reloadData()
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func getDateIndex() {
        dateIndex = UserDefaults.standard.integer(forKey: "Date Index")
        //print("Date Index is: " + String(dateIndex))
    }
    
    func getDeckName() {
        if let _ =  UserDefaults.standard.string(forKey: "Deck Name") {
            deckName = UserDefaults.standard.string(forKey: "Deck Name")!
        } else {
            deckName = ""
        }
        //print("Deck Name is: " + deckName)
    }
    
    func getStatistics() {
        
        winRateArray = []
        gamesWonArray = []
        gamesLostArray = []
        gamesFilteredByOpponent = []
        
        let data = ["All", "Warrior", "Paladin", "Shaman", "Hunter", "Druid", "Rogue", "Mage", "Warlock", "Priest"]
        for opponent in data {
            getStatisticsVs(opponent)
        }
        
        // Saves all games in an array filtered by: What the user selected in the buttons + each opponent
        //print(gamesFilteredByOpponent.count)
        //print(gamesFilteredByOpponent)
        //NSUserDefaults.standardUserDefaults().setObject(gamesFilteredByOpponent, forKey: "Games Filtered By Opponent")
        //NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func getStatisticsVs(_ opponent:String) {
        var filteredGames:[Game] = []
        var totalGames = 0
        var wonGames = 0
        var lostGames = 0
        
        filteredGames = Data.sharedInstance.getStatisticsGamesTotal(dateIndex, deck: deckName, opponent: opponent)
        totalGames = filteredGames.count
        
        //gamesFilteredByOpponent.append(filteredGames)
        
        
        for game in filteredGames {
            if game.getWin() == true {
                wonGames += 1
            } else {
                lostGames += 1
            }
        }
        
        var winRateDouble:Double = 0
        if totalGames != 0 {
            winRateDouble =  Double(wonGames) / Double(totalGames) * 100
        }
        
        let winRateInt = Int(winRateDouble)
        
        winRateArray.append(winRateInt)
        gamesWonArray.append(wonGames)
        gamesLostArray.append(lostGames)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GraphsCollectionCell
        
        // Configure the cell
        
        cell.versusLabel.text = "vs. " + graphsTitle[indexPath.row]
        cell.opponentClassImage.image = UIImage(named: opponentClasses[indexPath.row])

        if gamesWonArray[indexPath.row] == 0 && gamesLostArray[indexPath.row] == 0 {
            cell.winInfoLabel.text = "No Data"
        } else {
            cell.winInfoLabel.text = String(winRateArray[indexPath.row]) + "% : " + "(" + String(gamesWonArray[indexPath.row]) + "-" + String(gamesLostArray[indexPath.row]) + ")"
        }
        
        cell.per = CGFloat(winRateArray[indexPath.row])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.size.width
        var cellWidth = (width / 2) - 5
        //print(cellWidth)
        
        if cellWidth > 300 {
            cellWidth = 200
        }
        
        return CGSize(width: cellWidth, height: cellWidth)
            
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        //Save the index of the selected graph
        let indexOfSelectedGraph = indexPath.row
        //print(indexOfSelectedGraph)
        UserDefaults.standard.set(indexOfSelectedGraph, forKey: "Index Of Selected Graph")
        return true
    }
}
