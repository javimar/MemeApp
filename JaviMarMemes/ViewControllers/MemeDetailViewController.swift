//
//  MemeDetailViewController.swift
//  JaviMarMemes
//
//  Created by Javi on 10/04/2020.
//  Copyright © 2020 JaviMar. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController
{
    var meme: Meme! = nil
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        imageView.image = meme.memedImage
    }
    
    @IBAction func cancelAction(sender: UIBarButtonItem)
    {
        dismiss(animated: true, completion: nil)
    }
}
