//
//  PreviewView.swift
//  PhotoRoomAPIExample
//
//  Created by Audrey SOBGOU ZEBAZE on 09/11/2021.
//

import SwiftUI

struct PreviewView: View {
    
    @Binding var imageState: ImageState
    
    @Binding var text: String
    
    var action: () -> Void = {}
    
    var blurAmount: CGFloat = 1
    
    @Binding var image: UIImage?
    
    public init(image: Binding<UIImage?>,
                imageState: Binding<ImageState>,
                text: Binding<String>,
                action: @escaping () -> Void) {
        self._image = image
        self._imageState = imageState
        self._text = text
        self.action = action
    }
    
    var body: some View {
        
        VStack {
            if let image = image {
                ZStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    if imageState == .processing {
                        ZStack {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .edgesIgnoringSafeArea(.all)
                                .blur(radius: 0.2)
                            if #available(iOS 15.0, *) {
                                VStack {
                                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                                    Text("Processing")
                                        .font(.title)
                                        .fontWeight(.black)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(.ultraThinMaterial)
                                        .multilineTextAlignment(.center)
                                }
                            } else {
                                VStack {
                                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                                    Text("Processing")
                                        .font(.title)
                                        .fontWeight(.black)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                }
                            }

                        }
                    }
                }
                
            } else {
                Spacer()
            }
           
            Button(action: action) {
                HStack {
                    Image(systemName: "photo")
                        .font(.system(size: 20))
                    
                    Text(text)
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }
        }.padding()
    }
}

struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView(image: .constant(UIImage(systemName: "photo")!),
                    imageState: .constant(.processing),
                    text: .constant("Processing background")) {
            print("Did something")
        }
    }
}
