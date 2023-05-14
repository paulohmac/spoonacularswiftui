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
    let id = UUID().uuidString
    var name : String? = ""
    var image : String? = ""
    var amount : Amount

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case amount
    }
}

struct Amount : BaseCodable, Codable{
    let id = UUID().uuidString
    let metric : Metric?

    enum CodingKeys: String, CodingKey {
        case id
        case metric
    }
}

struct Metric : BaseCodable, Codable{
    let id = UUID().uuidString
    let value : Float?
    let unit : String?

    enum CodingKeys: String, CodingKey {
        case id
        case value
        case unit
    }
}
 
