//
//  httpRequest.swift
//  news-app
//
//  Created by 井上裕太郎 on 2017/10/01.
//  Copyright © 2017年 inoue. All rights reserved.
//

import Foundation

class httpRequest {
    let session: URLSession = URLSession.shared
    func get(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request: URLRequest = URLRequest(url: url)

        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("applicatoin/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: request, completionHandler: completionHandler).resume()
    }
}


