//
//  BrandListTableViewController.swift
//  news-app
//
//  Created by 井上裕太郎 on 2017/10/01.
//  Copyright © 2017年 inoue. All rights reserved.
//

import UIKit
import SwiftyJSON

class StockListTableViewController: UITableViewController {
    
    var apiAccesser: apiAccess!
    var category: String!

    var stockList: JSON = []
    var cellNum = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue(label: "api access").async {
            self.apiAccesser = apiAccess()
            let data = self.apiAccesser.getStockList(category: self.category)
            DispatchQueue.main.async {
                self.stockList = data.list
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
        // #warning Incomplete implementation, return the number of rows
        return self.cellNum
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "なし"
        if self.stockList.count > 0 {
            cell.textLabel?.text = self.stockList["list"][indexPath.row]["name"].stringValue
        }
        return cell
    }

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewsList" {
            let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
            let newsListTableViewController = segue.destination as! NewsListTableViewController
            newsListTableViewController.stockName = self.stockList["list"][indexPath.row]["name"].stringValue
        }
    }
}
