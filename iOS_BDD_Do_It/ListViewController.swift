//
//  ViewController.swift
//  iOS_BDD_Do_It
//
//  Created by iem on 30/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

import UIKit
class ListViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var items2 = Array<Item>()
    override func viewDidLoad() {
        super.viewDidLoad()
        //createItem()
        try? DataManager.sharedInstance.loadListItems()
        items2 = DataManager.sharedInstance.cachedItems
        searchBar.placeholder = "Search Item"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCategorie" {
            let categoryController = segue.destination as! categoryController
            categoryController.item = sender as! Item
        }
    }
    
    @IBAction func addAction(_ sender: Any) {
        let alertController =  UIAlertController(title: "Doit", message: "New item", preferredStyle: .alert)
        
        alertController.addTextField{ (textField) in
            textField.placeholder = "Name"
        }
        alertController.addTextField{ (descField) in
            descField.placeholder = "Description"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        let okAction = UIAlertAction(title: "Ok", style: .default){ (action) in
            let textField = alertController.textFields![0]
            
            if textField.text != "" {
            
            let item = Item(context : DataManager.sharedInstance.persistentContainer.viewContext )
            item.name = alertController.textFields![0].text!
            item.checked = false
            item.desc = alertController.textFields![1].text!
            DataManager.sharedInstance.cachedItems.append(item)
            DataManager.sharedInstance.saveListItems()
            self.performSegue(withIdentifier: "showCategorie", sender: item)
            
            self.resetSearchBar()
            self.tableView.reloadData()
            }
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        //Placer l'ouverture de la popup içi
        
        present(alertController, animated: true, completion: nil)
    
}
    @IBAction func editAction(_ sender: Any) {
        //        let editButton = sender as! UIBarButtonItem
        //        editButton.se
        tableView.isEditing = !tableView.isEditing
    }
    
    func resetSearchBar(){
        searchBar.text = ""
        items2 = DataManager.sharedInstance.cachedItems
    }
}
extension ListViewController : UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items2.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCellIdentifier", for: indexPath) as! CustomCell
        let item = items2[indexPath.row]
        cell.nameCell?.text = item.name
        cell.descCell?.text = item.desc
        //let nameCategorie = item.categorie?.name
        
        switch (item.categorie?.name) {
        case "orange"? :
            cell.tagCell.backgroundColor = UIColor.orange
        case "yellow"? :
            cell.tagCell.backgroundColor = UIColor.yellow
        case "green"? :
            cell.tagCell.backgroundColor = UIColor.green
        case "purple"? :
            cell.tagCell.backgroundColor = UIColor.purple
        case "blue"? :
            cell.tagCell.backgroundColor = UIColor.blue
        case "black"? :
            cell.tagCell.backgroundColor = UIColor.black
        default :
            cell.tagCell.backgroundColor = UIColor.white
        }
        cell.tagCell?.layer.cornerRadius = 5
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let sourceItem = DataManager.sharedInstance.cachedItems.remove(at: sourceIndexPath.row)
        
        DataManager.sharedInstance.cachedItems.insert(sourceItem, at: destinationIndexPath.row)
        DataManager.sharedInstance.saveListItems()
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return searchBarIsEmpty()
    }
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = (items2[indexPath.row].checked) ? .none : .checkmark
        items2[indexPath.row].checked = !items2[indexPath.row].checked
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return DataManager.sharedInstance.cachedItems.count > 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let itemIndex = DataManager.sharedInstance.cachedItems.index(where:{ $0 === items2[indexPath.item]})!
        DataManager.sharedInstance.delete(item: items2[indexPath.item])
        items2.remove(at: indexPath.item)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        DataManager.sharedInstance.saveListItems()
        
        
    }
    
    //MARK: UISearchResultsUpdating
    
    func searchBarIsEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBarIsEmpty() {
            items2 = DataManager.sharedInstance.cachedItems
        }else{
            items2 = DataManager.sharedInstance.filter(searchText: searchText)
        }
        tableView.reloadData()
    }
    //
    //    func updateSearchResults(for searchController: UISearchController) {
    //        filterContentForSearchText(searchController.searchBar.text!)
    //    }
} //UIView.animate(withDuration: 2) {


    

