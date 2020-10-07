//
//  ActivitMapViewController.swift
//  CSE335 Project
//
//  Created by tnguy107 on 3/11/19.
//  Copyright © 2019 tnguy107. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ActivitMapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var frontPage: UIButton!
    @IBOutlet weak var place: UITextField!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var mapType: UISegmentedControl!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var activity: UILabel!
    

    var manager:CLLocationManager!
    var city: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        frontPage.layer.cornerRadius = 20
        frontPage.clipsToBounds = true
        
        //permission for location
        DispatchQueue.main.async{
            self.manager = CLLocationManager()
            self.manager.delegate = self
            self.manager.desiredAccuracy = kCLLocationAccuracyBest
            self.manager.requestWhenInUseAuthorization()
            self.manager.startUpdatingLocation()
        }
    }
    
    class func isLocationServiceEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            default:
                print("Something wrong with Location services")
                return false
            }
        } else {
            print("Location services are not enabled")
            return false
        }
    }
    
    
    //convert places to coordinate in map
    @IBAction func go(_ sender: UIButton) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.place.text
        request.region = map.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            for i in 1...matchingItems.count - 1
            {
                let place = matchingItems[i].placemark
                let annotation = MKPointAnnotation()
                annotation.coordinate = place.location!.coordinate
                annotation.title = place.name
            
                self.map.addAnnotation(annotation)
            }
        }
    }
    
    //changing the map type
    @IBAction func changeMapType(_ sender: UISegmentedControl) {
        //switch between standard and satellite
        switch(mapType.selectedSegmentIndex)
        {
        case 0:
            map.mapType = MKMapType.standard
            
        case 1:
            map.mapType = MKMapType.satellite
            
        default:
            map.mapType = MKMapType.standard
        }
    }
    
    //show where you are on map
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //userLocation - there is no need for casting, because we are now using CLLocation object
        let location:CLLocation = locations[0]
        let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        self.map.setRegion(region, animated: true)
        let ani = MKPointAnnotation()
        ani.coordinate = location.coordinate
        ani.title = "You are here"
        self.map.addAnnotation(ani)
    
        //find out what city the user is in
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            self.city = placeMark.locality!
        })
    }
  
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    //web api call to get current weather
    @IBAction func getWeather(_ sender: UIButton) {
        //replace space with plus
        self.city = (self.city as NSString).replacingOccurrences(of: " ", with: "+")
        
        //get weather
        let urlAsString = "http://api.openweathermap.org/data/2.5/weather?q=\(self.city)&units=imperial&appid=16c223117bb628a06ba33391d703386f"
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
            var temp = 0
            DispatchQueue.main.async {
                temp = Int(truncating: main["temp"] as! NSNumber)
                self.temp.text =  (main["temp"] as! NSNumber).stringValue
                switch (temp)
                {
                case ..<60:
                    self.activity.text = "golf, picnic, biking"
                case 60..<80:
                    self.activity.text = "tennis, shopping, fishing"
                case 80...:
                    self.activity.text = "swimming, hang out with friends"
                default:
                     self.activity.text = ""
                }
                self.humidity.text =  (main["humidity"] as! NSNumber).stringValue
                self.pressure.text =  (main["pressure"] as! NSNumber).stringValue
                self.windSpeed.text = (wind["speed"] as! NSNumber).stringValue
            }

        })
        jsonQuery.resume()

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
