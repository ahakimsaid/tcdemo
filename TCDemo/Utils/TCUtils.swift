//
//  TCUtils.swift
//  TCDemo_ServerSide_And_Consent
//
//  Created by Abdelhakim SAID on 24/11/2023.
//

import Foundation
import SwiftUI
import TCConsent

class TCUtils
{
    static func checkJson(privacyJson: [String: Any], availableLanguages: Binding<Array<String>>) -> String
    {
        var warnings = ""
        let langs = evaluateAvailableLanguages(privacyJson: privacyJson)
        availableLanguages.wrappedValue = langs
        TCMobileConsent.sharedInstance().setLanguage(langs[0])
        warnings += checkInformation(privacyJson: privacyJson)
        warnings += checkAllTexts(privacyJson: privacyJson, availableLanguages: langs)
        warnings += checkCustomisation(privacyJson: privacyJson)
        warnings += checkComponents(privacyJson: privacyJson)
        return warnings
    }
    
    
    static func evaluateAvailableLanguages(privacyJson: [String: Any]) -> [String]
    {
        var languages = ["ar","bg","bs","ca","cs","da","de","el","es","et","eu","fi","fr","gl","hr","hu","it","ja","lt","lv","mt","nl","no","pl","pt-br","pt-pt","ro","ru","sk","sl","sr-cyrl","sr-latn","sv","tr","zh"]
        
        languages = languages.filter{languageCode in (privacyJson["texts_\(languageCode)"] != nil)}
        languages.append("en")
        return languages
    }
    
    static func checkComponents(privacyJson: [String: Any]) -> String
    {
        var warnings = ""
        if privacyJson["components"] == nil
        {
            warnings = "⚠️ Missing components field !\n"
        }
        else
        {
            if (isLeafNullOfEmpty(object: privacyJson, path: "components/firstLayerButton")) { warnings += "⚠️ Missing components/firstLayerButton field !\n" }
            if (isLeafNullOfEmpty(object: privacyJson, path: "components/secondLayerButton")) { warnings += "⚠️ Missing components/secondLayerButton field !\n" }
        }
        
        return warnings
    }
    
    static func isSubStringSet(object: [String: Any], path: String, substring: String) -> Bool
    {
        let value: String? = getLeaf(object: object, path: path) as! String?
        var result = false
        
        if (value != nil)
        {
            result = value!.contains(substring)
        }
        
        return result
    }
    
    static func isLeafNullOfEmpty(object: [String: Any], path: String) -> Bool
    {
        let value: Any? = getLeaf(object: object, path: path)
        
        if (value == nil ||
            ((value is String) && (value as! String?)?.count == 0) ||
            ((value is Array<Any>) && (value as! Array<Any>?)?.count == 0) ||
            ((value is [String: Any]) && (value as! [String: Any]?)?.count == 0))
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    static func getLeaf(object: [String: Any], path: String) -> Any?
    {
        let keys = path.split(separator: "/").map(String.init)
        var leaf = object
        
        for (_, key) in keys.enumerated()
        {
            if (leaf[key] == nil)
            {
                return nil
            }
            else if (leaf[key] != nil && leaf[key] is [String: Any?])
            {
                leaf = leaf[key] as! [String : Any]
            }
            else if (leaf[key] != nil && !(leaf[key] is [String: Any?]) )
            {
                return leaf[key]
            }
        }
        
        return leaf
    }
    
    static func checkCustomisation(privacyJson: [String: Any]) -> String
    {
        var warnings = ""
        if (privacyJson["customisation"] == nil)
        {
            warnings = "⚠️Missing customisation field !\n"
        }
        else
        {
            if (isLeafNullOfEmpty(object: privacyJson, path: "customisation/content"))
            {
                warnings += "⚠️ Missing customisation/content field !\n"
            }
            else
            {
                if (isLeafNullOfEmpty(object: privacyJson, path: "customisation/content/fontcolor")) { warnings += "⚠️ Missing customisation/content/fontcolor field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: "customisation/content/backgroundcolor")) { warnings += "⚠️ Missing customisation/content/backgroundcolor field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: "customisation/content/bordercolor")) { warnings += "⚠️ Missing customisation/content/bordercolor field !\n" }
            }
            
            if (isLeafNullOfEmpty(object: privacyJson, path: "customisation/button"))
            {
                warnings += "⚠️ Missing customisation/button field !\n"
            }
            else
            {
                if (isLeafNullOfEmpty(object: privacyJson, path: "customisation/button/fontcolor")) { warnings += "⚠️ Missing customisation/button/fontcolor field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: "customisation/button/backgroundcolor")) { warnings += "⚠️ Missing customisation/button/backgroundcolor field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: "customisation/button/linkcolor")) { warnings += "⚠️ Missing customisation/button/linkcolor field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: "customisation/button/disabledBackground")) { warnings += "⚠️ Missing customisation/button/disabledBackground field !\n" }
            }
            
            if (isLeafNullOfEmpty(object: privacyJson, path: "customisation/order"))
            {
                warnings += "⚠️ Missing customisation/order field !\n"
            }
        }
        
        return warnings
    }
    
    static func checkAllTexts(privacyJson: [String: Any], availableLanguages: [String]) -> String
    {
        var warnings = ""
        for languageCode in availableLanguages
        {
            warnings += checkTexts(privacyJson: privacyJson, languageCode: languageCode)
        }
        
        return warnings
    }

