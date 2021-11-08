//
//  RemoveBackgroundService.swift
//  PhotoRoomAPIExample
//
//  Created by Audrey SOBGOU ZEBAZE on 08/11/2021.
//

import Foundation
import PhotoRoomKit
import SwiftUI
import Combine

enum RemoveBackgroundServiceError: Error {
    case segmentationFailed
    case noImageReturned
}

protocol RemoveBackgroundGateway {
    func removeBackground(_ originalImage: UIImage) -> AnyPublisher<UIImage, RemoveBackgroundServiceError>
}

final class RemoveBackgroundService: RemoveBackgroundGateway {
    
    private let segmentationService: SegmentationService
    
    init(segmentationService: SegmentationService = SegmentationService(apiKey: Constants.API_KEY)) {
        self.segmentationService = segmentationService
    }
    
    func removeBackground(_ originalImage: UIImage) -> AnyPublisher<UIImage, RemoveBackgroundServiceError> {
        Deferred {
            Future<UIImage, RemoveBackgroundServiceError> { promise in
                self.segmentationService.segment(image: originalImage) { (image, error) in
                    DispatchQueue.main.async {
                        if error != nil {
                            promise(.failure(.segmentationFailed))
                        }
                        guard let image = image else {
                            // No image returned
                            promise(.failure(.noImageReturned))
                            return
                        }
                        // All good
                        promise(.success(image))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
}
