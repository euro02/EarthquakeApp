//
//  Geometry.swift
//  EarthquakeApp
//
//  Created by Eduardo Antonio Pérez Muñoz on 12/03/15.
//  Copyright (c) 2015 Eduardo Perez. All rights reserved.
//

import Foundation
import JSONJoy

struct Geometry : JSONJoy {
    var type: String?
    var coordinates: Array<Double>?
    init() {
    }
    init(_ decoder: JSONDecoder) {
        type = decoder["type"].string
        if let coo = decoder["coordinates"].array {
            coordinates = Array<Double>()
            for featDecoder in coo {
                coordinates?.append(featDecoder.double!)
            }
        }
    }
}