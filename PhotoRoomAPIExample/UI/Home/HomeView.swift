//
//  HomeView.swift
//  PhotoRoomAPIExample
//
//  Created by Audrey SOBGOU ZEBAZE on 08/11/2021.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
        
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            PreviewView(image: $viewModel.currentImage, imageState: $viewModel.imageState, text: $viewModel.buttonText) {
                switch viewModel.imageState {
                case .initial:
                    isShowPhotoLibrary = true
                case .original:
                    viewModel.processImage()
                default: break
                }
            }
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $viewModel.currentImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
