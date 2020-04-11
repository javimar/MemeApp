//
//  SentMemesTableViewController.swift
//  JaviMarMemes
//
//  Created by Javi on 10/04/2020.
//  Copyright © 2020 JaviMar. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    // MARK: Defitions
    @IBOutlet weak var tableView: UITableView!
    
    // Fetch the memes stored in the app delegate
    var memes = [Meme]()
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
     
    // MARK: App LifeCycle
    
    override func viewDidLoad()
    {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        memes = appDelegate.memes
        tableView.reloadData()
        navigationItem.title = "Sent Memes Table"
    }
    
    
    // MARK: TableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let memeItem = memes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell", for: indexPath) as! MemeTableViewCell
        // Call the method in TableViewCell to set the values
        cell.setMemeTableItem(memeItem: memeItem)
        return cell
    }
    
        
    // Open detail view of the meme being clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let detailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        // pass the meme to the DC
        detailController.meme = memes[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }

}
