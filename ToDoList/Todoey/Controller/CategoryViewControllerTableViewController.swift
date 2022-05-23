//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by Macbook on 03/01/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class CategoryViewControllerTableViewController: SwipeTableViewController {
    var categoryList: Results<Category>?
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")
        }
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(hexString: "#1D9BF6")
        appearance.largeTitleTextAttributes =  [NSAttributedString.Key.foregroundColor : UIColor.white]
        navBar.standardAppearance = appearance
        navBar.scrollEdgeAppearance = appearance
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        let categoryItem = categoryList?[indexPath.row].name ?? "No Category"
        cell.textLabel?.text = categoryItem
        
        let categoryColor = categoryList?[indexPath.row].colorHex ?? "#FFFFFF"
        cell.backgroundColor = UIColor.init(hexString: categoryColor)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToItemList", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            vc.selectedCategory = categoryList?[indexPath.row]
        }
    }

    func loadData() {
        categoryList = realm.objects(Category.self)
    }
    
    func saveData(with category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(error)
        }
    }
    
    override func updateData(at indexPath: IndexPath) {
        if let categoryToDelete = self.categoryList?[indexPath.row] {
            do {
                try self.realm.write({
                    self.realm.delete(categoryToDelete)
                })
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alertController = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        let addItemAction = UIAlertAction(title: "Add", style: .default) { (addAction) in
            if let textFieldContent = textField.text {
                if (textFieldContent != "") {
                    let newCategory = Category()
                    newCategory.name = textFieldContent
                    
                    let colorHexValue = UIColor.randomFlat().hexValue()
                    newCategory.colorHex = colorHexValue
                    
                    self.saveData(with: newCategory)
                }
            } else {
                print("error")
            }
            self.tableView.reloadData()
        }
        
        alertController.addAction(addItemAction)
        
        alertController.addTextField { (alertTextField) in
            textField = alertTextField
            textField.placeholder = "Add new item"
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
}
