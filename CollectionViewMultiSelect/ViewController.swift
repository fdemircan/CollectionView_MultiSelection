//
//  PopupViewController.swift
//  CollectionViewMultiSelect
//
//  Created by Fetiye Demircan on 25.05.2018.
//  Copyright © 2018 Fetiye Demircan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var image: UIImage?
    var selectedSection: Int?
    var selectCell: Int?
    var detailOptionName: String?
    var select: Bool?
    
    var _selectedCells : NSMutableArray = []
    var detailOptNames: [String] = [String]()
    var optnames: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePopUpClosing), name: .optionName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getSelectState), name: .detailSelect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCV), name: .updateCV, object: nil)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        
        
        getProductOptionsCollection()
    }
    
    @objc func handlePopUpClosing(notification: Notification){
        let name = notification.object as! PopupViewController
        detailOptionName = name.optionName
        detailOptNames.append(detailOptionName!)
    }
    
    @objc func updateCV(notification: Notification){
        self.collectionView.reloadData()
    }
    
    @objc func getSelectState(notification: Notification){
        let name = notification.object as! PopupViewController
        select = name.detailSelect!
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentCollection[section].images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductOptionCell", for: indexPath) as! ProductOptionCell
        
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor(named: "silverGray")
        }else{
            cell.backgroundColor = UIColor(named: "lightGray")
        }
        
        cell.optionGroupName.text = contentCollection[indexPath.section].images[indexPath.row].idiom
        cell.isSelect = false
        
        print(indexPath.section)
        print(indexPath.row)
        
        if _selectedCells.contains(indexPath){
            if select == true{
                cell.isSelect = true
                print("-------------------------")
                print(selectedSection!)
                print(selectCell!)
                print(detailOptNames)
                if selectedSection != nil && selectCell != nil{
                    if indexPath.section == selectedSection && indexPath.row == selectCell{
                        cell.optionName.text = detailOptionName
                        optnames = detailOptNames
                        // selectCell = nil
                        // selectedSection = nil
                    }else{
                        print(optnames)
                        cell.optionName.text = optnames.first
                        optnames.removeFirst()
                    }
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSection = indexPath.section
        selectCell = indexPath.row
        _selectedCells.add(indexPath)
        
        self.performSegue(withIdentifier: "toPopup", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPopup"{
            let destinationVC = segue.destination as? PopupViewController
            destinationVC?.selectedCell = selectCell
            destinationVC?.selectedSection = selectedSection
        }
    }
    
    func getProductOptionsCollection(){
        DataService.shared.getData { (data) in
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON else { return }
                let itemResponse = Content(json: json)
                guard let contentCollections = itemResponse else { return }
                print(contentCollections)
                contentCollection = [contentCollections]
                
            } catch {
                print(error)
            }
        }
    }
    
   
    
    
}
