//
//  HomeView.swift
//  TCDemo
//
//  Created by Abdelhakim SAID on 24/05/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ScrollView{
        
            Text("Welcome to TCDemo Store")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
            
            Image("commanders-banner")
                .resizable()
                .scaledToFit()
            
            VStack
            {
                ProductsRow(products: modelData.productGroup(Product.ProductCategory.HI_TECH.rawValue), category: Product.ProductCategory.HI_TECH.rawValue)
                Divider()
                ProductsRow(products: modelData.productGroup(Product.ProductCategory.VIDEO_GAMES.rawValue), category: Product.ProductCategory.VIDEO_GAMES.rawValue)
                Divider()
                ProductsRow(products: modelData.productGroup(Product.ProductCategory.gadgets.rawValue), category: Product.ProductCategory.gadgets.rawValue)
            }
            .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
