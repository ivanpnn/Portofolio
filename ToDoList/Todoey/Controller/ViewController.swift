//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class ViewController: SwipeTableViewController {
    
    var toDoList: Results<Item>?
    
    var realm = try! Realm()
    @IBOutlet var searchBar: UISearchBar!
    
    var selectedCategory: Category? {
        didSet {
            loadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let colourHex = selectedCategory?.colorHex {
            title = selectedCategory!.name
            guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")
            }
            if let navBarColour = UIColor(hexString: colourHex) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = navBarColour
                appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColour, returnFlat: true)]
                navBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
                navBar.standardAppearance = appearance
                navBar.scrollEdgeAppearance = appearance
                
                searchBar.backgroundImage = UIImage()
                searchBar.backgroundColor = navBarColour
                let searchField: UITextField =  searchBar.value(forKey: "searchField") as! UITextField
                searchField.backgroundColor = UIColor.white
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let toDoItem = toDoList?[indexPath.row] {
            cell.textLabel?.text = toDoItem.title
            cell.accessoryType = toDoItem.state ? .checkmark : .none
            
            if let cellColor = UIColor.init(hexString: selectedCategory!.colorHex)?.darken(byPercentage: CGFloat(indexPath.row)/CGFloat(toDoList!.count)) {
                cell.backgroundColor = cellColor
                cell.textLabel?.textColor = ContrastColorOf(cellColor, returnFlat: true)
            }
        } else {
            cell.textLabel?.text = "No Item"
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = toDoList?[indexPath.row] {
            do {
                try realm.write({
                    item.state = !item.state
                })
            } catch {
                print(error)
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alertController = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        let addItemAction = UIAlertAction(title: "Add", style: .default) { (addAction) in
            if let textFieldContent = textField.text {
                if (textFieldContent != "") {
                    if let currentCategory = self.selectedCategory {
                        do {
                            try self.realm.write {
                                let newItem = Item()
                                newItem.title = textFieldContent
                                newItem.dateCreated = Double(NSDate().timeIntervalSince1970)
                                currentCategory.items.append(newItem)
                            }
                        } catch {
                            print(error)
                        }
                    }
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
    
    func loadData() {
        toDoList = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    }
    
    override func updateData(at indexPath: IndexPath) {
        if let item = toDoList?[indexPath.row] {
            do {
                try realm.write({
                    realm.delete(item)
                })
            } catch {
                print(error)
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        toDoList = toDoList?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)

        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text?.count == 0) {
            loadData()
            tableView.reloadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

