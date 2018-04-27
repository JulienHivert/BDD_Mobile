//
//  categoryController.swift
//  iOS_BDD_Do_It
//
//  Created by iem on 06/04/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

protocol categoryControllerDelegate : class {
	func categoryController(_ viewController: categoryController)
}

class categoryController: UIViewController {
	weak var delegate : categoryControllerDelegate?
	
	var categories = Array<Categorie>()
	
	@IBOutlet weak var orangeButton: UIButton!
	@IBOutlet weak var yellowButton: UIButton!
	@IBOutlet weak var greenButton: UIButton!
	@IBOutlet weak var purpleButton: UIButton!
	@IBOutlet weak var blueButton: UIButton!
	@IBOutlet weak var blackButton: UIButton!
	@IBOutlet weak var skipButton: UIButton!
	
	@IBAction func onClickButton(_ sender : UIButton) {
		switch sender {
		case orangeButton:
			item?.categorie = categories[0]
			onBackToList()
			break
		case yellowButton:
			item?.categorie = categories[1]
			onBackToList()
			break
		case greenButton:
			item?.categorie = categories[2]
			onBackToList()
			break
		case purpleButton:
			item?.categorie = categories[3]
			onBackToList()
			break
		case blueButton:
			item?.categorie = categories[4]
			onBackToList()
			break
		case blackButton:
			item?.categorie = categories[5]
			onBackToList()
			break
		default:
			onBackToList()
			break
			
		}
	}
	
	func onBackToList() {
		dismiss(animated: true, completion: nil)
		delegate?.categoryController(self)
	}
	private var customPopUp : UIView!
	var item : Item?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		categories = DataManager.sharedInstance.cachedCategories
		//customPopUp.isHidden = true
		
	}
}
