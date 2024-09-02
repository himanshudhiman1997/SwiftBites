//
//  SwiftModels.swift
//  SwiftBites
//
//  Created by Himanshu Dhiman on 20/08/24.
//

import SwiftData
import Foundation

//defining model for Category
@Model final class Category: Identifiable, Hashable {
    let id: UUID
    
    //name should be unique
    @Attribute(.unique) var name: String
    
    //define relationship with Recipe
    @Relationship(deleteRule: .nullify) var recipes: [Recipe]
    //var recipes: [Recipe]
    
    init(id: UUID, name: String, recipes: [Recipe]) {
        self.id = id
        self.name = name
        self.recipes = recipes
    }
}

//defining model for Ingredient
@Model final class Ingredient: Identifiable, Hashable {
    let id: UUID
    @Attribute(.unique) var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}

//defining model for RecipeIngredient
@Model final class RecipeIngredient: Identifiable, Hashable {
    let id: UUID
    @Relationship var ingredient: Ingredient
    var quantity: String
    
    //define relationship with Recipe
    @Relationship(deleteRule: .cascade, inverse: \Recipe.ingredients) var recipe: Recipe?
    
    init(id: UUID, ingredient: Ingredient, quantity: String) {
        self.id = id
        self.ingredient = ingredient
        self.quantity = quantity
    }
}

//defining model for Recipe
@Model final class Recipe: Identifiable, Hashable {
    
    let id: UUID
    @Attribute(.unique) var name: String
    var summary: String
    var serving: Int
    var time: Int
    var instructions: String
    var imageData: Data?
    //var category: Category?
    @Relationship(deleteRule: .nullify, inverse: \Category.recipes) var category: Category?
    //var ingredients: [RecipeIngredient]
    @Relationship(deleteRule: .cascade) var ingredients: [RecipeIngredient]
    
    init(
        id: UUID,
        name: String,
        summary: String,
        serving: Int,
        time: Int,
        instructions: String,
        imageData: Data? = nil,
        category: Category? = nil,
        ingredients: [RecipeIngredient] = []
    ) {
        self.id = id
        self.name = name
        self.summary = summary
        self.serving = serving
        self.time = time
        self.instructions = instructions
        self.imageData = imageData
        self.category = category
        self.ingredients = ingredients
    }
}

