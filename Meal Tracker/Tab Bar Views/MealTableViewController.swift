//
//  MealTableViewController.swift
//  Meal Tracker
//
//  Created by Navan Hassan on 6/30/21.
//
// Navan Hassan NetID: naahassan ID: 112239763

import UIKit

class MealTableViewController: UIViewController{
    /// The order in which the meals should be sorted.
    var sortBy = "Date"
    
    /// DateFormatter object that is used to create a Date object from a String.
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    /**
     Sorts the array of Meal objects used by the TableView based on the string contained by sortBy variable.
     */
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
            meals.sort(by: {$0.category! < $1.category!})
        }
    }
    
    /// Allows for the retrieval of objects stored in Core Data.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    /// TableView displaying all the meals stored in Core Data.
    @IBOutlet weak var mealTableView: UITableView!
    
    /// Array of Meal objects from Core Data. The contents of this array will be displayed in the TableView.
    var meals = [Meal]()
    
    override func viewWillAppear(_ animated: Bool) {
        fetchMeals()
        if(meals.count > 0){
            sortMeals()
        }
        DispatchQueue.main.async {
            self.mealTableView.reloadData()
        }
    }
    /// Observer that receives a notification from the settings page.
    var observer: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "All Meals"
        let nib = UINib(nibName: "MealTableViewCell", bundle: nil)
        mealTableView.register(nib, forCellReuseIdentifier: "mealCell")
        mealTableView.delegate = self
        mealTableView.dataSource = self
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
        let alert = UIAlertController(title: "Create new meal", message: "Enter required data", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        let titleField = alert.textFields![0]
        let categoryField = alert.textFields![1]
        let caloriesField = alert.textFields![2]
        let proteinField = alert.textFields![3]
        let fatField = alert.textFields![4]
        let carbsField = alert.textFields![5]
        let dateField = alert.textFields![6]
        titleField.placeholder = "Meal name"
        categoryField.placeholder = "Meal category"
        caloriesField.placeholder = "Calories"
        proteinField.placeholder = "Protein"
        fatField.placeholder = "Fat"
        carbsField.placeholder = "Carbs"
        dateField.placeholder = "Date (mm/dd/yyyy)"
        let createButton = UIAlertAction(title: "Add Meal", style: .default){(action) in
            
            self.createMeal(title: titleField.text ?? "", category: categoryField.text?.capitalized ?? "Lunch", calories: Int64(caloriesField.text ?? "") ?? 0, protein: Double(proteinField.text ?? "") ?? 0.0, fat: Double(fatField.text ?? "") ?? 0.0, carbs: Double(carbsField.text ?? "") ?? 0.0, date: dateField.text ?? "01/01/1970")
        }
        alert.addAction(createButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     Populates meals array with Meal objects stored in Core Data.
     */
    func fetchMeals(){
        do{
            meals = try context.fetch(Meal.fetchRequest())
            DispatchQueue.main.async {
                self.mealTableView.reloadData()
            }
        }
        catch{
            
        }
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
    func createMeal(title: String, category: String, calories: Int64, protein: Double, fat: Double, carbs: Double, date: String){
        let newMeal = Meal(context: context)
        newMeal.title = title
        newMeal.category = category
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


extension MealTableViewController: UITableViewDelegate,UITableViewDataSource{
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let current = meals[indexPath.row]
        let cell = mealTableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as! MealTableViewCell
        cell.configureCell(title: current.title ?? "Meal", category: current.category ?? "", calories: current.calories ?? 0, date: current.date ?? "01/01/1970")
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
            mealTableView.beginUpdates()
            mealTableView.deleteRows(at: [indexPath], with: .fade)
            deleteMeal(meal: current)
            mealTableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
}
