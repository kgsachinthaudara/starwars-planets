//
//  ImageView.swift
//  StarWarsPlanets
//
//  Created by Sachintha on 2021-11-14.
//

import Foundation
import Combine
import SwiftUI

struct ImageView: View {
    let url: String
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    
    @ObservedObject var imageLoader = ImageLoaderService()
        @State var image: UIImage = UIImage()
        
        var body: some View {
            let finalizedUrl = "\(url)/\(Int(width))/\(Int(height))"
            
            return Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:width, height:height)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .shadow(radius: 10)
                .onReceive(imageLoader.$image) { image in
                    self.image = image
                }
                .onAppear {
                    imageLoader.loadImage(for: finalizedUrl)
                }
        }
}
