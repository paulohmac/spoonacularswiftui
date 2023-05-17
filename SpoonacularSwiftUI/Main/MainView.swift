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
                        .opacity(1)
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: 300)
                        .clipped()
                        VStack{
                            Text("Find recipe by ingredients")
                                .foregroundColor(Color(hex: 0x494949))
                                .bold()
                                .font(.system(size: 24))

                            ZStack{
                                TextField("Enter the ingredient", text: $viewModel.textSearch )
                                    .padding(.leading, 8)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(.white)
                                    .cornerRadius(5)
                                    .bold()
                                    .font(.custom("ArgentumSans-Regular", size: 18))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .foregroundColor(Color(hex: 0xc5c5c5))
                            }
                            Text("by Paulo Hmac")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(Color(hex: 0x494949))
                                .bold()
                                .font(.custom("ArgentumSans-Regular",size: 16))
                            Text("https://github.com/paulohmac")
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

                List(viewModel.recipeList){ recipe in
                    ZStack(alignment: .leading) {
                        NavigationLink(destination: IngredientsView(idRecipe: recipe.id ?? 0)) {
                            ZStack{
                                AsyncImage(url: URL(string: recipe.image ?? ""))
                                    .clipShape(RoundedRectangle(cornerRadius: 2))
                                
                            }.overlay(Text(recipe.title ?? ""  )
                                .font(.headline)
                                .padding(6)
                                .foregroundColor(.white), alignment: .bottomLeading)
                            
                        }
                        Text("")
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
                .background(Color(hex: 0xf2f2f2))

            }
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}



