//
//  Feature.swift
//  EarthquakeApp
//
//  Created by Eduardo Antonio Pérez Muñoz on 12/03/15.
//  Copyright (c) 2015 Eduardo Perez. All rights reserved.
//

import Foundation
import JSONJoy

struct Feature : JSONJoy {
    var objID: String?
    var type: String?
    var properties: Property?
    var geometry: Geometry?
    init() {}
    init(_ decoder: JSONDecoder) {
        objID = decoder["id"].string
        type = decoder["type"].string
        properties = Property(decoder["properties"])
        geometry = Geometry(decoder["geometry"])
        
    }
}