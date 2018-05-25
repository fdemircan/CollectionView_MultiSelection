//
//  PopupOptionCell.swift
//  Atölye
//
//  Created by Fetiye Demircan on 24.05.2018.
//  Copyright © 2018 Fetiye Demircan. All rights reserved.
//

import UIKit

class PopupOptionCell: UICollectionViewCell {
    
    @IBOutlet weak var optionName: UILabel!
    @IBOutlet weak var checkIcon: UIImageView!
    var select: Bool?{
        didSet{
            if self.select == true{
                self.checkIcon.isHidden = false
            }
            else{
                self.checkIcon.isHidden = true
            }
        }
    }
}
