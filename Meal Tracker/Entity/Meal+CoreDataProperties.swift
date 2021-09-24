//
//  Meal+CoreDataProperties.swift
//  Meal Tracker
//
//  Created by Navan Hassan on 7/1/21.
//
//
// Navan Hassan NetID: naahassan ID: 112239763

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }
    
    @NSManaged public var calories: Int64
    @NSManaged public var carbs: Double
    @NSManaged public var category: String?
    @NSManaged public var date: String?
    @NSManaged public var fat: Double
    @NSManaged public var protein: Double
    @NSManaged public var title: String?
    @NSManaged public var dateObject: Date?

}

extension Meal : Identifiable {

}
