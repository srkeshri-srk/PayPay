//
//  HomeViewModel.swift
//  PayPay
//
//  Created by Shreyansh Raj  Keshri on 07/12/23.
//

import Foundation


protocol HomeViewModelProtocol {
    var menuDataSource: [String: String]? { get }

    static func builder() -> HomeViewModel
    func convert(from: String, to: String, amount: Double, completion: @escaping (Double)->Void)
    func getAllCurrency(completion: @escaping ([String: String]) -> Void)
}

class HomeViewModel: HomeViewModelProtocol {
    //MARK: - Variables
    let networkLayer = NetworkLayerServices()
    let converterURL: URL?
    let currencyURL: URL?
    var menuDataSource: [String: String]? = ["USD": "", "INR": ""]
    let headerParams = ["X-RapidAPI-Key": "ba86276271mshd07c0a18f90dd93p15d8a0jsn92b0d4e8e6cc",
                        "X-RapidAPI-Host": "currency-conversion-and-exchange-rates.p.rapidapi.com"]
    
    init(converterURL: URL?, currencyURL: URL?) {
        self.converterURL = converterURL
        self.currencyURL = currencyURL
    }
    
    //MARK: - Methods
    func convert(from: String, to: String, amount: Double, completion: @escaping (Double) -> Void) {
        guard let url = converterURL else {
            completion(0.0)
            return
        }
        
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
    
    func getAllCurrency(completion: @escaping ([String: String]) -> Void) {
        guard let url = currencyURL else {
            completion(["USD": "", "INR": ""])
            return
        }

        let apiRequest = APIRequest(url: url, method: .GET, headers: headerParams, queryParams: nil, body: nil)
        
        networkLayer.dataTask(apiRequest) { (_ result: Result<CurrencyModel, NetworkError>) in
            switch result {
            case .success(let value):
                self.menuDataSource = value.symbols
                completion(value.symbols ?? ["USD": "", "INR": ""])
            case .failure(let error):
                print(error)
                completion(["USD": "", "INR": ""])
            }
        }
    }

}

extension HomeViewModel {
    static func builder() -> HomeViewModel {
        let homeVM = HomeViewModel(converterURL: URL(string: "https://currency-conversion-and-exchange-rates.p.rapidapi.com/convert"), currencyURL: URL(string: "https://currency-conversion-and-exchange-rates.p.rapidapi.com/symbols"))
        return homeVM
    }
}
