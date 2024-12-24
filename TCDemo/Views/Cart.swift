//
//  Cart.swift
//  TCDemo
//
//  Created by Abdelhakim SAID on 24/05/2022.
//

import SwiftUI

struct Cart: View {
    @State var coupon = ""
    @State var validCoupon = false
    @Binding var isActive:Bool
    
    @EnvironmentObject var modelData: ModelData

    var cartProducts: [Product] {
        modelData.products.filter{p in (p.isInCart)}
    }
    
    func totalAmount(couponState: Bool) -> Int {
        if (couponState)
        {
            return Int(Double(cartProducts.map{$0.price}.reduce(0, +)) * 0.8)
        }
        else
        {
            return cartProducts.map{$0.price}.reduce(0, +)
        }
    }
    
    var body: some View
    {
        VStack {
            Text("Panier")
            
            Divider()
            
            ScrollView{
                VStack {
                    ForEach(cartProducts){
                        p in
                        CartRow(cartProduct: p)
                    }
                }.padding()
            }
            
            Divider()
            
            HStack{
                
                TextField(
                    "Coupon ...",
                    text: $coupon
                )
                
                .frame(width: 80)
                
                Spacer()
                
                Button("Valider") {
                    validCoupon = !coupon.isEmpty
                }
                .buttonStyle(.bordered)
            }
            .padding(.leading)
            .padding(.trailing)
            
            VStack {
                
                if (validCoupon)
                {
                    HStack{
                        Text("Sous Total :")
                        
                        Spacer()
                        Text("\(totalAmount(couponState: false)) €")
                            .strikethrough()
                            .foregroundColor(.red)
                    }
                    .padding()
                }
                
                HStack{
                    Text("Montant Total :")
                        .font(.title)
                    
                    Spacer()
                    
                    Text("\(totalAmount(couponState: validCoupon)) €")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.green)
                }
                .padding(.leading)
                .padding(.trailing)
            }
            
            NavigationLink(destination: PaiementInfoView(isActive: self.$isActive), isActive: $isActive)
            {
                Button{
                    modelData.setCartInfo(totalAmount: self.totalAmount(couponState: validCoupon), coupon: self.coupon, product: cartProducts[0])
                    isActive = true
                }
                label: {
                    HStack{
                        Image(systemName: "cart.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(4)
                        
                        Text("procéder au paiement")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(6)
                        
                    }.background(cartProducts.count <= 0 ? .gray : .blue)
                        .cornerRadius(5)
                        .foregroundColor(.white)
                        .frame(height: 40)
                        .padding(.bottom)
                }
            }
            .isDetailLink(false)
            .disabled(cartProducts.count <= 0)
            
        }.navigationBarHidden(true)
    }
}

struct Cart_Previews: PreviewProvider {
    
    static var previews: some View {
        Cart(isActive: .constant(true))
            .environmentObject(ModelData())
    }
}
