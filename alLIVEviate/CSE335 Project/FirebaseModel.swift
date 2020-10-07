//
//  FirebaseModel.swift
//  CSE335 Project
//
//  Created by tnguy107 on 4/15/19.
//  Copyright © 2019 tnguy107. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseModel {
    var ref = Database.database().reference()
    var list: [[String: Any]] = []
    
    
    //store in firebase
    func storeFirebase(s0: Int, s1: Int, s2: Int, s3: Int, s4: Int, s5: Int,s6: Int, totalScore: Int){
        self.ref.childByAutoId().setValue([
            "score0" : s0,
            "score1" : s1,
            "score2" : s2,
            "score3" : s3,
            "score4" : s4,
            "score5" : s5,
            "score6" : s6,
            "totalScore": totalScore,
            ])
    }
    
    func loadFirebase() -> ([[String: Any]])
    {
        ref = Database.database().reference()
        ref.observe(.value, with: { snapshot in
            //Handler Function Body
            // For each item in the list
            for item in snapshot.children{
                let data = item as! DataSnapshot
                let eachRow = data.value as! [String:Any]
                //
                //append to 1 big array list
                let tempList = [data.key: eachRow]
                self.list.append(tempList)
            }
        })
        return list
    }
    
    
}
