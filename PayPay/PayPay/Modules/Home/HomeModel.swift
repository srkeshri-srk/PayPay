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


// MARK: - Currency
struct CurrencyModel: Codable {
    let success: Bool?
    let symbols: [String: String]?
}

