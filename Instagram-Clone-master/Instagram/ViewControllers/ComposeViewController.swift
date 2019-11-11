//
//  ComposeViewController.swift
//  Instagram
//
//  Created by Anirudh V on 8/11/18.
//  Copyright © 2018 Anirudh V. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var captionText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onChoose(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available ")
            vc.sourceType = .camera
        } else {
            print("Camera not available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        self.present(vc, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Do something with the images (based on your use case)
        imagePreview.image = originalImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func uploadImage(_ sender: Any) {
    
            Post.postUserImage(image: imagePreview.image, withCaption: captionText.text) { (bool, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        
    }
    

}
    

    

