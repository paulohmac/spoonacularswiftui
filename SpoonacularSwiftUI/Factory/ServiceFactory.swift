//
//  ServiceFactory.swift
//  SpoonacularSwiftUI
//
//  Created by Paulo H.M. on 15/05/23.
//

import Foundation

protocol Factory {
    func getService()->SpoonacularService
}

class ServiceFactory : Factory{
    
    func getService() -> SpoonacularService {
        return SpoonacularHttpService()
    }
    
}

