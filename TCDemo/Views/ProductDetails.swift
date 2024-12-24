//
//  ProductDetails.swift
//  TCDemo-V5
//
//  Created by Abdelhakim SAID on 20/05/2022.
//

import SwiftUI

struct ProductDetails: View {
    var product: Product
    
    let backgroundGradient = LinearGradient(
        colors: [Color.red],
        startPoint: .top, endPoint: .bottom)

    var body: some View {
        ScrollView
        {
            CircleImageView(image: product.image)
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       minHeight: 0,
                       maxHeight: .infinity,
                       alignment: .center)
                .padding(.top, 20)
                .padding(.bottom, 24)
                .background(.mint)

            VStack(alignment: .leading)
            {
                VStack {
                    Text(product.name)
                        .font(.title)
                    
                    Text("Price : \(product.price) €")
                        .font(.title2)
                        .foregroundColor(.green)
                        .bold()
                }
                
                Divider()

                HStack(alignment: .top){

                    Text(product.description)
                        .padding()
                    
                    Spacer()
                    
                    ProductButtons(product: product)
                }
            }.padding()

        }
    }
}

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
