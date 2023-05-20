//
//  ImagePicker.swift
//  Dog_Bread_ID
//
//  Created by Leandro Carvalho on 20/05/23.
//

import Foundation
import SwiftUI

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ObservableObject {
    
    @Binding var isShow: Bool
    @Binding var image: Image?
    
    public init(isShow: Binding<Bool>, image: Binding<Image?>) {
        _isShow = isShow
        _image = image
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let userPickerImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        guard let convertedCIImage = CIImage(image: userPickerImage) else {
            fatalError("cannot convert to ciImage")
        }
        
        DetectImage().detect(image: convertedCIImage)
        image = Image(uiImage: userPickerImage)
        isShow = false
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShow = false
    }
    
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var isShow: Bool
    @Binding var image: Image?
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
    let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(isShow: $isShow, image: $image)
    }
}
