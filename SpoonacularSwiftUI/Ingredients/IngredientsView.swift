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
    @State var recipeTitle = ""

    var body: some View {
            VStack(alignment: .leading) {
                Text(NSLocalizedString("Ingredients", comment: "") )
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Color(hex: 0x262931))
                    .font(.custom("ArgentumSans-Regular",size: 20))
                    .bold()
                    .padding()
                List {
                    ForEach(viewModel.ingredients.indices, id: \.self) { index in
                        HStack {
                            Text( viewModel.ingredients[index].name ?? "")
                                .foregroundColor(Color(hex: 0x42A752))
                                .bold()
                                .font(.custom("ArgentumSans-Regular",size: 16))
                            Spacer()
                            Text( String(viewModel.ingredients[index].amount.metric?.value ?? 0.0) + " " + (viewModel.ingredients[index].amount.metric?.unit ?? "") ?? "")
                                .foregroundColor(Color(hex: 0x262931))
                                .bold()
                                .font(.custom("ArgentumSans-Regular",size: 14))
                            
                        }
                        .padding()
                        .background(Color.white)
                    }
                }
                .listStyle(PlainListStyle())
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .frame(width: UIScreen.main.bounds.width)
                .background(Color(hex: 0xffffff))
                
                
            }
            .background(Color(hex: 0xffffff))
            .onAppear {
                self.loadData()
            }
        .navigationTitle(recipeTitle)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(
            Color(hex: 0x42A752),
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .background(Color(hex: 0xffffff))

    }
    private func loadData(){
        if idRecipe != 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                viewModel.listIngredients(idRecipe: String(idRecipe))
            }
        }
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
    }
}
