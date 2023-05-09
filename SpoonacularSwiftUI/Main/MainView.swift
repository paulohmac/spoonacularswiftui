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
                        Text(recipe.title ?? ""  )
                            .font(.headline)
                            .padding()
                        Text(recipe.image ?? "" )
                            .font(.body)
                            .padding()
                    }
                }
            }.padding(22.0)
        }.onAppear {
            loadData()
        }
    }
    
    
    private func loadData(){

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}



