//
//  DetailViewModel.swift
//  SpoonacularSwiftUI
//
//  Created by Paulo H.M. on 10/05/23.
//

import Foundation
import Combine


class IngredientsViewModel : ObservableObject{
    
    @Published var ingredients =  [Ingredient]()
    
    private var cancellableSet: Set<AnyCancellable> = []

    @Published var isLoading =  false

    var service: SpoonacularService
    
    init() {
        self.service = SpoonacularHttpService()
    }
    
    public func listIngredients(idRecipe : String){
        service.getIngredients(id: idRecipe)
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
                
                if let recipes = value {
                    self.ingredients  = recipes.ingredients ?? [Ingredient]()
                }
            }
            .store(in: &cancellableSet)
    }
}

