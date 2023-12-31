//
//  NetworkLayer.swift
//  PayPay
//
//  Created by Shreyansh Raj  Keshri on 07/12/23.
//  Copyright (c) 2023 SRK. All rights reserved.
//
//  This file was generated by the Shreyansh Raj Keshri 👾
//


import Foundation

final class NetworkLayerServices {
    let urlSession: URLSession
    private let configuration: URLSessionConfiguration
    
    init() {
        configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30.0
        configuration.httpAdditionalHeaders = ["Content-Type" : "application/json"]
        
        urlSession = URLSession(configuration: configuration)
    }
}
