//
//  AnalyserView.swift
//  TCDemo_ServerSide_And_Consent
//
//  Created by Abdelhakim SAID on 08/12/2023.
//

import Foundation
import SwiftUI
import TCConsent
import UIKit
import Foundation

struct AnalyserView: View {
    @State private var willMoveToNextScreen = false
    @State private var jsonText: String = ""
    @State private var warnings: String = ""
    @State private var availableLanguages:Array<String> = ["en"]
    @State private var consentLanguage: String = ""

    @Environment(\.openURL) var openURL
    
    var body: some View {
        GeometryReader { geo in
            VStack(){
                
                HStack{
                    Text(" Privacy.json ")
                        .background(Color(UIColor.systemBackground))
                        .padding(.bottom, -18)
                        .padding(.leading, 6)
                        .foregroundColor(.gray)
                    Spacer()
                }.zIndex(1)
                
                TextEditor(text: $jsonText)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    ).frame(height: geo.size.height * 0.2)
                    .keyboardType(.asciiCapable)
                
                Button{
                    warnings = ""
                    jsonText = ""
                } label: {
                    HStack{
                        Image("commanders")
                            .resizable().scaledToFit().frame(width: 30, height: 30)
                            .padding(4)
                        Text("Reset")
                            .multilineTextAlignment(.leading)
                            .padding()
                            .padding(.top, -6)
                            .padding(.bottom, -6)
                    }.shadow(color: .gray, radius: 7)
                        .background(Color.red)
                        .cornerRadius(7)
                        .foregroundColor(.white)
                }
                
                Button{
                    warnings = checkJson(jsonText: jsonText, availableLanguages: $availableLanguages)
                } label: {
                    HStack{
                        Image("commanders")
                            .resizable().scaledToFit().frame(width: 30, height: 30)
                            .padding(4)
                        Text("Apply Json")
                            .multilineTextAlignment(.leading)
                            .padding()
                            .padding(.top, -6)
                            .padding(.bottom, -6)
                    }.shadow(color: .gray, radius: 7)
                        .background(Color.red)
                        .cornerRadius(7)
                        .foregroundColor(.white)
                }
                
                
                HStack(alignment: .center) {
                    
                    Text("Select Language :")
                    
                    Picker("Select language :", selection: $consentLanguage) {
                                    ForEach(availableLanguages, id: \.self) {
                                        Text($0)
                                    }
                    }.onChange(of: consentLanguage, perform:{newValue in
                        newValue == "en" ? TCMobileConsent.sharedInstance().setLanguage(nil) :  TCMobileConsent.sharedInstance().setLanguage(newValue)
                    })


                    Button{
                        willMoveToNextScreen.toggle()
                    } label: {
                        HStack{
                            Image("commanders")
                                .resizable().scaledToFit().frame(width: 30, height: 30)
                                .padding(4)
                            Text("Show privacy center")
                                .multilineTextAlignment(.leading)
                                .padding()
                                .padding(.top, -6)
                                .padding(.bottom, -6)
                        }.shadow(color: .gray, radius: 7)
                            .background(Color.blue)
                            .cornerRadius(7)
                            .foregroundColor(.white)
                    }
                
                }
                
                TextEditor(text: $warnings)
                    .frame(height: geo.size.height * 0.3)
                
                Spacer()
            }
            .sheet(isPresented: $willMoveToNextScreen) {
                PrivacyCenterWrapper()
            }
            .padding(20)
        }
        
    }
}

func checkJson(jsonText: String, availableLanguages: Binding<Array<String>>) -> String
{
    if let jsonData = jsonText.data(using: .utf8)
    {
        do
        {
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            {
                TCUserDefaults.removeInfo(fromUserDefaults: "configuration_privacy");
                TCUserDefaults.saveInfo(toUserDefaults: jsonText, forLabel: "configuration_privacy")
                return TCUtils.checkJson(privacyJson: jsonObject, availableLanguages: availableLanguages)
            }
            else
            {
                return "Failed to convert Data to dictionary."
            }
        }
        catch
        {
            return "Error parsing JSON: \(error.localizedDescription)"
        }
    }
    
    return "Failed to convert string to data."
}

struct AnalyserView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyserView()
    }
}
