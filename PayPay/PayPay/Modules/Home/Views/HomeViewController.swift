//
//  HomeViewController.swift
//  PayPay
//
//  Created by Shreyansh Raj  Keshri on 07/12/23.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        setNavBar(title: "PayPay", prefersLargeTitles: true)
    }
    
}
