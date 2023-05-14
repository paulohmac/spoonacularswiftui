//
//  MainViewModel.swift
//  SpoonacularSwiftUI
//
//  Created by Paulo H.M. on 07/05/23.
//

import Foundation
import Combine

protocol MainViewModel{

    func getFindRecipes(ingredients : String)
    
    var recipeList :  [Recipe] {get set}

    var isLoading : Bool {get set}

    var textSearch : String {get set}
    
}

class MainSpoonacularViewModel : MainViewModel, ObservableObject{
    
    @Published var recipeList =  [Recipe]()

    @Published var isLoading =  false

    @Published var textSearch : String = "" {
        didSet(value){
            if value != "", value.count > 5 {
                getFindRecipes(ingredients: value)
            }
        }
    }

    private var cancellableSet: Set<AnyCancellable> = []

    private var service: SpoonacularService
    
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
                
                if let recipes = value{
                    self.recipeList.removeAll()
                    self.recipeList  = recipes
                }
            }
            .store(in: &cancellableSet)
    }
    
}
