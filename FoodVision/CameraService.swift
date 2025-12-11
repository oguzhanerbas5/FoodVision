//
//  CameraService.swift
//  FoodVision
//

//
//  CameraService.swift
//  FoodVision
//

import AVFoundation
import UIKit

class CameraService: NSObject, AVCapturePhotoCaptureDelegate {

    let session = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()

    // Fotoğraf çekildiğinde UI’a geri göndermek için callback
    var onPhotoCaptured: ((UIImage) -> Void)?

    override init() {
        super.init()
        configureSession()
    }

    private func configureSession() {
        session.beginConfiguration()

        // 1) Kamera (arka)
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                   for: .video,
                                                   position: .back)
        else { return }

        // 2) Input oluştur
        guard let input = try? AVCaptureDeviceInput(device: device) else { return }

        // 3) Input ekle
        if session.canAddInput(input) {
            session.addInput(input)
        }

        // 4) PhotoOutput ekle
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
        }

        session.commitConfiguration()
    }

    // Kamera başlat
    func start() {
        session.startRunning()
    }

    // Kamera durdur
    func stop() {
        session.stopRunning()
    }

    // ⭐ FOTOĞRAF ÇEKEN FONKSİYON ⭐
    func takePhoto() {
        let settings = AVCapturePhotoSettings()

        photoOutput.capturePhoto(with: settings, delegate: self)
    }

    // ⭐ ÇEKİLEN FOTOĞRAFI ALDIĞIMIZ YER ⭐
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {

        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else {
            return
        }
        print("📸 PHOTO DATA SIZE:", data.count)
        print("📸 UIIMAGE:", image)

        // Fotoğrafı dışarı gönder (SwiftUI tarafına)
        onPhotoCaptured?(image)
    }
}
