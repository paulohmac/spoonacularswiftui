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
    func getRecipes() -> AnyPublisher<DataResponse<[Recipe], ServiceError>, Never>
}

struct SpoonacularHttpService : SpoonacularService{
    
    func getRecipes() -> AnyPublisher<DataResponse<[Recipe], ServiceError>, Never>  {
        let url = URL(string: ServiceConfiguration.searchUrl)!
        
        let parameters = generateRequestParameters()
        
        let headers = generateRequestHeaders()
        return sendRequest(url,
                           HTTPMethod.get,
                           headers,
                           parameters)
            .validate()
            .publishDecodable(type: [Recipe].self)
            .map { response in
                response.mapError { error in ServiceError( code: "", message: error.localizedDescription) }
            }.receive(on: DispatchQueue.main)
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
    
    func sendRequest(_ url :URL,_ method: HTTPMethod, _ headers : HTTPHeaders, _ parameters : [String : Any])-> DataRequest {
        return AF.request(url,
                          method: .get,
                          parameters: parameters,
                          headers: headers)
    }

    
}

struct ServiceConfiguration{
    public static let appClientKeyValue =  "336f4185e30f45dbb2ec56a2f36df171"
    public static let appClientKey =  "336f4185e30f45dbb2ec56a2f36df171"
    public static let headerKey =  "Accept"
    public static let headerValue =  "application/json"
    public static let searchUrl = "https://api.spoonacular.com/recipes/complexSearch"
}




