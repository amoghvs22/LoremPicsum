//
//  ViewController.swift
//  LoremPicsum
//
//  Created by Mac Mini on 11/03/19.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var picsumTableView: UITableView!
    
    var currentPage = 1
    var infoArray = [Info]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getUserDetails()
        self.picsumTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
        
    
    //MARK:- API call to get random users
    func getUserDetails() {
        ApiHandler.getUserDetails(page: String(currentPage)) { [unowned self] (response, error, data) in
            if error == nil {
                guard let decodedObj = UserModel.initializeModel(userData: data!) else { return }
                print(decodedObj)
                self.infoArray.append(contentsOf: decodedObj.results)
                DispatchQueue.main.async {
                    self.picsumTableView.reloadData()
                }
            }
            else {
                let alert = UIAlertController.init(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //MARK:- Navigation to image controller
    func loadImageController(_ imageURL: String) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ImageController") as? ImageViewController else { return }
        controller.imageURL = imageURL
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK:- TableView implementation
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let info = infoArray[indexPath.row]
        cell.textLabel?.text = info.name.first + " " + info.name.last
        cell.imageView?.image = UIImage(named: "picsum")
        
        ImageDownloader.imageFromURL(info.picture.medium, placeHolder: nil, cell: cell)
        
        if indexPath.row == infoArray.count - 1 {
            currentPage += 1
            self.getUserDetails()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let imageURL = infoArray[indexPath.row].picture.large
        loadImageController(imageURL)
    }
}

