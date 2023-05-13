//
//  Ingredients.swift
//  SpoonacularSwiftUI
//
//  Created by Paulo H.M. on 12/05/23.
//

//{"ingredients":[{"name":"espresso","image":"espresso.jpg","amount":{"metric":{"value":236.0,"unit":"ml"},"us":{"value":1.0,"unit":"cup"}}},
import Foundation

struct Ingredients : BaseCodable, Codable{
    var id: Int?
    let ingredients : [Ingredient]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case ingredients
    }
}
struct Ingredient : BaseCodable, Codable{
    let id : Int?
    let name : String?
    let image : String?
    let amount : String?
    let metric : Metric?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case amount
        case metric
    }
}
struct Metric : BaseCodable, Codable{
    let id : Int?
    let value : String?
    let unit : String?

    enum CodingKeys: String, CodingKey {
        case id
        case value
        case unit
    }
}
