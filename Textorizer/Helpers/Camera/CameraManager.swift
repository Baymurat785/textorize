//
//  CameraManager.swift
//  Textorizer
//
//  Created by Baymurat Abdumuratov on 30/01/25.
//

import UIKit
import AVFoundation


class CameraManager: NSObject, ObservableObject {}

extension CameraManager {
    func checkPermissions() throws {
        if AVCaptureDevice.authorizationStatus(for: .video) == .denied { throw Error.cameraPermissionsNotGranted }
    }
}

extension CameraManager { enum Error: Swift.Error {
    case cameraPermissionsNotGranted
}}
