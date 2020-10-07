//
//  WebAPIModel.swift
//  CSE335 Project
//
//  Created by tnguy107 on 4/15/19.
//  Copyright © 2019 tnguy107. All rights reserved.
//

import Foundation

class WebAPIModel{
    var array:[Any] = [0,"",0,0,0]
    func getInfo(city: String) -> ([Any]){
        let urlAsString = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&units=imperial&appid=16c223117bb628a06ba33391d703386f"
        print(urlAsString)
        let url = URL(string: urlAsString)!
        
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            
            var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            print(jsonResult)
            
            //process data from result
            let main = jsonResult["main"] as! [String: Any]
            let wind = jsonResult["wind"] as! [String: Any]
            DispatchQueue.main.async {
                self.array[0] = Int(truncating: main["temp"] as! NSNumber)
                print("model")
                print(self.array[0])
                switch (self.array[0] as! Int)
                {
                case ..<60:
                    self.array[1] = "golf, picnic, biking"
                case 60..<80:
                    self.array[1] = "tennis, shopping, fishing"
                case 80...:
                    self.array[1] = "swimming, hang out with friends"
                default:
                    self.array[1] = ""
                }
                self.array[2] =  Int(truncating:(main["humidity"] as! NSNumber))
                self.array[3] = Int(truncating:(main["pressure"] as! NSNumber))
                self.array[4] = Int(truncating:(wind["speed"] as! NSNumber))
            }
        })
        jsonQuery.resume()
        
        return self.array
        
        
    }
    
    
}
