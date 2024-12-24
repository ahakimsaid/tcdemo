//
//  ModelData.swift
//  TCDemo
//
//  Created by Abdelhakim SAID on 24/05/2022.
//

import Foundation

final class ModelData: ObservableObject
{
    /**
            @Published annotation calls OBJECT_HAS_CHANGED   whenever this value changes !
     */
    
    @Published var products: [Product] = readLocalFile("products")!.products
    var order: OrderDetails = OrderDetails()
    
    func productGroup(_ category: String) -> [Product]
    {
        return products.filter{p in p.category.rawValue == category}
    }
    
    func toggleProductInCart(productID: String)
    {
        let index = products.firstIndex(where: { $0.id == productID})!
        products[index].isInCart.toggle()
    }
    
    func addToCart(product: Product)
    {
        toggleProductInCart(productID: product.id)
        TCExample.sendAddToCartEvent(product: product)
    }
    
    func toggleProductIsFavorite(product: Product)
    {
        TCExample.sendAddToWishListEvent(product: product)
        let index = products.firstIndex(where: { $0.id == product.id})!
        products[index].isFavorite.toggle()
    }
    
    func resetStrore()
    {
        TCExample.sendPurchaseEvent()
        products = readLocalFile("products")!.products
        order = OrderDetails()
    }
    
    func setShippingInfo(adress:String)
    {
        order.fullAdress = adress
        TCExample.sendAddShippingInfo(adress: adress)
    }
    
    func setPaiementInfo(cardNumber: String, fullName: String)
    {
        order.cardNumber = cardNumber
        order.fullName = fullName
        TCExample.sendAddPaiementInfo(method: "card", coupon: order.coupon, product: order.product)
    }
    
    func removeFromCart(product: Product)
    {
        toggleProductInCart(productID: product.id)
        TCExample.sendRemoveFromCartEvent(product: product)
    }
    
    func setCartInfo(totalAmount:Int, coupon: String, product:Product)
    {
        order.totalAmount = totalAmount
        order.coupon = coupon
        order.product = product
        TCExample.sendBeginCheckoutEvent()
    }
}

func readLocalFile(_ name: String) -> Products? {
    do
    {
        if let bundlePath = Bundle.main.path(forResource: name,
                                             ofType: "json"),
            let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            
            let decodedData = try JSONDecoder().decode(Products.self,
                                                       from: jsonData)
            return decodedData
        }
    }
    catch
    {
        print(error)
    }
    
    return nil
}

struct OrderDetails
{
    var fullName = ""
    var fullAdress: String = ""
    var coupon: String = ""
    var cardNumber: String = ""
    var totalAmount: Int = 0
    var product: Product = Product()
}
