//
//  MainView.swift
//  SpoonacularSwiftUI
//
//  Created by Paulo H.M. on 07/05/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainSpoonacularViewModel(factory: ServiceFactory())
    
    
    
    var body: some View {
        if viewModel.isLoading{
            ProgressView()
                .padding(10)
        }
        NavigationView {
            VStack(alignment: .leading) {
                
                ZStack{
                    Image("vegetal")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: 300)
                        .clipped()
                        VStack{
                            Text(NSLocalizedString("Find recipe by ingredients", comment: ""))
                                .foregroundColor(Color(hex: 0x494949))
                                .bold()
                                .font(.system(size: 24))

                            ZStack{
                                TextField(NSLocalizedString("Enter the ingredient", comment: ""), text: $viewModel.textSearch )
                                    .padding(.leading, 8)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(.white)
                                    .cornerRadius(5)
                                    .bold()
                                    .font(.custom("ArgentumSans-Regular", size: 18))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .foregroundColor(Color(hex: 0xc5c5c5))
                            }
                            Text(NSLocalizedString("by Paulo Hmac", comment: ""))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(Color(hex: 0x494949))
                                .bold()
                                .font(.custom("ArgentumSans-Regular",size: 16))
                            Text(NSLocalizedString("https://github.com/paulohmac", comment: ""))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .bold()
                                .accentColor(Color(hex: 0xf0616d))
                                .font(.custom("ArgentumSans-Regular",size: 16))
                        }
                        .frame(width: UIScreen.main.bounds.width-62, height: 150)
                        .padding()
                        .cornerRadius(3)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .inset(by: 1) // inset value should be same as lineWidth in .stroke
                                .stroke(Color(hex: 0xf2f2f2), lineWidth: 1)
                        )
                }

                List(viewModel.recipeList) { recipe in
                    ZStack{
                        NavigationLink(destination: IngredientsView(idRecipe: recipe.id ?? 0, recipeTitle: recipe.title ?? "" )) {
                        }
                        ZStack{
                            AsyncImage(url: URL(string: recipe.image ?? ""))
                                .clipShape(RoundedRectangle(cornerRadius: 2))
                                .frame(width: UIScreen.main.bounds.width)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .overlay(Text(recipe.title ?? ""  )
                            .font(.headline)
                            .padding(6)
                            .foregroundColor(.white), alignment: .bottomLeading)
                        .buttonStyle(PlainButtonStyle())
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .listStyle(PlainListStyle())
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .frame(width: UIScreen.main.bounds.width)
                .background(Color(hex: 0xf2f2f2))
            }
        }
        .alert(viewModel.alertMessag, isPresented: $viewModel.showingAlert) {
            Button("OK", role: .cancel) { }
        }

    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}



