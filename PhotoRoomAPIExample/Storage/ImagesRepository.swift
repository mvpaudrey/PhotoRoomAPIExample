//
//  ImagesRepository.swift
//  PhotoRoomAPIExample
//
//  Created by Audrey SOBGOU ZEBAZE on 08/11/2021.
//

import Foundation
import UIKit

protocol ImagesRepositoryGateway {
    
    func getCachedImages() -> [UIImage]
}

final class ImagesRepository: ImagesRepositoryGateway {
    
    func getCachedImages() -> [UIImage] {
        []
    }
}
