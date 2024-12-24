//
//  PrePurchaseView.swift
//  TCDemo
//
//  Created by Abdelhakim SAID on 13/06/2022.
//

import SwiftUI

struct PrePurchaseView: View {
    @Binding var isActive:Bool
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading, spacing: 10){
                Spacer()
                    .frame(height: 70)
                
                Text("Adresse de livraison :")
                    .font(.title)
                    .padding()
                
                Text("\(modelData.order.fullAdress)")
                    .foregroundColor(.gray)
                    .font(.title3)
                    .padding(.leading)
                
                Text("Moyen de paiement :")
                    .font(.title)
                    .padding()
                
                Text("Carte Numéro : **** **** **** ****")
                    .foregroundColor(.gray)
                    .font(.title3)
                    .padding(.leading)
                
                HStack
                {
                    Text("Montant Total :")
                        .font(.title)
                        .padding()
                    
                    Spacer()
                    Text("\(modelData.order.totalAmount)€")
                        .font(.title)
                        .padding()
                }
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            
            NavigationLink
            {
                LottieView(isActive: $isActive)
            }label: {
                HStack{
                    Image(systemName: "shippingbox.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(4)
                    
                    Text("Valider la commande")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(6)
                    
                }.background(.blue)
                    .cornerRadius(5)
                    .foregroundColor(.white)
                    .frame(height: 40)
                    .padding(.top, 80)
            }
            
            Spacer()
        }
    }
}

struct PrePurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PrePurchaseView(isActive: .constant(true))
    }
}
