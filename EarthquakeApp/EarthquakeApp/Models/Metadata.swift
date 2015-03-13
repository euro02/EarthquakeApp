//
//  Metadata.swift
//  EarthquakeApp
//
//  Created by Eduardo Antonio Pérez Muñoz on 12/03/15.
//  Copyright (c) 2015 Eduardo Perez. All rights reserved.
//

import Foundation
import JSONJoy

struct Metadata : JSONJoy {
    var generated: Int?
    var url: String?
    var title: String?
    var api: String?
    var count: Int?
    var status: Int?
    init() {}
    init(_ decoder: JSONDecoder) {
        generated = decoder["generated"].integer
        url = decoder["url"].string
        title = decoder["title"].string
        api = decoder["api"].string
        count = decoder["count"].integer
        status = decoder["status"].integer
    }
}

