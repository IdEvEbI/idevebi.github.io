//
//  AvatarUploadView.swift
//  SwiftUIWeatherApp
//
//  Created by 黑马程序员 on 2024/7/10.
//

import SwiftUI
import Alamofire

/// ### 4.1 头像上传
struct AvatarUploadView: View {
    @State private var message = "选择头像上传..."
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            Group {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                }
            }
            .scaledToFit()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .padding()
            
            Button("选择头像") {
                isImagePickerPresented = true
            }
            .padding()
            
            Text(message)
                .padding()
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $selectedImage, onPick: { image in
                if let image = image {
                    uploadAvatar(image: image)
                }
            })
        }
    }
    
    func uploadAvatar(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        AF.upload(multipartFormData: { formData in
            formData.append(imageData, 
                            withName: "avatar",
                            fileName: "avatar.jpg",
                            mimeType: "image/jpeg")
        }, to: "http://localhost:3000/api/avatar")
        .responseDecodable(of: ResponseData.self) { response in
            switch response.result {
            case .success(let data):
                message = data.message
            case .failure(let error):
                message = "头像上传失败：\(error.localizedDescription)"
            }
        }
    }
}

/// 图像选择器
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var onPick: (UIImage?) -> Void
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker
        var onPick: (UIImage?) -> Void
        
        init(parent: ImagePicker, onPick: @escaping (UIImage?) -> Void) {
            self.parent = parent
            self.onPick = onPick
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as? UIImage
            parent.image = image
            onPick(image)
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            onPick(nil)
            picker.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, onPick: onPick)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

#Preview {
    AvatarUploadView()
}
