//
//  ViewController.swift
//  XMLParserExample
//
//  Created by Lal Prasad, Ratan on 6/15/17.
//  Copyright © 2017 Nusoma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var listOfNewsVM = [XMLParserVM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Apple News Feed"
        fetchXMLData()
    }
    
    func fetchXMLData() {
        XMLParserFactory.fetchData(url: "https://developer.apple.com/news/rss/news.rss") { (listOfXMLVM, error) in
            
            print("Fetch xml data")
            if error == nil {
                self.listOfNewsVM = listOfXMLVM!
                self.tableView.reloadData()
            }
            else {
                print(error?.localizedDescription ?? "Error")
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfNewsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        
        let cell:UITableViewCell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "reuseIdentifier")
        let newsVM = listOfNewsVM[indexPath.row]
        cell.textLabel?.text = newsVM.title
        cell.detailTextLabel?.text = newsVM.pubDate
        return cell
    }
}

