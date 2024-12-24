//
//  CartRow.swift
//  TCDemo
//
//  Created by Abdelhakim SAID on 24/05/2022.
//

import SwiftUI

struct CartRow: View {
    @EnvironmentObject var modelData: ModelData
    
    var cartProduct: Product
    
    var body: some View {
        VStack (spacing: 0) {
            Text(cartProduct.name)
                .frame(maxWidth: .infinity, alignment: .leading) // << here !!
                .multilineTextAlignment(.leading)
                .font(.largeTitle)
            
            HStack() {
                cartProduct.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                
                Spacer()
                
                VStack {
                    Text("Price : \(cartProduct.price)")
                        .font(.headline)
                    Spacer()
                    Button{
                        modelData.removeFromCart(product: cartProduct)
                    } label: {
                        Label("Save Favorite", systemImage: "trash.fill")
                            .labelStyle(.iconOnly)
                            .foregroundColor(.red)
                            .font(.system(size: 20))
                    }
                }
                .padding()
                .frame(width: 120, height: 120)
                .padding(.top, 0)
            }
            .padding()
            .padding(.top, 0)
            
            Divider()
        }
        .padding()
        
    }
}

struct CartRow_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
