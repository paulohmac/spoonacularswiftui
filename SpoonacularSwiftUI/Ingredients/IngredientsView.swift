//
//  DetailView.swift
//  SpoonacularSwiftUI
//
//  Created by Paulo H.M. on 10/05/23.
//

import SwiftUI

struct IngredientsView: View {
    @ObservedObject var viewModel = IngredientsViewModel(factory: ServiceFactory())

    @State var idRecipe = 0

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Ingredients list" )
                List(viewModel.ingredients){ ingredient in
                    HStack{
                        AsyncImage(url: URL(string: "https://spoonacular.com/cdn/ingredients_100x100/" + (ingredient.image ?? "")))
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                        VStack{
                            Text(ingredient.name ?? ""  )
                                    .font(.headline)
                                    .padding()
                            HStack{
                                Text( String(ingredient.amount.metric?.value ?? 0.0) )
                                    .font(.body)
                                    .padding()
                                Text(ingredient.amount.metric?.unit ?? "" )
                                    .font(.body)
                                    .padding()
                            }
                        }
                    }
                }
            }
            .padding(22.0)
            .onAppear {
                self.loadData()
            }
        }
    }
    private func loadData(){
        if idRecipe != 0 {
            viewModel.listIngredients(idRecipe: String(idRecipe))
        }
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
    }
}
