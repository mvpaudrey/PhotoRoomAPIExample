//
//  RemoveBackgroundService.swift
//  PhotoRoomAPIExample
//
//  Created by Audrey SOBGOU ZEBAZE on 08/11/2021.
//

import Foundation
import PhotoRoomKit

protocol RemoveBackgroundGateway {
    
}

final class RemoveBackgroundService: RemoveBackgroundGateway {
    
    private let segmentationService: SegmentationService = SegmentationService(apiKey: Constants.API_KEY)
    
    init() {
        
    }
    
}
