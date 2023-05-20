//
//  ContentView.swift
//  Dog_Bread_ID
//
//  Created by Leandro Carvalho on 14/05/23.
//

import SwiftUI

struct ContentView: View {
    
    var defaults = UserDefaults.standard
    @State private var topPrediction = ""
    @State private var secondPrediction = ""
    @State private var topConfidence = ""
    @State private var secondConfidence = ""
    
    @State private var showImagePicker: Bool = false
    @State private var img: Image? = nil
    @State private var placeholderIsShown = true
    
    var body: some View {
        VStack {
            VStack {
                Text("Dog Bread ID")
                    .font(.custom("Charter Italic", size: 34))
                    .foregroundColor(.white)
            }.padding(.bottom)
            
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(UIColor.systemGreen), lineWidth: 4)
                        .frame(width: 350, height: 250)
                    
                    img?.resizable()
                        .scaledToFit()
                        .padding()
                    
                    if placeholderIsShown {
                        Image("dogPlaceholder")
                            .scaleEffect(0.7)
                            .cornerRadius(20)
                            .shadow(color: .white, radius: 3)
                    } else {
                        Image("dogPlaceholder")
                            .frame(width: 500, height: 200).hidden()
                    }
                }
            }
            
            Spacer()
            
            VStack {
                Text("Top Prediction & Confidence").font(.custom("Charter Italic", size: 22)).foregroundColor(. white)
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(UIColor.systemOrange), lineWidth: 2)
                    .frame(width: 350, height: 60)
                    .overlay(Text(" " + self.topPrediction + self.topConfidence)
                        .padding(5)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .font(.title)
                        .padding(.bottom))
                    .padding(.bottom)
                
                Text("Second Prediction & Confidence").font(.custom("Charter Italic", size: 22)).foregroundColor(. white)
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(UIColor.systemOrange), lineWidth: 2)
                    .frame(width: 350, height: 60)
                    .overlay(Text(" " + self.secondPrediction + self.secondConfidence)
                        .padding(5)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .font(.title))
            }.foregroundColor(.white)
                .padding()
            
            VStack {
                HStack(spacing: 30) {
                    Button {
                        self.topPrediction = ""
                        self.secondPrediction = ""
                        self.topConfidence = ""
                        self.secondConfidence = ""
                        self.showImagePicker = true
                        self.placeholderIsShown = false
                    } label: {
                        VStack {
                            Image(systemName: "photo.on.rectangle")
                            Text("Library")
                                .padding(.horizontal)
                        }
                    }.padding()
                        .foregroundColor(.black)
                        .background(Color(UIColor.systemGreen))
                        .cornerRadius(25)
                    
                    Button {
                        self.topPrediction = UserDefaults.standard.string(forKey: "topPrediction") ?? "No Prediction Available"
                        self.secondPrediction = UserDefaults.standard.string(forKey: "secondPrediction") ?? "No Prediction Available"
                        self.topConfidence = UserDefaults.standard.string(forKey: "topConfidence") ?? "No Confidence Available"
                        self.secondConfidence = UserDefaults.standard.string(forKey: "secondConfidence") ?? "No Confidence Available"
                    } label: {
                        VStack {
                            Image(systemName: "questionmark.square.fill")
                            Text("Predict")
                                .padding(.horizontal)
                        }
                    }.padding()
                        .foregroundColor(.black)
                        .background(Color(UIColor.systemOrange))
                        .cornerRadius(25)
                }
            }
            .sheet(isPresented: self.$showImagePicker) {
                ImagePicker(isShow: self.$showImagePicker, image: self.$img)
            }
            
        }.background(Image("background")).edgesIgnoringSafeArea(.all)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
