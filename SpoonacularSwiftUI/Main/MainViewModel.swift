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
        willSet(value){
            if value != "" && value.count > 5 {
                getFindRecipes(ingredients: value)
            }
        }
    }
    
    @Published var showingAlert = false
    
    @Published var alertMessag = ""


    private var cancellableSet: Set<AnyCancellable> = []

    private var service : SpoonacularService?
    
    init(factory : Factory) {
        self.service = factory.getService()
    }

    public func getFindRecipes(ingredients : String){
        service?.getRecipes(ingredients: ingredients)
            .sink { completion in
                
                switch completion {
                case .failure(let error):
                    print(error)
                    self.alertMessag = error.localizedDescription
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
                self.showingAlert = true
                
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
