//
//  ShapeClassifierProvider.swift
//  MyMagicalHand
//
//  Created by 김찬우 on 2021/08/19.
//

import UIKit
import CoreML
import Vision
import ImageIO

class ShapeClassifierProvider {
    var resultTexts: [String]?

    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: ShapeClassifier().model)

            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .scaleFill
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()

    func updateClassifications(for image: UIImage, completion: @escaping () -> Void) {
        guard let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue)) else {
            return
        }

        guard let ciImage = CIImage(image: image) else {
            fatalError("Unable to create \(CIImage.self) from \(image).")
        }

        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
                completion()
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }

    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                return
            }

            guard let classifications = results as? [VNClassificationObservation] else {
                return
            }

            if !classifications.isEmpty {
                let topClassification = classifications[0]
                let percentage = String(format: "%.1f", topClassification.confidence * 100)
                let result = String(topClassification.identifier) + "처럼 보이네요"
                self.resultTexts = [percentage, result]
            }
        }
    }
}
