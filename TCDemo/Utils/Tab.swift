//
//  Tab.swift
//  TCDemo
//
//  Created by Abdelhakim SAID on 14/06/2022.
//

import Foundation

class Tab: ObservableObject
{
    @Published var value :TabEnum =  .home
}

enum TabEnum: String
{
    case cart = "Panier"
    case home = "Acceuil"
    case banner = "Banner"
    case analyser = "Analyser"
}
