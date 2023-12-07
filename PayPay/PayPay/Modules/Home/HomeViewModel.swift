//
//  HomeViewModel.swift
//  PayPay
//
//  Created by Shreyansh Raj  Keshri on 07/12/23.
//

import Foundation


protocol HomeViewModelProtocol {
    static func builder() -> HomeViewModel
    func convert(from: String, to: String, amount: Double, completion: @escaping (Double)->Void)
}

class HomeViewModel: HomeViewModelProtocol {
    //MARK: - Variables
    let networkLayer = NetworkLayerServices()
    let converterURL: URL?
    
    init(url: URL?) {
        converterURL = url
    }
    
    //MARK: - Methods
    func convert(from: String, to: String, amount: Double, completion: @escaping (Double) -> Void) {
        guard let url = converterURL else {
            completion(0.0)
            return
        }

        let headerParams = ["X-RapidAPI-Key": "ba86276271mshd07c0a18f90dd93p15d8a0jsn92b0d4e8e6cc",
                            "X-RapidAPI-Host": "currency-conversion-and-exchange-rates.p.rapidapi.com"]
        
        let queryParams: [String: Any] = ["from": from,
                                          "to": to,
                                          "amount": amount]
        
        let apiRequest = APIRequest(url: url, method: .GET, headers: headerParams, queryParams: queryParams, body: nil)
        
        networkLayer.dataTask(apiRequest) { (_ result: Result<HomeModel, NetworkError>) in
            switch result {
            case .success(let value):
                print(value)
                completion(value.result ?? 0.0)
            case .failure(let error):
                print(error)
                completion(0.0)
            }
        }
    }
}

extension HomeViewModel {
    static func builder() -> HomeViewModel {
        let homeVM = HomeViewModel(url: URL(string: "https://currency-conversion-and-exchange-rates.p.rapidapi.com/convert"))
        return homeVM
    }
}
