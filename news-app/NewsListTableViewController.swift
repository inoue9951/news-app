//
//  BrandNewsTableViewController.swift
//  news-app
//
//  Created by 井上裕太郎 on 2017/10/06.
//  Copyright © 2017年 inoue. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsListTableViewController: UITableViewController {
    
    var apiAccesser: apiAccess!
    var stockName: String!

    var news: JSON = []
    var cellNum = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue(label: "api access").async {
            self.apiAccesser = apiAccess()
            let data = self.apiAccesser.getNews(stockName: self.stockName)
            DispatchQueue.main.async {
                self.news = data.list
                self.cellNum = data.listSize
                print("call reloadData")
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellNum
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
        cell.textLabel?.text = "なし"
        if self.news.count > 0 {
            cell.textLabel?.text = self.news["list"][indexPath.row]["title"].stringValue
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNews" {
            let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
            let newsViewController = segue.destination as! NewsViewController
            newsViewController.url = self.news["list"][indexPath.row]["url"].stringValue
        }
    }
}
