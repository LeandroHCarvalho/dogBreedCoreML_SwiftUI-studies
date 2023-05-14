//
//  ContentView.swift
//  Dog_Bread_ID
//
//  Created by Leandro Carvalho on 14/05/23.
//

import SwiftUI

struct ContentView: View {
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
                    Image("dogPlaceholder")
                        .scaleEffect(0.7)
                        .cornerRadius(20)
                        .shadow(color: .white, radius: 3)
                }
            }
            
            Spacer()
            
            VStack {
                Text("Top Prediction & Confidence").font(.custom("Charter Italic", size: 22)).foregroundColor(. white)
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(UIColor.systemOrange), lineWidth: 2)
                    .frame(width: 350, height: 60)
                    .padding(.bottom)
                
                Text("Second Prediction & Confidence").font(.custom("Charter Italic", size: 22)).foregroundColor(. white)
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(UIColor.systemOrange), lineWidth: 2)
                    .frame(width: 350, height: 60)
            }.padding()
            
            VStack {
                HStack(spacing: 30) {
                    Button {
                        print("clickButton")
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
                        print("clickButton")
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
            
            
        }.background(Image("background")).edgesIgnoringSafeArea(.all)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
