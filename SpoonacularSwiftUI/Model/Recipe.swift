//
//  Recipe.swift
//  SpoonacularSwiftUI
//
//  Created by Paulo H.M. on 06/05/23.
//

import UIKit

struct Recipe: BaseCodable{
    let id : Int?
    let title : String?
    let image : String?
    let extendedIngredients : [ExtendedIngredients]
    
    struct ExtendedIngredients : Codable {
        let aisle : String?
        let amount : Float?
        let image : String?
        let name : String?
        let unit : String?
    }
}

protocol BaseCodable: Codable, Identifiable {
    
}


