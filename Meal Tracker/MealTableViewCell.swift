//
//  MealTableViewCell.swift
//  Meal Tracker
//
//  Created by Navan Hassan on 6/30/21.
//

import UIKit
// Navan Hassan NetID: naahassan ID: 112239763

class MealTableViewCell: UITableViewCell {
    
    /// Label showing the name of the meal.
    @IBOutlet weak var mealTitle: UILabel!
    
    /// Label showing the meal's calorie count.
    @IBOutlet weak var caloriesLbl: UILabel!
    
    /// Label showing the date in which the meal was consumed.
    @IBOutlet weak var dateLbl: UILabel!
    
    /// Image that reflects the category of the meal.
    @IBOutlet weak var categoryImg: UIImageView!
    
    /**
     Configures all the objects in the cell with the provided data.
     - Parameters:
        - title: The name of the meal.
        - category: The category the meal belongs to.
        - calories: The calorie count of the meal in kilocalories.
        - date: The date in which the meal was consumed.
     */
    public func configureCell(title: String, category: String, calories: Int64, date: String){
        mealTitle.text = title
        caloriesLbl.text = String(calories) + " kcal"
        dateLbl.text = date
        if (category == "Breakfast" || category == "breakfast"){
            categoryImg.image = UIImage(named: "breakfast")
        }
        else if (category == "Lunch" || category == "lunch"){
            categoryImg.image = UIImage(named: "lunch")
        }
        else if (category == "Dinner" || category == "dinner"){
            categoryImg.image = UIImage(named: "dinner")
        }
        else{
            categoryImg.image = UIImage(named: "snack")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
