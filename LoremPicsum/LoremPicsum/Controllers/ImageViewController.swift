//
//  ImageViewController.swift
//  LoremPicsum
//
//  Created by Mac Mini on 11/03/19.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var picsumImageView: UIImageView!

    var imageURL:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ApiHandler.fetchImage(url: imageURL) { (response, error, data) in
            if error == nil {
                DispatchQueue.main.async {
                    self.picsumImageView.image = UIImage(data: data!)
                }
            }
            else {
                let alert = UIAlertController.init(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
