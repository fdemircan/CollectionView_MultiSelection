//
//  ProductOptionCell.swift
//  Atölye
//
//  Created by Fetiye Demircan on 21.05.2018.
//  Copyright © 2018 Fetiye Demircan. All rights reserved.
//

import UIKit

class ProductOptionCell: UICollectionViewCell {
    @IBOutlet weak var optionGroupName: UILabel!
    @IBOutlet weak var optionName: UILabel!
    @IBOutlet weak var checkIcon: UIImageView!
    var isSelect: Bool?{
        didSet{
            if self.isSelect == true{
                self.checkIcon.isHidden = false
                self.optionName.isHidden = false
            }
            else{
                self.checkIcon.isHidden = true
                self.optionName.isHidden = true
            }
        }
    }
}
