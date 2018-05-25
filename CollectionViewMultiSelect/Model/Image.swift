//
//  Image.swift
//  CollectionViewMultiSelect
//
//  Created by Fetiye Demircan on 25.05.2018.
//  Copyright © 2018 Fetiye Demircan. All rights reserved.
//

import Foundation

class Image{
    var idiom: String?
    var size: String?
    var scale: String?
    var isSelect: Bool = false
    
    init?(json: JSON) {
        guard let idiom = json["idiom"] as? String,
            let size = json["size"] as? String,
            let scale = json["scale"] as? String
            else { return nil }
        
        self.idiom = idiom
        self.size = size
        self.scale = scale
        
    }
}
