//
//  Ingredients.swift
//  SpoonacularSwiftUI
//
//  Created by Paulo H.M. on 12/05/23.
//

//{"ingredients":[{"name":"espresso","image":"espresso.jpg","amount":{"metric":{"value":236.0,"unit":"ml"},"us":{"value":1.0,"unit":"cup"}}},
import Foundation

public struct Ingredients : BaseCodable, Codable{
    public var id: Int?
    public let ingredients : [Ingredient]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case ingredients
    }
}
public struct Ingredient : BaseCodable, Codable{
    public let id = UUID().uuidString
    public var name : String? = ""
    public var image : String? = ""
    public var amount : Amount

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case amount
    }
}

public struct Amount : BaseCodable, Codable{
    public let id = UUID().uuidString
    public let metric : Metric?

    enum CodingKeys: String, CodingKey {
        case id
        case metric
    }
}

public struct Metric : BaseCodable, Codable{
    public let id = UUID().uuidString
    public let value : Float?
    public let unit : String?

    enum CodingKeys: String, CodingKey {
        case id
        case value
        case unit
    }
}
 
