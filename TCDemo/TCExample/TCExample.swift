//
//  ServerSideExample.swift
//  TCDemo
//
//  Created by Abdelhakim SAID on 31/05/2022.
//

import Foundation
import TCCore
import TCConsent
import TCServerSide_noIDFA
import FirebaseCore
import FirebaseAnalytics

class TCExample : NSObject, TCPrivacyCallbacks
{
    private static let privacyID:Int32 = 22
    private static let siteID:Int32 = 3311
    private static let sourceKey = "7b23"
    
    private static var tc:ServerSide? = nil;
    
    static func initTCServerSide()
    {

        TCDebug.setDebugLevel(TCLogLevel_Assert)
        TCDebug.setNotificationLog(true)
        tc = ServerSide(siteID: siteID, andSourceKey: sourceKey, andDefaultBehaviour: PB_ALWAYS_ENABLED)
    }
    
    static func initTCConsent(callback: TCExample)
    {
//        let domain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: domain)
//        UserDefaults.standard.synchronize()
        
        TCConsentAPI.shouldDisplayPrivacyCenter()
        /**
         * If you need to use your own bundle, please use this for each configuration requiring a specific bundle.
         */
          // TCConfigurationFileFactory.sharedInstance().setBundle(myBundle, forConfiguration: @"vendor-list")

      //  TCCMPStorage.getConsentString()
        TCMobileConsent.sharedInstance().callback = callback
        TCMobileConsent.sharedInstance().setSiteID(siteID, andPrivacyID: privacyID)
        TCMobileConsent.sharedInstance().generatePublisherTC = false
        TCMobileConsent.sharedInstance().enableACString = true
        TCMobileConsent.sharedInstance().useCustomPublisherRestrictions()
        print("special feature = ", TCConsentAPI.isIABSpecialFeatureAccepted(1));
        print("custom special feature = ", isIABSpecialFeatureAccepted(ID: 1));
        
    }
    
    static func isIABSpecialFeatureAccepted(ID: Int) -> Bool {
        let offsetID = ID + 13000
        let consent = TCUserDefaults.retrieveInfo(fromUserDefaults: "PRIVACY_FEAT_\(offsetID)")
        return consent == "1"
    }
    
    static func sendPageViewEvent(pageName:String, pageType:String)
    {
        let event = TCPageViewEvent(type: pageType)
        event?.pageName = pageName
        tc?.execute(event)
    }
    
    static func sendBeginCheckoutEvent()
    {
        let event = TCBeginCheckoutEvent()
        tc?.execute(event)
    }
    
    static func sendAddToCartEvent(product:Product)
    {
//        let item:TCItem = TCItem(itemId: product.id, with: TCProduct(productId: product.id, withName: product.name, withPrice: NSDecimalNumber(value:product.price)), withQuantity: 1)
//        let event = TCAddToCartEvent(value: 1,  withCurrency: "euro", withItems: [item])
//        tc?.execute(event)
    }
    
    static func sendAddToWishListEvent(product:Product)
    {
//        let item = TCItem(itemId: product.id, with: TCProduct(productId: product.id, withName: product.name, withPrice: NSDecimalNumber(value:product.price)), withQuantity: 1)
//        let event = TCAddToWishlistEvent(items: [item!])
//        tc?.execute(event)
    }
    
    static func sendRemoveFromCartEvent(product:Product)
    {
//        let item = TCItem(itemId: product.id, with: TCProduct(productId: product.id, withName: product.name, withPrice: NSDecimalNumber(value:product.price)), withQuantity: 1)
//        let event = TCRemoveFromCartEvent(items: [item as Any])
//        tc?.execute(event)
    }
    
    static func sendAddPaiementInfo(method:String, coupon: String, product: Product)
    {
//        let item = TCItem(itemId: product.id, with: TCProduct(productId: product.id, withName: product.name, withPrice: NSDecimalNumber(value:product.price)), withQuantity: 1)
//        let event = TCAddPaymentInfoEvent(paymentMethod: "card")
//        event?.coupon = coupon
//        event?.currency = "EUR"
//        event?.items = [item!]
//        tc?.execute(event)
    }
    
    static func sendAddShippingInfo(adress:String)
    {
//        let event = TCAddShippingInfoEvent()
//        tc?.execute(event)
    }
    
    static func sendPurchaseEvent()
    {
//        let event = TCAddShippingInfoEvent()
//        tc?.execute(event)
    }
    
//    static func getServerSideInstance() -> ServerSide?
//    {
// //       return tc;
//    }
        
    func consentOutdated() 
    {
        print("your consent is outdated")
    }
    
    
    func firebaseConsentChanged(_ firebaseConsent: [String : NSNumber]!)
    {
        if let analytics_storage_consent = firebaseConsent["analytics_storage"]?.boolValue{
            Analytics.setConsent([.analyticsStorage: analytics_storage_consent ? .granted : .denied])
        }
        
        if let ad_storage_consent = firebaseConsent["ad_storage"]?.boolValue{
            Analytics.setConsent([.adStorage: ad_storage_consent ? .granted : .denied])
        }
    
        if let ad_user_data_consent = firebaseConsent["ad_user_data"]?.boolValue{
            Analytics.setConsent([.adUserData: ad_user_data_consent ? .granted : .denied])
        }
        
        if let ad_personalization_consent = firebaseConsent["ad_personalization"]?.boolValue{
            Analytics.setConsent([.adPersonalization: ad_personalization_consent ? .granted : .denied])
        }
    }
    

}