    static func checkTexts(privacyJson: [String: Any], languageCode: String) -> String
    {
        var warnings = ""
        let texts_xx = languageCode.isEmpty || languageCode == "en" ? "texts" : "texts_" + languageCode
        
        if (privacyJson[texts_xx] == nil)
        {
            warnings = "⚠️Missing " + texts_xx + " field !\n"
        }
        else
        {
            if (isLeafNullOfEmpty(object: privacyJson, path: texts_xx + "/generic"))
            {
                warnings += "⚠️ Missing " + texts_xx + "/generic field !\n"
            }
            else
            {
                if (isLeafNullOfEmpty(object: privacyJson, path: texts_xx + "/generic/saveButton")) { warnings += "⚠️ Missing \(texts_xx)/generic/saveButton field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: texts_xx + "/generic/detailButton")) { warnings += "⚠️ Missing \(texts_xx)/generic/detailButton field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: texts_xx + "/generic/acceptAllButton")) { warnings += "⚠️ Missing \(texts_xx)/generic/acceptAllButton field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: texts_xx + "/generic/refuseAllButton")) { warnings += "⚠️ Missing \(texts_xx)/generic/refuseAllButton field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: texts_xx + "/generic/vendorButton")) { warnings += "⚠️ Missing \(texts_xx)/generic/vendorButton field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: texts_xx + "/generic/purposeButton")) { warnings += "⚠️ Missing \(texts_xx)/generic/purposeButton field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: texts_xx + "/generic/consentDef")) { warnings += "⚠️ Missing \(texts_xx)/generic/consentDef field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: texts_xx + "/generic/relatedVendorsButton")) { warnings += "⚠️ Missing \(texts_xx)/generic/relatedVendorsButton field !\n" }

                if (isLeafNullOfEmpty(object: privacyJson, path: texts_xx + "/generic/mandatoryDef")) { warnings += "⚠️ Missing \(texts_xx)/generic/mandatoryDef field !\n" }
            }

            if (isLeafNullOfEmpty(object: privacyJson, path: "\(texts_xx)/purposes"))
            {
                warnings += "⚠️ Missing \(texts_xx)/purposes field !\n"
            }
            else
            {
                if (isLeafNullOfEmpty(object: privacyJson, path: "\(texts_xx)/purposes/title")) { warnings += "⚠️ Missing \(texts_xx)/purposes/title field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: "\(texts_xx)/purposes/content")) { warnings += "⚠️ Missing \(texts_xx)/purposes/content field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: "\(texts_xx)/purposes/privacy_policy_url")) { warnings += "⚠️ Missing \(texts_xx)/purposes/privacy_policy_url field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: "\(texts_xx)/purposes/privacy_policy_text")) { warnings += "⚠️ Missing \(texts_xx)/purposes/privacy_policy_text field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: "\(texts_xx)/purposes/consent_id_text")) { warnings += "⚠️ Missing \(texts_xx)/purposes/consent_id_text field !\n" }
            }

            if (isLeafNullOfEmpty(object: privacyJson, path: "\(texts_xx)/vendors"))
            {
                warnings += "⚠️ Missing \(texts_xx)/vendors field !\n"
            }
            else
            {
                
                if (isLeafNullOfEmpty(object: privacyJson, path: "\(texts_xx)/vendors/title")) { warnings += "⚠️ Missing \(texts_xx)/vendors/title field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: "\(texts_xx)/vendors/content")) { warnings += "⚠️ Missing \(texts_xx)/vendors/content field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: "\(texts_xx)/vendors/privacyPolicyText")) { warnings += "⚠️ Missing \(texts_xx)/vendors/privacyPolicyText field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: "\(texts_xx)/vendors/dropDownButton")) { warnings += "⚠️ Missing \(texts_xx)/vendors/dropDownButton field !\n" }
            }


            if (isLeafNullOfEmpty(object: privacyJson, path: "\(texts_xx)/others"))
            {
                warnings += "⚠️ Missing \(texts_xx)/others field !\n"
            }
            else
            {
                if (isLeafNullOfEmpty(object: privacyJson, path: "\(texts_xx)/others/title_purposes")) { warnings += "⚠️ Missing \(texts_xx)/others/title_purposes field !\n" }
                if (isLeafNullOfEmpty(object: privacyJson, path: "\(texts_xx)/others/title_vendors")) { warnings += "⚠️ Missing \(texts_xx)/others/title_vendors field !\n" }
            }
        }

        return warnings
    }

    static func checkInformation(privacyJson: [String: Any]) -> String
    {
        var warnings = ""
        if (privacyJson["information"] == nil)
        {
            warnings = "⚠️Missing Information field !\n"
        }
        else
        {
            if (isLeafNullOfEmpty(object: privacyJson, path: "information/update")) { warnings += "⚠️ Missing information/update field !\n" }
            if (isLeafNullOfEmpty(object: privacyJson, path: "information/version")) { warnings += "⚠️ Missing information/version field !\n" }
            if (isLeafNullOfEmpty(object: privacyJson, path: "information/vendors")) { warnings += "⚠️ Missing information/vendors field !\n" }
            if (isLeafNullOfEmpty(object: privacyJson, path: "information/consentDurationInMonths")) { warnings += "⚠️ Missing information/consentDurationInMonths field !\n" }
            if (isLeafNullOfEmpty(object: privacyJson, path: "information/google_vendors")) { warnings += "⚠️ Missing information/google_vendors field !\n" }

        }

        return warnings
    }
}
