import SwiftUI
import PhotosUI

struct MyView: View {
    @State private var selectedImages: [UIImage] = []
    @State private var isShowingImagePicker = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.fill")
                .font(.system(size: 100))
                .foregroundColor(.blue)
                .padding(.top, 50) // Add top padding to the profile image
            
            Text("John Doe")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "person.crop.circle.fill.badge.plus")
                        .foregroundColor(.blue)
                    Text("Age:")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text("30")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.blue)
                    Text("Email:")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text("johndoe@example.com")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            Text("Memory Corner")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.bottom, 10) // Add bottom padding to the title
            
            Button(action: {
                isShowingImagePicker = true
            }) {
                Text("Upload Photos")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImages: $selectedImages)
            }
            
            if selectedImages.isEmpty {
                Text("No photos uploaded yet.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 20)
            } else {
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 10) {
                        ForEach(selectedImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Account Details")
        .background(Color(.systemGroupedBackground))
    }
    
    func loadImage() {
        // Perform any additional processing with the selected images
        // For example, you can save them to disk or upload them to a server
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImages: [UIImage]
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 10 - selectedImages.count // Limit to 10 photos
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.presentationMode.wrappedValue.dismiss()
            
            for result in results {
                if parent.selectedImages.count < 10, result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                        if let error = error {
                            print("Error loading image: \(error.localizedDescription)")
                        } else if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self?.parent.selectedImages.append(image)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct MyView_Preview: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
