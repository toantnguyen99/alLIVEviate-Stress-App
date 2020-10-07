//
//  ViewController.swift
//  CSE335 Project
//
//  Created by tnguy107 on 3/11/19.
//  Copyright © 2019 tnguy107. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var feelingStress: UIButton!
    @IBOutlet weak var stressHistory: UIButton!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        feelingStress.layer.cornerRadius = 20
        feelingStress.clipsToBounds = true
        stressHistory.layer.cornerRadius = 20
        stressHistory.clipsToBounds = true
        image1.image = UIImage(named: "maxresdefault.jpg")
        image2.image = UIImage(named: "images.jpeg")
        image3.image = UIImage(named: "images (1).jpeg")
        image4.image = UIImage(named: "download.jpeg")
    }
    
    //return from result page
    @IBAction func fromResult(segue:UIStoryboardSegue){
        
    }
    
    //return from activity map page
    @IBAction func fromActivityMap(segue:UIStoryboardSegue){
    }
    
}





