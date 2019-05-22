//
//  RedditPostViewController.swift
//  Reddit-ObjC
//
//  Created by Kaden Hendrickson on 5/22/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class RedditPostViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        KHERedditPostController.shared().fetchPosts { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("didn't fetch posts")
            }
        }

    }

}

extension RedditPostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return KHERedditPostController.shared().posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "redditPostCell", for: indexPath)
        let post = KHERedditPostController.shared().posts[indexPath.row]
        cell.textLabel?.text = post.title
        KHERedditPostController.shared().fetchImage(for: post) { (image) in
            DispatchQueue.main.async {
                cell.imageView?.image = image
            }
        }
    
        return cell
    }
    
}
