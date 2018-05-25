//
//  ViewController.swift
//  CollectionViewMultiSelect
//
//  Created by Fetiye Demircan on 25.05.2018.
//  Copyright © 2018 Fetiye Demircan. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var popupView: UIView!
    
    var _selectedIndex : NSMutableArray = []
    var selectedCell: Int?
    var selectedSection: Int?
    var selectedIndex: Int?
    var optionName: String?
    var detailSelect: Bool?
    var selectId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        popupView.layer.cornerRadius = 25
        popupView.clipsToBounds = true
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
    }

    @IBAction func dismissPopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButton(_ sender: Any) {
        NotificationCenter.default.post(name: .updateCV, object: self)
        dismiss(animated: true, completion: nil)
    }
    
}

extension PopupViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentCollection[selectedSection!].images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopupOptionCell", for: indexPath) as! PopupOptionCell
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: cell.frame.height - 1, width: cell.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(named: "lightGray")?.cgColor
        cell.layer.addSublayer(bottomLine)
        
        cell.select = false
        contentCollection[selectedSection!].images[selectedCell!].isSelect = true
        
        let data = contentCollection[selectedSection!].images[selectedCell!]
        cell.optionName.text = data.size
        if _selectedIndex.contains(indexPath){
            cell.select = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectCell = collectionView.cellForItem(at: indexPath) as! PopupOptionCell
        optionName = selectCell.optionName.text
        detailSelect = true
        selectedIndex = indexPath.row
        _selectedIndex.add(indexPath)
        self.collectionView.reloadData()
        
        NotificationCenter.default.post(name: .optionName, object: self)
        NotificationCenter.default.post(name: .detailSelect, object: self)
    }
    
}
