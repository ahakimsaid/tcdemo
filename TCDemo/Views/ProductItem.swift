//
//  ProductItem.swift
//  TCDemo-V5
//
//  Created by Abdelhakim SAID on 23/05/2022.
//

import SwiftUI

struct ProductItem: View {
    var product:Product
    
    var body: some View {
        VStack(alignment: .leading)
        {
            product.image
                .resizable()
                .frame(width: 180, height: 180)
                .scaledToFit()
                .cornerRadius(12)

            
            Text(product.name)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("\(product.price) €")
                .foregroundColor(.primary)
        }

    }
}

struct ProductItem_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
