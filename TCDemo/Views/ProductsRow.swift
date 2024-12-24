//
//  ProductsRow.swift
//  TCDemo-V5
//
//  Created by Abdelhakim SAID on 23/05/2022.
//

import SwiftUI

struct ProductsRow: View
{
    var products:[Product]
    var category: String
    
    var body: some View {
        VStack (alignment: .leading){
            Text(category)
                .font(.largeTitle)
                .padding(.leading, 20)
        
            
            ScrollView(.horizontal, showsIndicators: false)
            {
                HStack
                {
                    ForEach(products, id: \.self)
                    {
                        p in
                        
                        NavigationLink
                        {
                            ProductDetails(product: p)
                        }
                        label:
                        {
                            ProductItem(product: p)
                        }
                        .isDetailLink(false)
                    }
                }
            }
            .padding(.leading, 20)
        }
    }
}

struct ProductsRow_Previews: PreviewProvider {
    static var previews: some View {

        Text("")
    }
}
