//
//  File.swift
//  
//
//  Created by Daniel Mandea on 15/07/2020.
//

import Foundation
import Fluent
import Vapor

final class Smoothie: Model, Content {
    
    static let schema = "smoothie"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "ingredinets")
    var ingredients: String
   
    @Field(key: "calories")
    var calories: String
    
    internal init(id: UUID? = nil, title: String, description: String, ingredients: String, calories: String) {
        self.id = id
        self.title = title
        self.description = description
        self.ingredients = ingredients
        self.calories = calories
    }
    
    init() { }
}
