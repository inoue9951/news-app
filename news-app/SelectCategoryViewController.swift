//
//  SelectCategoryViewController.swift
//  news-app
//
//  Created by 井上裕太郎 on 2017/10/02.
//  Copyright © 2017年 inoue. All rights reserved.
//

import UIKit

class SelectCategoryViewController: UITableViewController {

    let categories = ["市場第一部（内国株）","市場第二部（内国株）","マザーズ（内国株）", "JASDAQ(グロース・内国株）",
                      "JASDAQ(スタンダード・内国株）","PRO Market"]
    
    var category: String!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = self.categories[indexPath.row]
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toStockList" {
            let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
            let stockListTableViewController = segue.destination as! StockListTableViewController
            stockListTableViewController.category = self.categories[indexPath.row]
        }
    }
    

}
