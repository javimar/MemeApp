//
//  MemeCollectionViewController.swift
//  JaviMarMemes
//
//  Created by Javi on 06/04/2020.
//  Copyright © 2020 JaviMar. All rights reserved.
//

import UIKit


@available(iOS 13.0, *)
class SentMemesCollectionViewController: UICollectionViewController
{
    
    // MARK: Declarations
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // Fetch the memes stored in the app delegate
    var memes = [Meme]()
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    // MARK: LifeCycle
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        		memes = appDelegate.memes
        navigationItem.title = "Sent Memes Collection"
        collectionView?.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setCellsLayout()
    }
        
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let memeItem = self.memes[(indexPath as NSIndexPath).row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        
        // Set the name and image
        cell.memeImageView.image = memeItem.memedImage
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController

        // Populate view controller with data from the selected item
        detailController.meme = memes[indexPath.row]

        // Present the view controller using navigation
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    
    // MARK: Cells LayOut
    struct Constants
    {
        static let CellVerticalSpacing: CGFloat = 2
    }
    
    func setCellsLayout()
    {
        var cellWidth: CGFloat
        var width: CGFloat
        
        switch UIDevice.current.orientation
        {
            case .portrait:
                    width = 3
            case .portraitUpsideDown:
                    width = 3
            case .landscapeLeft:
                    width = 4
            case .landscapeRight:
                    width = 4
            default:
                    width = 4
        }
        cellWidth = collectionView!.frame.width / width
        
        cellWidth -= Constants.CellVerticalSpacing
        flowLayout.itemSize.width = cellWidth
        flowLayout.itemSize.height = cellWidth
        flowLayout.minimumInteritemSpacing = Constants.CellVerticalSpacing
        
        
        let actualCellVerticalSpacing: CGFloat = (collectionView!.frame.width - (width * cellWidth))/(width - 1)
        flowLayout.minimumLineSpacing = actualCellVerticalSpacing
    
        flowLayout.invalidateLayout()
    }
}
