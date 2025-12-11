//
//  PhotoPreviewView.swift
//  FoodVision
//
//  Created by Oğuzhan Erbaş on 10.12.2025.
//
//
//  PhotoPreviewView.swift
//

import SwiftUI

struct PhotoPreviewView: View {
    
    let image: UIImage
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                // FOTOĞRAFI GÖSTER
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .padding()

                Spacer()

                // GERİ DÖNME BUTONU
                Button(action: {
                    dismiss()
                }) {
                    Text("Kameraya Geri Dön")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(12)
                }
                .padding(.bottom, 40)
            }
        }
    }
}
