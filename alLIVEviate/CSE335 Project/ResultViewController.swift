//
//  ResultViewController.swift
//  CSE335 Project
//
//  Created by tnguy107 on 3/11/19.
//  Copyright © 2019 tnguy107. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var website: UIButton!
    @IBOutlet weak var map: UIButton!
    @IBOutlet weak var frontPage: UIButton!
    @IBOutlet weak var stressLevelLabel: UILabel!
    var stressDuration: Int = Int()
    
    var stressLevel: Int = Int()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //configure buttons
        website.layer.cornerRadius = 20
        website.clipsToBounds = true
        map.layer.cornerRadius = 20
        map.clipsToBounds = true
        frontPage.layer.cornerRadius = 20
        frontPage.clipsToBounds = true
        
        //configure info
        stressLevelLabel.text = String (stressLevel)
        
    }
    
    //go to the website appropriate for your stress
    @IBAction func goToWeb(_ sender: UIButton) {
        if (stressLevel <= 15 && stressDuration == 0)
        {
            if let url = URL(string: "https://www.healthline.com/nutrition/16-ways-relieve-stress-anxiety"), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        else if (stressDuration == 0)
        {
            if let url = URL(string: "https://adaa.org/tips"), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        else if (stressLevel <= 15 && stressDuration == 1)
        {
            if let url = URL(string: "https://www.medicalnewstoday.com/articles/324354.php"), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        else if (stressDuration == 1)
        {
            if let url = URL(string: "https://www.medicalnewstoday.com/articles/323324.php"), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        else if (stressDuration == 2)
        {
            if let url = URL(string: "https://health.usnews.com/health-news/health-wellness/articles/2013/03/21/how-to-handle-extreme-stress"), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
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
