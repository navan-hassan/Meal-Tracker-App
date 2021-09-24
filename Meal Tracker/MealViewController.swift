//
//  MealViewController.swift
//  Meal Tracker
//
//  Created by Navan Hassan on 7/1/21.
//

import UIKit
// Navan Hassan NetID: naahassan ID: 112239763
class MealViewController: UIViewController {
    
    /// Label showing the name of the meal.
    @IBOutlet weak var nameLbl: UILabel!
    
    /// Label showing the category of the meal.
    @IBOutlet weak var categoryLbl: UILabel!
    
    /// ImageView that contains an image reflecting the meal category.
    @IBOutlet weak var categoryImg: UIImageView!
    
    /// Label showing the calorie count of the meal.
    @IBOutlet weak var caloriesLbl: UILabel!
    
    /// Label showing protein amount of the meal.
    @IBOutlet weak var proteinLbl: UILabel!
    
    /// Label showing fat amount of the meal.
    @IBOutlet weak var fatLbl: UILabel!
    
    /// Label showing the carbs amount of the meal.
    @IBOutlet weak var carbsLbl: UILabel!
    
    /// Label showing the date in which the meal was consumed.
    @IBOutlet weak var dateLbl: UILabel!
    
    
    /// Name of the meal.
    var mealName: String!
    
    /// Category the meal belongs to.
    var category: String!
    
    /// Calorie amount of the meal in kilocalories.
    var calories: Int64!
    
    /// The amount of protein in grams.
    var protein: Double!
    
    /// The amount of fat in grams.
    var fat: Double!
    
    /// The amount of carbohydrates in grams.
    var carbs: Double!
    
    /// The date in which the meal was consumed.
    var date: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = mealName ?? ""
        nameLbl.text = "Meal name: " + (mealName ?? "")
        categoryLbl.text = "Category: " + (category.capitalized ?? "")
        caloriesLbl.text = "Total Calories: " + String(calories) + " kcal"
        proteinLbl.text = "Protein: " + String(protein) + "g"
        fatLbl.text = "Fat: " + String(fat) + "g"
        carbsLbl.text = "Carbs: " + String(carbs) + "g"
        dateLbl.text = "Date: " + (date ?? "")
        categoryImg.image = UIImage(named: category?.lowercased() ?? "snack")
 
    }
    
}
