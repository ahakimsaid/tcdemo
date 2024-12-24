//
//  Product.swift
//  TCDemo-V5
//
//  Created by Abdelhakim SAID on 20/05/2022.
//

import Foundation
import SwiftUI

struct Product: Hashable, Codable, Identifiable
{
    init(id: String, name: String, description: String, isFavorite: Bool, isInCart: Bool, price: Int, imageName: String) {
        self.id = id
        self.name = name
        self.description = description
        self.isFavorite = isFavorite
        self.isInCart = isInCart
        self.price = price
        self.imageName = imageName
    }
    
    init()
    {
        self.id = ""
        self.name = ""
        self.description = ""
        self.isFavorite = false
        self.isInCart = false
        self.price = 0
        self.imageName = ""
    }
    
    enum ProductCategory : String, Codable {
        case HI_TECH = "Hi Tech"
        case VIDEO_GAMES = "Video Games"
        case gadgets = "Gadgets"
    }
    
    var id: String
    var name: String
    var description: String
    var isFavorite: Bool
    var isInCart: Bool
    var price: Int
    var category: ProductCategory = ProductCategory.HI_TECH
    private var imageName: String
    
    var image: Image {
        Image(imageName)
    }
}
