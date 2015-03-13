//
//  FeatureCollection.swift
//  EarthquakeApp
//
//  Created by Eduardo Antonio Pérez Muñoz on 12/03/15.
//  Copyright (c) 2015 Eduardo Perez. All rights reserved.
//

import Foundation
import JSONJoy

struct FeatureCollection : JSONJoy {
    var type: String?
    var metadata: Metadata?
    var features: Array<Feature>?
    init() {}
    init(_ decoder: JSONDecoder) {
        type = decoder["type"].string
        metadata = Metadata(decoder["metadata"])
        if let feat = decoder["features"].array {
            features = Array<Feature>()
            for featDecoder in feat {
                features?.append(Feature(featDecoder))
            }
        }
    }
}