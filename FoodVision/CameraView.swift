//
//  CameraView.swift
//  FoodVision
//
//  Created by Oğuzhan Erbaş on 9.12.2025.
//
import SwiftUI

struct CameraView: View {

    @State private var capturedImage: UIImage? = nil
    @State private var showPreview = false
    let camera = CameraService()

    var body: some View {
        ZStack {
            CameraPreview(session: camera.session)
                .ignoresSafeArea()

            VStack {
                Text("FoodNap")
                    .foregroundColor(.green)
                    .bold()
                    .font(.system(size: 40))
                Spacer()

                Button {
                    camera.takePhoto()
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 80, height: 80)
                        Image(systemName: "camera")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            camera.onPhotoCaptured = { image in
                self.capturedImage = image
                self.showPreview = true
            }
            camera.start()
        }
        // ❗ fullScreenCover burada olmalı
        .fullScreenCover(isPresented: $showPreview) {
            if let img = capturedImage {
                PhotoPreviewView(image: img)
            }
            
        }
        // ❗ fullScreenCover burada olmalı
        .fullScreenCover(isPresented: $showPreview) {
            if let img = capturedImage {
                PhotoPreviewView(image: img)
            }
        }
        .onChange(of: showPreview, initial: false) { newValue in
            if newValue == true {
                print("🔥 Preview açıldı → Kamera durduruluyor")
                camera.stop()
            } else {
                print("📸 Preview kapandı → Kamera yeniden başlatılıyor")
                camera.start()
            }
        }
        }
    }
    
}
