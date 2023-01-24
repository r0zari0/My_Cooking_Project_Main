//
//  IngredientCD+CoreDataProperties.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/16/23.
//
//

import Foundation
import CoreData


extension IngredientCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IngredientCD> {
        return NSFetchRequest<IngredientCD>(entityName: "IngredientCD")
    }

    @NSManaged public var image: String?
    @NSManaged public var text: String?
    @NSManaged public var ingredientCD: NSSet?

}

// MARK: Generated accessors for ingredientCD
extension IngredientCD {

    @objc(addIngredientCDObject:)
    @NSManaged public func addToIngredientCD(_ value: LikedFoodCD)

    @objc(removeIngredientCDObject:)
    @NSManaged public func removeFromIngredientCD(_ value: LikedFoodCD)

    @objc(addIngredientCD:)
    @NSManaged public func addToIngredientCD(_ values: NSSet)

    @objc(removeIngredientCD:)
    @NSManaged public func removeFromIngredientCD(_ values: NSSet)

}

extension IngredientCD : Identifiable {

}
