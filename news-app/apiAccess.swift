//
//  apiAccess.swift
//  news-app
//
//  Created by 井上裕太郎 on 2017/10/05.
//  Copyright © 2017年 inoue. All rights reserved.
//

import Foundation
import SwiftyJSON

class apiAccess {

    let ip: String = "192.168.179.6"
    let port: String = "3000"

    func createUrl(urlString :String, queryString: String) -> String {
        let encodeUrl = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let encodeQuery = queryString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        return encodeUrl + "?" + encodeQuery
    }

    func getStockList(category :String) -> (list: JSON, listSize: Int) {
        let urlString = "http://\(self.ip):\(self.port)/api/stocks"
        let queryString = "category=" + category
        let url: URL = URL(string: createUrl(urlString: urlString, queryString: queryString))!
        let data = self.access(url: url)
        return (data.list, data.listSize)
    }
    
    func getNews(stockName: String) -> (list: JSON, listSize: Int) {
        let urlString = "http://\(self.ip):\(self.port)/api/news"
        let queryString = "stock_name=" + stockName
        let url: URL = URL(string: createUrl(urlString: urlString, queryString: queryString))!
        let data = self.access(url: url)
        return (data.list, data.listSize)
    }
    
    func access(url: URL) -> (list: JSON, listSize: Int){
       //値を保存する変数を定義
        var stockList: JSON = []
        var listSize: Int = 0
        //apiアクセス完了まで待つ
        let semaphore = DispatchSemaphore(value: 0)
        //apiアクセス
        let request: httpRequest = httpRequest()
        request.get(url: url, completionHandler: { data, response, error in
            if data != nil && response != nil {
                print("exist data!")
                stockList = JSON(data: data!)
                listSize = stockList["list"].count
            } else if error != nil {
                print("error!")
                print(error!)
            }
            semaphore.signal()
        })
        semaphore.wait()
        return (stockList, listSize)
    }

}

