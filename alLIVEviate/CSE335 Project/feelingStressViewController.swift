//
//  feelingStressViewController.swift
//  CSE335 Project
//
//  Created by tnguy107 on 3/11/19.
//  Copyright © 2019 tnguy107. All rights reserved.
//

import UIKit


class feelingStressViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    @IBOutlet weak var takeAPicture: UIButton!
    @IBOutlet weak var Next: UIButton!
    @IBOutlet weak var imageSelected: UIImageView!
    @IBOutlet weak var lowEnergy: UISegmentedControl!
    @IBOutlet weak var headaches: UISegmentedControl!
    @IBOutlet weak var tenseMuscles: UISegmentedControl!
    @IBOutlet weak var insominia: UISegmentedControl!
    @IBOutlet weak var skinRashes: UISegmentedControl!
    @IBOutlet weak var pain: UISegmentedControl!
    @IBOutlet weak var duration: UISegmentedControl!
    
    
    var calModel: CalcalutionModel = CalcalutionModel()
    var firebaseModel: FirebaseModel = FirebaseModel()
    var totalScore = 0
    let picker = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        takeAPicture.layer.cornerRadius = 20
        takeAPicture.clipsToBounds = true
        Next.layer.cornerRadius = 20
        Next.clipsToBounds = true
        picker.delegate = self
    }
    
    //return the total score and store in firebase
    @IBAction func next(_ sender: UIButton) {
        let score0 = lowEnergy.selectedSegmentIndex,
            score1 = headaches.selectedSegmentIndex,
            score2 = tenseMuscles.selectedSegmentIndex,
            score3 = insominia.selectedSegmentIndex,
            score4 = skinRashes.selectedSegmentIndex,
            score5 = pain.selectedSegmentIndex,
            score6 = duration.selectedSegmentIndex
 
        totalScore = calModel.findTotalScores(s0: score0, s1: score1, s2: score2, s3: score3, s4: score4, s5: score5)
        
       //store data in fire base
        firebaseModel.storeFirebase(s0: score0, s1: score1, s2: score2, s3: score3, s4: score4, s5: score5, s6: score6, totalScore: totalScore)
        
    }
    
    //insert a picture
    @IBAction func insertPicture(_ sender: UIButton) {
        //alert for picture
        let alert = UIAlertController(title: "Add Picture from Library", message: nil, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        //take a picture from camera
        alert.addAction(UIAlertAction(title: "Take a Picture", style: .default, handler: { action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.picker.allowsEditing = false
                self.picker.sourceType = UIImagePickerController.SourceType.camera
                self.picker.cameraCaptureMode = .photo
                self.picker.modalPresentationStyle = .fullScreen
                self.present(self.picker,animated: true,completion: nil)
            } else {
                print("No camera")
            }
        }))
        //use a picture in the library
        alert.addAction(UIAlertAction(title: "From library", style: .default, handler: { action in
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.picker.modalPresentationStyle = .popover
            self.present(self.picker, animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
    }
    
    //After choosing a picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
       
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        picker .dismiss(animated: true, completion: nil)
        // Local variable inserted by Swift 4.2 migrator.
    imageSelected.image=info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
        //info[.originalImage] as! UIImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //pass value over to result view
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toResults"){
            let resultView = segue.destination as! ResultViewController
            resultView.stressLevel = totalScore
            resultView.stressDuration = duration.selectedSegmentIndex
        }
        
    }
}




// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
