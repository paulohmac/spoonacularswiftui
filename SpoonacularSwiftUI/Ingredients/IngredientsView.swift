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
            ZStack {
                           Color.green
                               .opacity(0.1)
                               .ignoresSafeArea()
                           
                           VStack {
                               Rectangle()
                                   .fill(Color.clear)
                                   .frame(height: 2)
                                   .background(LinearGradient(colors: [.green.opacity(0.3), .blue.opacity(0.5)],
                                                              startPoint: .topLeading, endPoint: .bottomTrailing)
                                   )
                               
                               Text(NSLocalizedString("Have the style touching the safe area edge.", comment: ""))
                                   .padding()
                               Spacer()
                           }
                           .navigationTitle(NSLocalizedString("Nav Bar Background", comment: ""))
                           .font(.title2)
                       }

            
            VStack(alignment: .leading) {
                Text(NSLocalizedString("Ingredients list", comment: "") )
                    .padding()
                List(viewModel.ingredients){ ingredient in
/*                        AsyncImage(url: URL(string: "https://spoonacular.com/cdn/ingredients_100x100/" + (ingredient.image ?? "")))
                            .frame(width: 25, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 2))
                            .frame(maxWidth: .infinity, alignment: .center)*/

                        HStack{
                            Text(ingredient.name ?? ""  )
                                .foregroundColor(Color(hex: 0x42A752))
                                .bold()
                                .font(.system(size: 16))
                                .padding()
                            Text( String(ingredient.amount.metric?.value ?? 0.0) )
                                .foregroundColor(Color(hex: 0x262931))
                                .font(.system(size: 12))
                                .padding()
                            Text(ingredient.amount.metric?.unit ?? "" )
                                .foregroundColor(Color(hex: 0x262931))
                                .font(.system(size: 12))
                                .padding()
                        }
                }
                .listStyle(GroupedListStyle())
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .frame(width: UIScreen.main.bounds.width)
                .background(Color(hex: 0xf2f2f2))

            }
            .padding(22.0)
            .onAppear {
                self.loadData()
            }
        }
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
