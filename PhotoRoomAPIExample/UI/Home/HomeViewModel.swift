//
//  HomeViewModel.swift
//  PhotoRoomAPIExample
//
//  Created by Audrey SOBGOU ZEBAZE on 08/11/2021.
//

import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @Published var processFinished: Bool = false
    
    @Published var retouchedPhotos: [UIImage] = []
}
