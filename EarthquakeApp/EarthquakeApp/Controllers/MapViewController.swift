//
//  MapViewController.swift
//  EarthquakeApp
//
//  Created by Eduardo Antonio Pérez Muñoz on 11/03/15.
//  Copyright (c) 2015 Eduardo Perez. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var collection: FeatureCollection!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        for index in collection!.features! {
            setLocationInMapView(CLLocationCoordinate2D(
                latitude: index.geometry!.coordinates![1],
                longitude: index.geometry!.coordinates![0]
                ), namePlace: index.properties!.place!, magnitude: index.properties!.mag!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLocationInMapView(location:CLLocationCoordinate2D, namePlace:String, magnitude:Double){
        let span = MKCoordinateSpanMake(125, 125)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = namePlace
        annotation.subtitle = magnitude.description
        mapView.addAnnotation(annotation)
    }
    
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation is MKUserLocation {
            return nil
        }
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier("pin")
        
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            pinView!.canShowCallout = true
            pinView!.image = UIImage(named: getColorFromMagnitude(annotation.subtitle!))
            
            var mugIconView = UIImageView(image: UIImage(named: getColorFromMagnitude(annotation.subtitle!)))
            pinView!.leftCalloutAccessoryView = mugIconView
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func getColorFromMagnitude(color:String)->String{
        switch((color as NSString).doubleValue){
        case 0...0.9: return "mapIconGreen"
        case 0.9...4: return "mapIconBlue"
        case 4...6: return "mapIconYellow"
        case 6...8.99: return "mapIconOrange"
        case 9...9.9: return "mapIconRed"
        default: return "mapIconBlack"
        }
    }
}

