//
//  ContentView.swift
//  TCDemo
//
//  Created by Abdelhakim SAID on 23/05/2022.
//

import SwiftUI
import TCConsent

struct ContentView: View {
    
    @StateObject var tabSelection: Tab = Tab()
    @State private var isActive : Bool = false
    @EnvironmentObject var modelData: ModelData
    @State private var isPrivacyCenterPresented = false

    
    var cartProducts: [Product] {
        modelData.products.filter{p in (p.isInCart)}
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection.value) {
                
                HomeView().tabItem {
                    Image(systemName: "house.fill")
                    Text("Acceuil")
                }
                .tag(TabEnum.home)
                .onAppear{
                    TCExample.sendPageViewEvent(pageName: "home_page", pageType: "preview_page")
                }
                
                Cart(isActive: self.$isActive)
                    .tabItem{
                        Image(systemName: "cart.fill")
                        Text("Panier")
                    }
                    .tag(TabEnum.cart)
                    .onAppear{
                        TCExample.sendPageViewEvent(pageName: "cart_page", pageType: "preview_page")
                    }
                
                BannerView().tabItem{
                    Image(systemName: "lock.shield")
                    Text("Banner")
                }
                .tag(TabEnum.banner)
                .onAppear{
                    TCExample.sendPageViewEvent(pageName: "banner_page", pageType: "preview_page")
                }
                
                AnalyserView().tabItem{
                    Image(systemName: "lock.shield")
                    Text("Analyser")
                }
                .tag(TabEnum.analyser)
                .onAppear{
                    TCExample.sendPageViewEvent(pageName: "analyser_view", pageType: "preview_page")
                }
            }
        }
        .environmentObject(tabSelection)
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $isPrivacyCenterPresented) {
            PrivacyCenterWrapper()
        }
        .onAppear {
            if (TCConsentAPI.shouldDisplayPrivacyCenter())
            {
       //         isPrivacyCenterPresented = true
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
            .environmentObject(ModelData())
    }
}
