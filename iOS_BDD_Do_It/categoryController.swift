//
//  categoryController.swift
//  iOS_BDD_Do_It
//
//  Created by iem on 06/04/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class categoryController: UIViewController {
    @IBAction func categorie1(_ sender: UIButton) {
       // item?.caterogire  = l'objet categorie qui correspond à la categorie 1
    }
    @IBAction func categorie2(_ sender: UIButton) {
        // item?.caterogire  = l'objet categorie qui correspond à la categorie 2
    }
    @IBAction func categorie3(_ sender: UIButton) {
        // item?.caterogire  = l'objet categorie qui correspond à la categorie 3
    }
    
    @IBAction func categorie4(_ sender: UIButton) {
        // item?.caterogire  = l'objet categorie qui correspond à la categorie 4
    }
    @IBAction func categorie5(_ sender: UIButton) {
        // item?.caterogire  = l'objet categorie qui correspond à la categorie 5

    }
    @IBAction func skip(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private var customPopUp : UIView!
    var item : Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //customPopUp.isHidden = true
        
    }
}
