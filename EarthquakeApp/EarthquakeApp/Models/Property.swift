//
//  Property.swift
//  EarthquakeApp
//
//  Created by Eduardo Antonio Pérez Muñoz on 12/03/15.
//  Copyright (c) 2015 Eduardo Perez. All rights reserved.
//

import Foundation
import JSONJoy

struct Property : JSONJoy {
    var mag: Double?
    var place: String?
    var	url: String?
    var	time: Double?
    init() {}
    init(_ decoder: JSONDecoder) {
        mag = decoder["mag"].double
        place = decoder["place"].string
        url = decoder["url"].string
        time = decoder["time"].double
    }
}
