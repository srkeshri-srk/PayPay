//
//  HomeViewModel.swift
//  PayPay
//
//  Created by Shreyansh Raj  Keshri on 07/12/23.
//

import Foundation


protocol HomeViewModelProtocol {
    static func builder() -> HomeViewModel
    func convert(from: String, to: String, value: Float)
}

class HomeViewModel: HomeViewModelProtocol {
    //MARK: - Variables
    let networkLayer = NetworkLayerServices()
    let converterURL: URL?
    
    init(url: URL?) {
        converterURL = url
    }
    
    //MARK: - Methods
    func convert(from: String, to: String, value: Float) {
        print(from, to, value)
    }
}

extension HomeViewModel {
    static func builder() -> HomeViewModel {
        let homeVM = HomeViewModel(url: URL(string: "https://currency-conversion-and-exchange-rates.p.rapidapi.com/convert"))
        return homeVM
    }
}
