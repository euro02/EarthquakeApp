//
//  ViewController.swift
//  EarthquakeApp
//
//  Created by Eduardo Antonio Pérez Muñoz on 11/03/15.
//  Copyright (c) 2015 Eduardo Perez. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var txtMag: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    
    var feature: Feature!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = feature!.properties!.place!
        txtMag.text = feature!.properties!.mag!.description
        txtDate.text = getLocalDateFromTimestamp()
        txtLocation.text = "["+feature!.geometry!.coordinates![1].description+", "+feature!.geometry!.coordinates![0].description+", "+feature!.geometry!.coordinates![2].description+"]"
        
        setLocationInMapView(CLLocationCoordinate2D(
            latitude: feature!.geometry!.coordinates![1],
            longitude: feature!.geometry!.coordinates![0]
        ))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getLocalDateFromTimestamp() -> String{
        let timestamp = Double(feature!.properties!.time!/1000)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.stringFromDate(NSDate(timeIntervalSince1970:timestamp))
    }
    
    func setLocationInMapView(location:CLLocationCoordinate2D){
        let span = MKCoordinateSpanMake(0.25, 0.25)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = self.title
        annotation.subtitle = "["+location.latitude.description+", "+location.longitude.description+"]"
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
    }

}

