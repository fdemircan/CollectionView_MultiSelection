//
//  Content.swift
//  CollectionViewMultiSelect
//
//  Created by Fetiye Demircan on 25.05.2018.
//  Copyright © 2018 Fetiye Demircan. All rights reserved.
//

import Foundation

class Content{
    var images: [Image] = [Image]()
    
    init?(json: JSON) {
        guard let imageJSON = json["images"] as? [JSON] else { return nil }
        let images = imageJSON.map({ Image(json: $0)! })
        self.images = images
    }
}
