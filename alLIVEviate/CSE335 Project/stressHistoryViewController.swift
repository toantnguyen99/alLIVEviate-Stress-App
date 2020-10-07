//
//  stressHistoryViewController.swift
//  CSE335 Project
//
//  Created by tnguy107 on 3/11/19.
//  Copyright © 2019 tnguy107. All rights reserved.
//

import UIKit
import FirebaseDatabase


class stressHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    var firebaseModel: FirebaseModel = FirebaseModel()
    var itemList: [[String: Any]] = []
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let itemList = firebaseModel.loadFirebase()
        print(itemList.count)
        //Call the observe function to set up the observer
        ref.observe(.value, with: { snapshot in
            //Handler Function Body
            // For each item in the list
            for item in snapshot.children{
                let data = item as! DataSnapshot
                let eachRow = data.value as! [String:Any]
//
//                //append to 1 big array list
                let tempList = [data.key: eachRow]
                self.itemList.append(tempList)
                }
            self.table.reloadData()
        })
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return how many row needed
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let dict1 = itemList[indexPath.row]
        //let key = Array(dict1.keys)[0]
        let value = Array(dict1.values)[0] as! [String:Any]
        cell.stressLevel.text = String (value["totalScore"] as! Int)
        cell.lowEnergyScore.text = String (value["score0"] as! Int)
        cell.headachesScore.text = String (value["score1"] as! Int)
        cell.tenseMusclesScore.text = String (value["score2"] as! Int)
        cell.insominiaScore.text = String (value["score3"] as! Int)
        cell.skinRashesScore.text = String (value["score4"] as! Int)
        cell.painScore.text = String (value["score5"] as! Int)
        let durationScoreInt = value["score6"] as! Int
        switch (durationScoreInt){
        case 1:
            cell.durationScore.text = "Few Days"
        case 2:
            cell.durationScore.text = "Months"
        default:
            cell.durationScore.text = "Few Hours"
        }
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
