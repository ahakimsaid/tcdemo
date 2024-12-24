//
//  ShippingInfoView.swift
//  TCDemo
//
//  Created by Abdelhakim SAID on 13/06/2022.
//

import SwiftUI

struct ShippingInfoView: View {
    @State private var adress = "3b rue Taylor"
    @State private var adressComp = ""
    @State private var city = "Paris"
    @State private var zipcode = "75010"
    
    @Binding var isActive:Bool
    @EnvironmentObject var modelData: ModelData
    @State var formSubmitted: Bool = false
    
    var body: some View {
        
        VStack( spacing: 8){
            Text("Information de Iivraison :")
                .font(.title)
                .frame(alignment: .leading)
            
            TextField(
                "Adresse ",
                text: $adress
            )
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray, lineWidth: 1)
            )
            
            TextField(
                "Complément",
                text: $adressComp
            )
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray, lineWidth: 1)
            )
            
            TextField(
                "Ville",
                text: $city
            )
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray, lineWidth: 1)
            )
            
            HStack{
                TextField(
                    "Code postal",
                    text: $zipcode
                )
                .frame(width: 100)
                .padding()
                .keyboardType(.decimalPad)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray, lineWidth: 1)
                )
                
                Spacer()
            }
            
            let isFormValid = isFormValid()
            
            NavigationLink(destination: PrePurchaseView(isActive: $isActive), isActive: $formSubmitted)
            {
                Button{
                    modelData.setShippingInfo(adress: "\(self.adress) \n\(self.adressComp)\n\(self.zipcode) \n\(self.city)")
                    
                    formSubmitted = true
                }
                label: {
                    HStack{
                        Image(systemName: "shippingbox.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(4)
                        
                        Text("Confirmer l'adresse")
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
        }
        .padding()
        
        Spacer()
    }
    
    func isFormValid() -> Bool
    {
        return !adress.isEmpty && !zipcode.isEmpty
    }
}

struct ShippingInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ShippingInfoView(isActive: .constant(true))
    }
}
