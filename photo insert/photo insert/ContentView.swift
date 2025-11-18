//
//  ContentView.swift
//  photo insert
//
//  Created by Thomas Daly on 8/25/25.
//

import SwiftUI
import UIKit
import PhotosUI

struct ContentView: View {
    
    @State private var photoArray: [UIImage] = []               // Holds the selected photos
    @State private var selectedImageIndex: Int = 0              // Tracks which image is being shown
    @State private var isShowingPhotoPicker = false             // Triggers photo picker
    @State private var selectedItems: [PhotosPickerItem] = []   // Used by PhotosPicker
    
    var body: some View {
        VStack {
            
            if photoArray.isEmpty {
                Image(systemName: "apps.iphone")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 385, height: 700)
                    .foregroundColor(.green)
            } else {
                Image(uiImage: photoArray[selectedImageIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 385, height: 700)
            }
            
            
            
            HStack {
                
                Button("Add Photo") {
                    isShowingPhotoPicker = true
                }
                .font(.system(size: 25))
                .background(Color.yellow)
                .cornerRadius(10)
                
                Button("Scroll Up") {
                    if selectedImageIndex > 0 {
                        selectedImageIndex -= 1
                    }
                }
                .font(.system(size: 25))
                .background(Color.green)
                .cornerRadius(10)
                .disabled(photoArray.isEmpty)
                Button("Scroll Down") {
                    if selectedImageIndex < photoArray.count - 1 {
                        selectedImageIndex += 1
                    }
                }
                .font(.system(size: 25))
                .background(Color.red)
                .cornerRadius(10)
                .disabled(photoArray.isEmpty)
            }
                
            VStack {
                Spacer()
                
                Picker("Picker", selection: $selectedImageIndex) {
                    ForEach(0..<photoArray.count, id: \.self) { index in
                        Text("Image \(index + 1)").tag(index)
                        
                        
                    }
                    .font(.system(size: 35))
                    .pickerStyle(.menu)
                    .disabled(photoArray.isEmpty)
                    Spacer()
                }
                .padding()
                .photosPicker(isPresented: $isShowingPhotoPicker, selection: $selectedItems, matching: .images)
                .onChange(of: selectedItems) { newItems in
                    for item in newItems {
                        Task {
                            if let data = try? await item.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                photoArray.append(uiImage)
                                selectedImageIndex = photoArray.count - 1
                            }
                        }
                    }
                }
            }
        }
    }
}
    #Preview {
        ContentView()
    }
