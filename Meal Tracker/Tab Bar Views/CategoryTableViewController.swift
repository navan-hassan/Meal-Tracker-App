//
//  CategoryTableViewController.swift
//  Meal Tracker
//
//  Created by Navan Hassan on 6/30/21.
//
// Navan Hassan NetID: naahassan ID: 112239763

import UIKit

class CategoryTableViewController: UITableViewController {
    
    /// The category in which the meals will be sorted. This array is then passed to the View Controller that is
    /// opened when tapping on a cell.
    var sortBy = "Date"
    
    /// Array of meal categories that is presented in the TableView.
    let categories = ["breakfast", "lunch", "dinner", "snack"]
    
    /// Observer that receives notifications from the settings page.
    var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Categories"
        observer = NotificationCenter.default.addObserver(forName: Notification.Name("sortBy"), object: nil, queue: .main, using: { notification in
            guard let object = notification.object as? String else{
                return
            }
            self.sortBy = object
        })

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let current = categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.imageView?.image = UIImage(named: current)
        cell.textLabel?.text = current.capitalized

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let current = categories[indexPath.row]
        if let vc = storyboard?.instantiateViewController(identifier: "filteredTableViewController") as? FilteredViewController{
            vc.filter = current.capitalized
            vc.sortBy = self.sortBy
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
