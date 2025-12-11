//
//  CameraPreview.swift
//  FoodVision
//
//  Created by Oğuzhan Erbaş on 9.12.2025.
//
//  Camera Preview'in amacı => AVCaptureVideoPreviewLayer → UIView → SwiftUI ekranına taşımak
//  Kamerayı SwiftUI’da gösteren yer (UIViewRepresentable)
//  SwiftUI bir kamera görüntüsünü direkt olarak gösteremez.
//  Çünkü kamera görüntüsü bir “layer”dır, SwiftUI layer gösteremez → sadece “View” gösterir.
//  ✔ Kamera görüntüsü önce UIKit tarafında üretilir
//  ✔ O görüntü bir UIView içine konur
//  ✔ UIView, UIViewRepresentable sayesinde SwiftUI’ya taşınır
import SwiftUI
import AVFoundation
//“SwiftUI, ben bir UIKit view’i sana getireceğim.
//Sen bunu kendi View’un gibi gösterebilirsin."
struct CameraPreview: UIViewRepresentable {
//    Bu kamera oturumu (session) bizim CameraService’den geliyor.
//    CameraPreview sadece bunu ekrana gösterecek.
    let session: AVCaptureSession
//    “UIKit tarafında bir UIView oluştur. Bana ver, ben göstereceğim.”
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
//        Bu satır kameranın canlı görüntüsünün gerçek ekranını oluşturur.
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
//        Bu “TikTok kamera görünümü” gibi görüntüyü büyütüp ekranı kaplatır.
        previewLayer.videoGravity = .resizeAspectFill
//        Görüntü ekranın tamamını kapsasın.”
        previewLayer.frame = UIScreen.main.bounds
//        Kamera görüntüsü artık UIKit tarafında görünür hale geldi.
        view.layer.addSublayer(previewLayer)
//        SwiftUI artık bu UIView’i bir View gibi gösterebilir.
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
