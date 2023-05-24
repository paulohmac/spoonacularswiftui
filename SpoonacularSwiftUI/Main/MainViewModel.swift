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

        if (isLoading == true){
            return
        }

        self.showingAlert = false
        isLoading = true
        sendRequest(ingredients: ingredients)
    }
    
    private func sendRequest(ingredients : String){
        service?.getRecipes(ingredients: ingredients)
            .sink { completion in
                self.isLoading = false

                switch completion {
                case .failure(let error):
                    print("%%%\(error) " )
                    if let code = error.responseCode {
                        print(code)
                        self.showMessage(message:  error.localizedDescription)
                    }else  if error.isSessionTaskError || error.isResponseSerializationError {
                        self.showMessage(message: error.localizedDescription)
                    }
                case .finished:
                    break
                }

            } receiveValue: {[weak self] value in
                self?.showingAlert = false
                guard let self = self else { return }
                
                if let recipes = value{
                    self.recipeList.removeAll()
                    self.recipeList  = recipes
                }
                self.isLoading = false
            }
            .store(in: &cancellableSet)
    }

    private func showMessage(message :  String){
        self.alertMessag = message
        self.showingAlert = true
    }
    
    
    
}
