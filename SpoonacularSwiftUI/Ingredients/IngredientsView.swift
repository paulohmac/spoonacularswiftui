//
//  DetailView.swift
//  SpoonacularSwiftUI
//
//  Created by Paulo H.M. on 10/05/23.
//

import SwiftUI

struct IngredientsView: View {
    @ObservedObject var viewModel = IngredientsViewModel()

    @State var idRecipe = 0 {
        didSet(value){
            if value != 0 {
                viewModel.listIngredients(idRecipe: String(value))
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Ingredients list" )
                List(viewModel.ingredients){ ingredient in
                    VStack{
                            Text(ingredient.name ?? ""  )
                                .font(.headline)
                                .padding()
                            Text(ingredient.amount ?? "" )
                                .font(.body)
                                .padding()
                        Text( (ingredient.metric?.value ?? "" + (ingredient.metric?.unit ?? "") ?? "") )
                                .font(.body)
                                .padding()
                    }
                }
            }.padding(22.0)
        }.onAppear {
        }    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
    }
}
