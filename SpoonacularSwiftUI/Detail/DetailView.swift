//
//  DetailView.swift
//  SpoonacularSwiftUI
//
//  Created by Paulo H.M. on 10/05/23.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel = DetailViewModel()
    @State var idRecipe = 0

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
            }.padding(22.0)
        }.onAppear {

        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
