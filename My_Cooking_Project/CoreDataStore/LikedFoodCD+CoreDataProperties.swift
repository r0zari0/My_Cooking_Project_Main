//
//  LikedFoodCD+CoreDataProperties.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/26/23.
//
//

import Foundation
import CoreData


extension LikedFoodCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedFoodCD> {
        return NSFetchRequest<LikedFoodCD>(entityName: "LikedFoodCD")
    }

    @NSManaged public var calories: Double
    @NSManaged public var recipeAuthor: String?
    @NSManaged public var recipeImage: String?
    @NSManaged public var recipeName: String?
    @NSManaged public var totalTime: Double
    @NSManaged public var totalWeight: Double
    @NSManaged public var url: String?
    @NSManaged public var likedIngredient: NSSet?

}

// MARK: Generated accessors for likedIngredient
extension LikedFoodCD {

    @objc(addLikedIngredientObject:)
    @NSManaged public func addToLikedIngredient(_ value: IngredientCD)

    @objc(removeLikedIngredientObject:)
    @NSManaged public func removeFromLikedIngredient(_ value: IngredientCD)

    @objc(addLikedIngredient:)
    @NSManaged public func addToLikedIngredient(_ values: NSSet)

    @objc(removeLikedIngredient:)
    @NSManaged public func removeFromLikedIngredient(_ values: NSSet)

}

extension LikedFoodCD : Identifiable {

}
