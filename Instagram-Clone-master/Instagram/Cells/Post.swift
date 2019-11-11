//
//  Post.swift
//  Instagram
//
//  Created by Anirudh V on 8/10/18.
//  Copyright © 2018 Anirudh V. All rights reserved.
//
import Foundation
import UIKit
import Parse

class Post: PFObject,PFSubclassing {
    @NSManaged var media : PFFile
    @NSManaged var author: PFUser
    @NSManaged var caption: String
    @NSManaged var likesCount: Int
    @NSManaged var commentsCount: Int
    
    /* Needed to implement PFSubclassing interface */
    class func parseClassName() -> String {
        return "Post"
    }
    
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // use subclass approach
        let post = Post()
        
        // Add relevant fields to the object
        post.media = getPFFileFromImage(image: image)! // PFFile column type
        post.author = PFUser.current()! // Pointer column type that points to PFUser
        post.caption = caption!
        post.likesCount = 0
        post.commentsCount = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
   
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImageJPEGRepresentation(image, 0.2) {
                return PFFile(name: "image.jpg", data: imageData)
            }
        }
        return nil
    }

}
