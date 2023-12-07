//
//  BaseViewController.swift
//  PayPay
//
//  Created by Shreyansh Raj  Keshri on 07/12/23.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
    }
    
    
    func setNavBar(title value: String, prefersLargeTitles: Bool = false) {
        title = value
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        standardAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        // prevent Nav Bar color change on scroll view push behind NavBar
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = .black

        self.navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }
    
}
