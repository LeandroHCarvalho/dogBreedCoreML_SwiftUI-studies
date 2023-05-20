//
//  DetectImage.swift
//  Dog_Bread_ID
//
//  Created by Leandro Carvalho on 20/05/23.
//

import Foundation
import CoreML
import Vision
import UIKit
import SwiftUI

class DetectImage {
    
    let defaults = UserDefaults.standard
    var saveTopPrediction = ""
    var saveSecondPrediction = ""
    var saveTopConfidence = ""
    var saveSecondConfidence = ""
    
    func detect(image: CIImage) {
        
        guard let mlModel = try? All_AKC_Breeds_Reworked_1500(configuration: .init()).model, let model = try? VNCoreMLModel(for: mlModel) else {
            fatalError("cannot import model")
        }
        
//        guard let model = try? VNCoreMLModel(for: All_AKC_Breeds_Reworked_1500().model) else {
//            fatalError("cannot import model")
//        }
        
        
        let request = VNCoreMLRequest(model: model) { request, error in
            let classifications = request.results as! [VNClassificationObservation]
            let predicationIdentifiers = classifications.prefix(3)
            let predictedBreeds = predicationIdentifiers.map { classification in
                return classification.identifier
            }
            
            let predicationConfidences = predicationIdentifiers.map { classification in
                return String(format: " %.0f %@", classification.confidence * 100, "%")
            }
            
            let firstPrediction = predictedBreeds[0]
            let secondPrediction = predictedBreeds[1]
            
            self.saveTopPrediction = firstPrediction
            self.defaults.set(self.saveTopPrediction, forKey: "topPrediction")
            
            self.saveSecondPrediction = secondPrediction
            self.defaults.set(self.saveSecondPrediction, forKey: "secondPrediction")
            
            self.saveTopConfidence = predicationConfidences[0]
            self.defaults.set(self.saveTopConfidence, forKey: "topConfidence")
            
            self.saveSecondConfidence = predicationConfidences[1]
            self.defaults.set(self.saveTopConfidence, forKey: "secondConfidence")
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    struct ImageCapture: View {
        
        @Binding var imagePickerShow: Bool
        @Binding var image: Image?
        
        var body: some View {
            ImagePicker(isShow: $imagePickerShow, image: $image)
        }
    }
    
}
