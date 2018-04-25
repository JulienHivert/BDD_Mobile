//
//  categoryController.swift
//  iOS_BDD_Do_It
//
//  Created by iem on 06/04/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class categoryController: UIViewController {
    
    var categories = Array<Categorie>()
    
    @IBAction func categorie1(_ sender: UIButton) {
       // item?.caterogire  = l'objet categorie qui correspond à la categorie 1
        item?.categorie = categories[0]
        dismiss(animated: true, completion: nil)
    }
    @IBAction func categorie2(_ sender: UIButton) {
        // item?.caterogire  = l'objet categorie qui correspond à la categorie 2
        item?.categorie = categories[1]
        dismiss(animated: true, completion: nil)
    }
    @IBAction func categorie3(_ sender: UIButton) {
        // item?.caterogire  = l'objet categorie qui correspond à la categorie 3
        item?.categorie = categories[2]
        dismiss(animated: true, completion: nil)
    }
    @IBAction func categorie4(_ sender: UIButton) {
        // item?.caterogire  = l'objet categorie qui correspond à la categorie 4
        item?.categorie = categories[3]
        dismiss(animated: true, completion: nil)
    }
    @IBAction func categorie5(_ sender: UIButton) {
        // item?.caterogire  = l'objet categorie qui correspond à la categorie 5
        item?.categorie = categories[4]
        dismiss(animated: true, completion: nil)
    }
    @IBAction func categorie6(_ sender: UIButton) {
        // item?.caterogire  = l'objet categorie qui correspond à la categorie 6
        item?.categorie = categories[5]
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func skip(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private var customPopUp : UIView!
    var item : Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = DataManager.sharedInstance.cachedCategories
        //customPopUp.isHidden = true
        
    }
}
