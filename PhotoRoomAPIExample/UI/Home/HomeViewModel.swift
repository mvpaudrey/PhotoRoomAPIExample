//
//  HomeViewModel.swift
//  PhotoRoomAPIExample
//
//  Created by Audrey SOBGOU ZEBAZE on 08/11/2021.
//

import Combine
import SwiftUI

enum ImageState: Equatable {
    case initial
    case original
    case processing
    case processed(UIImage?)
}

final class HomeViewModel: ObservableObject {
        
    @Published var processedPhotos: [UIImage] = []
    
    @Published var currentImage: UIImage?
    
    @Published var loading: Bool = false
    
    @Published var processingEnded: Bool = false
    
    @Published var errorMessage: String?
    
    @Published var imageState: ImageState = .initial
    
    @Published var buttonText: String = "Photo Library"
    
    private var cancellables = Set<AnyCancellable>()
    
    private let imagesRepository: ImagesRepositoryGateway
    
    private let removeBackgroundService: RemoveBackgroundGateway
    
    init(imagesRepository: ImagesRepository = ImagesRepository(),
         removeBackgroundService: RemoveBackgroundGateway = RemoveBackgroundService()) {
        self.imagesRepository = imagesRepository
        self.removeBackgroundService = removeBackgroundService
        
        $currentImage.sink { [weak self] image in
            if image != nil {
                print("currentImageChanged")
                self?.imageState = .original
                self?.updateText()
            }
        }.store(in: &cancellables)
    }

    // MARK: - Request
    
    func processImage() {
        if let currentImage = currentImage {
            self.imageState = .processing
            removeBackgroundService.removeBackground(currentImage)
                .sink { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.errorMessage = "error.generic"
                        print(error)
                        self?.imageState = .processed(nil)
                        self?.updateText()
                    }
                } receiveValue: { [weak self] imageResult in
                    self?.currentImage = imageResult
                    self?.imageState = .processed(imageResult)
                    self?.updateText()
                }.store(in: &cancellables)
        }
    }
    
    // MARK: - UI related
    
    private func updateText() {
        switch imageState {
        case .initial:
            buttonText = "Photo Library"
        case .original:
            buttonText = "Remove background"
        case .processing:
            buttonText = "Processing Photo..."
        case .processed(let image):
            if image != nil {
                buttonText = "Finish"
            } else {
                buttonText = "Photo Library"
            }
        }
    }
    
}
