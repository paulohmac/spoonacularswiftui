//
//  MainViewModel.swift
//  SpoonacularSwiftUI
//
//  Created by Paulo H.M. on 07/05/23.
//

import Foundation
import Combine

protocol MainViewModel{
    
}


class MainSpoonacularViewModel : MainViewModel, ObservableObject{
    
    @Published var recipeList =  [Recipe]()
    
    private var cancellableSet: Set<AnyCancellable> = []

    @Published var isLoading =  false

    @Published var textSearch : String = "" {
        didSet(value){
            if value != "" {
                getFindRecipes(ingredients: value)
            }
        }
    }
    
    var service: SpoonacularService
    
    init() {
        self.service = SpoonacularHttpService()
    }
    
    public func getFindRecipes(ingredients : String){
        service.getRecipes(ingredients: ingredients)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    // self.createAlert(with: dataResponse.error!)
                    print(dataResponse.error?.message)
                } else {
                    if let list = dataResponse.value {
                        self.recipeList = list
                    }
                }
            }.store(in: &cancellableSet)
    }
    
}
