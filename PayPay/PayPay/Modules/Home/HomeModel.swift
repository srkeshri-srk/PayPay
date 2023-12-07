//
//  HomeModel.swift
//  PayPay
//
//  Created by Shreyansh Raj  Keshri on 07/12/23.
//

import Foundation

// MARK: - HomeModel
struct HomeModel: Codable {
    let success: Bool?
    let query: Query?
    let info: Info?
    let date: String?
    let result: Double?
}

// MARK: - Info
struct Info: Codable {
    let timestamp: Int?
    let rate: Double?
}

// MARK: - Query
struct Query: Codable {
    let from, to: String?
    let amount: Int?
}


//{
//    "success": true,
//    "query": {
//        "from": "USD",
//        "to": "INR",
//        "amount": 100
//    },
//    "info": {
//        "timestamp": 1701944103,
//        "rate": 83.354967
//    },
//    "date": "2023-12-07",
//    "result": 8335.4967
//}
