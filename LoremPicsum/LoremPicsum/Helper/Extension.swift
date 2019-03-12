//
//  Extension.swift
//  LoremPicsum
//
//  Created by Mac Mini on 11/03/19.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class ImageDownloader: UIImageView {
    
    static func imageFromURL(_ URLString: String, placeHolder: UIImage?, cell: UITableViewCell) {
        
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            DispatchQueue.main.async {
                cell.imageView?.image = cachedImage
            }
            return
        }
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        cell.imageView?.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            cell.imageView?.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
