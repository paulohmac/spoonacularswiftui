//
//  SpoonacularService.swift
//  SpoonacularSwiftUI
//
//  Created by Paulo H.M. on 05/05/23.
//

import Foundation
import Combine
import Alamofire


protocol SpoonacularService{
    
    func getRecipes(ingredients : String) -> AnyPublisher<[Recipe]?, AFError>

    func getIngredients(id : String) -> AnyPublisher<Ingredients?, AFError>
    
}


struct SpoonacularHttpService : SpoonacularService{
    
    func getIngredients(id: String) -> AnyPublisher<Ingredients?, Alamofire.AFError> {
        let url = URL(string: String(format:ServiceConfiguration.ingredientsUrl, id))!
        
        var parameters = generateRequestParameters()
        let headers = generateRequestHeaders()
        return sendRequest(url,
                           HTTPMethod.get,
                           headers,
                           &parameters)
        .validate()
        .publishDecodable(type: Ingredients?.self)
        .value()
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    
    func getRecipes(ingredients : String) -> AnyPublisher<[Recipe]?, AFError>  {
        let url = URL(string: ServiceConfiguration.searchUrl)!
        
        var parameters = generateRequestParameters()
        parameters[ServiceConfiguration.ingredientParamKey] = ingredients
        parameters[ServiceConfiguration.ItemsParamKey] = ServiceConfiguration.ItemsParamValue
        let headers = generateRequestHeaders()
        return sendRequest(url,
                           HTTPMethod.get,
                           headers,
                           &parameters)
        .validate()
        .publishDecodable(type: [Recipe]?.self)
        .value()
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
}

extension SpoonacularService {

    func generateRequestParameters()-> [String : Any]{
        
        let defaultParameters = [
            ServiceConfiguration.appClientKey: ServiceConfiguration.appClientKeyValue]

        return defaultParameters
    }

    func generateRequestHeaders()-> HTTPHeaders{
        
        let headers: HTTPHeaders = [
            ServiceConfiguration.headerKey: ServiceConfiguration.headerValue
        ]
        return headers
    }
    
    func sendRequest(_ url :URL,_ method: HTTPMethod, _ headers : HTTPHeaders, _ parameters :inout [String : Any])-> DataRequest {
        parameters[ServiceConfiguration.appClientKey] = ServiceConfiguration.appClientKeyValue
        return AF.request(url,
                          method: .get,
                          parameters: parameters,
                          headers: headers)
    }

}

struct ServiceConfiguration{
    public static let appClientKeyValue =  "336f4185e30f45dbb2ec56a2f36df171"
    public static let appClientKey =  "apiKey"
    public static let headerKey =  "Accept"
    public static let headerValue =  "application/json"
    public static let searchUrl = "https://api.spoonacular.com/recipes/findByIngredients/"
    public static let ingredientsUrl = "https://api.spoonacular.com/recipes/%@/ingredientWidget.json"
    public static let ingredientParamKey = "ingredients"
    public static let ItemsParamKey = "number"
    public static let ItemsParamValue = "5"
}




