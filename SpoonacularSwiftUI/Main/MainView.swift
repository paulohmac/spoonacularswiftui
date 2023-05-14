//
//  MainView.swift
//  SpoonacularSwiftUI
//
//  Created by Paulo H.M. on 07/05/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainSpoonacularViewModel()
    
    var body: some View {
        if viewModel.isLoading{
            ProgressView()
                .padding(10)
        }
        
        NavigationView {
            VStack(alignment: .leading) {
                TextField("Enter the ingredient", text: $viewModel.textSearch  )
                List(viewModel.recipeList){ recipe in
                    VStack{
                        NavigationLink(destination: IngredientsView(idRecipe: recipe.id ?? 0)) {
                            VStack{
                                AsyncImage(url: URL(string: recipe.image ?? ""))
                                    .frame(width: 200, height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                Text(recipe.title ?? ""  )
                                    .font(.headline)
                                    .padding()
                            }
                        }
                    }
                }
            }.padding(22.0)
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}



