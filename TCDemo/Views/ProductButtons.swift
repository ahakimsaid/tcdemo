//
//  FavoriteButton.swift
//  TCDemo-V5
//
//  Created by Abdelhakim SAID on 20/05/2022.
//

import SwiftUI

struct ProductButtons: View {
    @EnvironmentObject var modelData: ModelData
    var product: Product
    
    var body: some View {
        VStack
        {
            Button{
                modelData.toggleProductIsFavorite(product: product)
            } label: {
                Label("Save Favorite", systemImage: "heart.fill")
                    .labelStyle(.iconOnly)
                    .scaledToFit()
                    .font(.system(size: 40))
                    .foregroundColor(product.isFavorite ? .pink : .white)
                    .shadow(color: .black, radius: 7)
            }
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
            
            Button{
                modelData.addToCart(product: product)
            } label: {
                Label("add to cart", systemImage: "cart.fill")
                    .labelStyle(.iconOnly)
                    .scaledToFit()
                    .font(.system(size: 40))
                    .foregroundColor(product.isInCart ? .mint : .gray)
                    .shadow(color: .gray, radius: 7)
            }
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
