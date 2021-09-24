//
//  FilteredViewController.swift
//  Meal Tracker
//
//  Created by Navan Hassan on 7/1/21.
//
// Navan Hassan NetID: naahassan ID: 112239763

import UIKit
import CoreData
class FilteredViewController: UIViewController {
    
    /// Category of meals that will be shown in the TableView.
    var filter: String!
    
    /// String determining how the meals will be sorted.
    var sortBy = "Date"
    
    /// Sorts the array of Meal objects used by the TableView based on the string contained by sortBy variable.
    func sortMeals(){
        let setting = sortBy
        if (setting == "Name"){
            meals.sort(by: {$0.title! < $1.title!})
        }
        else if(setting == "Calories"){
            meals.sort(by: {$0.calories > $1.calories})
        }
        else if(setting == "Date"){
            meals.sort(by: {$0.dateObject! > $1.dateObject!})
        }
        else if(setting == "Protein"){
            meals.sort(by: {$0.protein > $1.protein})
        }
        else if (setting == "Fat"){
            meals.sort(by: {$0.fat > $1.fat})
        }
        else if (setting == "Carbs"){
            meals.sort(by: {$0.carbs > $1.carbs})
        }
        else{
            meals.sort(by: {$0.title! < $1.title!})
        }
    }

    /// TableVIew of the meals pertaining to the desired category.
    @IBOutlet weak var tableView: UITableView!
    
    /// Array of Meal objects from Core Data. The contents of this array will be displayed in the TableView.
    var meals = [Meal]()
    
    /// Allows for the retrieval of objects stored in Core Data.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
        observer = NotificationCenter.default.addObserver(forName: Notification.Name("sortBy"), object: nil, queue: .main, using: { notification in
            guard let object = notification.object as? String else{
                return
            }
            self.sortBy = object
        })
        fetchMeals()
        if(meals.count > 0){
            sortMeals()
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    /// Observer that receives a notification from the settings page.
    var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = filter
        let nib = UINib(nibName: "MealTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "mealCell")
        tableView.delegate = self
        tableView.dataSource = self
        observer = NotificationCenter.default.addObserver(forName: Notification.Name("sortBy"), object: nil, queue: .main, using: { notification in
            guard let object = notification.object as? String else{
                return
            }
            self.sortBy = object
        })
        fetchMeals()
        if (meals.count > 0){
            sortMeals()
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    /**
     Function that runs when the '+' button in navigation bar is tapped. It will present an alarm with several text fields. The text
     in those text fields will be used to create a new Meal object.
     */
    @objc func addButtonTapped(){
        let alert = UIAlertController(title: "Create new " + (filter ?? "").lowercased() + " item" , message: "Enter required data", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        let titleField = alert.textFields![0]
        let caloriesField = alert.textFields![1]
        let proteinField = alert.textFields![2]
        let fatField = alert.textFields![3]
        let carbsField = alert.textFields![4]
        let dateField = alert.textFields![5]
        titleField.placeholder = "Meal name"
        caloriesField.placeholder = "Calories"
        proteinField.placeholder = "Protein"
        fatField.placeholder = "Fat"
        carbsField.placeholder = "Carbs"
        dateField.placeholder = "Date (mm/dd/yyyy)"
        let createButton = UIAlertAction(title: "Add Meal", style: .default){(action) in
            self.createMeal(title: titleField.text ?? "", calories: Int64(caloriesField.text ?? "") ?? 0, protein: Double(proteinField.text ?? "") ?? 0.0, fat: Double(fatField.text ?? "") ?? 0.0, carbs: Double(carbsField.text ?? "") ?? 0.0, date: dateField.text ?? "1/1/1970")
        }
        alert.addAction(createButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Populates meals array with Meal objects stored in Core Data.
    func fetchMeals(){
        do{
            let fetchRequest = Meal.fetchRequest() as NSFetchRequest<Meal>
            fetchRequest.predicate = NSPredicate(format: "category == %@", (filter ?? ""))
            meals = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{}
    }
    
    /**
     Creates a Meal object and saves it in Core Data.
     - Parameters:
        - title: The name of the meal.
        - category: The category of the meal (Breakfast/Lunch/Dinner/Snack).
        - calories: The amount of kilocalories in the meal.
        - protein: The amount of protein in grams.
        - fat: The amount of fat in grams.
        - carbs: The amount of carbohydrates in grams.
        - date: The date the meal was consumed (dd/mm/yyyy).
     */
    func createMeal(title: String, calories: Int64, protein: Double, fat: Double, carbs: Double, date: String){
        let newMeal = Meal(context: context)
        newMeal.title = title
        newMeal.category = filter ?? "Snack"
        newMeal.calories = calories
        newMeal.protein = protein
        newMeal.fat = fat
        newMeal.carbs = carbs
        if(date == ""){
            newMeal.date = "01/01/1970"
            newMeal.dateObject = MealTableViewController.dateFormatter.date(from: "01/01/1970")
        }
        else{
            newMeal.date = date
            newMeal.dateObject = MealTableViewController.dateFormatter.date(from: date)
            if(newMeal.dateObject == nil){
                newMeal.date = "01/01/1970"
                newMeal.dateObject = MealTableViewController.dateFormatter.date(from: "01/01/1970")
            }
        }
        do{
            try context.save()
            fetchMeals()
            sortMeals()
        }
        catch{}
    }
    
    /**
     Detetes a meal from Core Data and refreshes the meals array.
     - Parameters:
        - meal: The meal to be deleted from Core Data.
     */
    func deleteMeal(meal: Meal){
            context.delete(meal)
            do{
                try context.save()
                fetchMeals()
            }
            catch{}
    }
}

extension FilteredViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    // MARK: - Table view data source
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let current = meals[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as! MealTableViewCell
        cell.configureCell(title: current.title ?? "Meal", category: current.category ?? "", calories: current.calories, date: current.date ?? "1/1/1970")
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let current = meals[indexPath.row]
        if  let vc = storyboard?.instantiateViewController(identifier: "mealViewController") as? MealViewController{
            vc.mealName = current.title
            vc.category = current.category
            vc.calories = current.calories
            vc.protein = current.protein
            vc.fat = current.fat
            vc.carbs = current.carbs
            vc.date = current.date
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let current = meals[indexPath.row]
        if (editingStyle == .delete){
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            deleteMeal(meal: current)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}
