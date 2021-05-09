//
//  PhotoLoader.swift
//  Movies
//
//  Created by User on 09.05.2021.
//

import Alamofire
import Foundation
import UIKit

protocol PhotoLoaderProtocol {
    func getPhoto(
        by path: String,
        runQueue: DispatchQueue,
        completionQueue: DispatchQueue,
        completion: @escaping (UIImage?) -> ()
    )
}

final class PhotoLoader: PhotoLoaderProtocol {
    private var images: [String: UIImage] = [:]
    private let cacheLifetime: TimeInterval = 60 * 60 * 24 * 7

    private static let pathName: String = {
        let pathName = "images"
        guard let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return pathName }
        let url = cacheDir.appendingPathComponent(pathName, isDirectory: true)

        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()

    private func getFilePath(path: String) -> String? {
        guard let cachDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }
        let hashName = String(describing: path.hashValue)
        return cachDir.appendingPathComponent(PhotoLoader.pathName + "/" + hashName).path
    }

    private func saveImageToCache(path: String, image: UIImage) {
        guard let filePath = getFilePath(path: path) else { return }
        let date = image.pngData()
        FileManager.default.createFile(atPath: filePath, contents: date, attributes: nil)
    }

    private func getImageFromCache(path: String) -> UIImage? {
        guard let fileName = getFilePath(path: path),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[.modificationDate] as? Date else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard lifeTime <= cacheLifetime,
              let image = UIImage(contentsOfFile: fileName) else { return nil }
        images[path] = image
        return image
    }

    private func loadPhoto(
        by path: String,
        runQueue: DispatchQueue,
        completionQueue: DispatchQueue,
        completion: @escaping (UIImage?) -> ()
    ) {
        let baseImageURL = "https://image.tmdb.org/t/p/w500"
        AF.request(baseImageURL + path).responseData(queue: runQueue) { [weak self] response in
            completionQueue.async {
                switch response.result {
                case let .success(data):
                    guard let image = UIImage(data: data) else { return }
                    self?.saveImageToCache(path: path, image: image)
                    completion(image)
                case let .failure(error):
                    print("ERROR LOAD PHOTO: \(error.localizedDescription)")
                }
            }
        }
    }

    func getPhoto(
        by path: String,
        runQueue: DispatchQueue,
        completionQueue: DispatchQueue,
        completion: @escaping (UIImage?) -> ()
    ) {
        if let photo = images[path] {
            completion(photo)
        } else if let photo = getImageFromCache(path: path) {
            completion(photo)
        } else {
            loadPhoto(by: path, runQueue: runQueue, completionQueue: completionQueue, completion: completion)
        }
    }
}
