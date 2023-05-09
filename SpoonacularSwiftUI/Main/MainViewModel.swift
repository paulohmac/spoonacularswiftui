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
            if value != "", value.count > 5 {
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
            .sink { completion in

                switch completion {
                                case .failure(let error):
                                    print(error)
                                    
                                    if let code = error.responseCode {
                                        print(code)
                                    }
                                    if error.isSessionTaskError {
                                        print(".noInternet")
                                    }
                                    if error.isResponseSerializationError {
                                        print(".decoding")
                                    }
                                case .finished:
                                    break
                                }


            } receiveValue: {[weak self] value in
                guard let self = self else { return }
                
                if let recipes = value?.recipes{
                    self.recipeList  = recipes
                }
            }
            .store(in: &cancellableSet)
    }
    
}
