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

    func getPhoto(
        by path: String,
        runQueue: DispatchQueue,
        completionQueue: DispatchQueue,
        completion: @escaping (UIImage?) -> ()
    ) {}
}
