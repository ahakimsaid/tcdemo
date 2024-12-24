//
//  PaiementInfoView.swift
//  TCDemo
//
//  Created by Abdelhakim SAID on 10/06/2022.
//

import SwiftUI

struct PaiementInfoView: View {
    @State private var username: String = ""
    @State private var cardNumber: String = "3883999828824364"
    @State private var expirationDate: String = ""
    @State private var cryptogram: String = ""
    
    @EnvironmentObject var modelData: ModelData
    @Binding var isActive: Bool
    @State var formSubmitted: Bool = false
    
    var body: some View {
        VStack(spacing: 8){
            Text("Information de carte :")
                .font(.title)
                .frame(alignment: .leading)
            
            TextField(
                "Nom et Prénom ",
                text: $username
            )
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray, lineWidth: 1)
            )
            
            TextField(
                "Numero de carte ",
                text: $cardNumber
            )
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray, lineWidth: 1)
            )
            
            HStack{
                TextField(
                    "MM/YYYY",
                    text: $expirationDate
                )
                .frame(width: 80)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray, lineWidth: 1)
                )
                
                Spacer()
                TextField(
                    "CVC",
                    text: $cryptogram
                )
                .frame(width: 50)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray, lineWidth: 1)
                )
            }
            
            let isFormValid = isFormValid()
            
            NavigationLink(destination: ShippingInfoView(isActive: $isActive), isActive: $formSubmitted)
            {
                Button{
                    modelData.setPaiementInfo(cardNumber: self.cardNumber, fullName: self.username)
                    formSubmitted = true
                }
                label: {
                    
                    HStack{
                        Image(systemName: "cart.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(4)
                        
                        Text("Confirmer le paiement")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(6)
                        
                    }.background(isFormValid ? .blue : .gray)
                        .cornerRadius(5)
                        .foregroundColor(.white)
                        .frame(height: 40)
                        .padding(.top, 80)
                }
            }
            .disabled(!isFormValid)
            
            Spacer()
        }
        .padding()
        
        
    }
    
    func isFormValid() -> Bool
    {
        return cardNumber.count > 10
    }
}

struct PaiementInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PaiementInfoView(isActive: .constant(true))
    }
}
