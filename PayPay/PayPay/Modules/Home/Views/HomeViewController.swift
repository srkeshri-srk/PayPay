//
//  HomeViewController.swift
//  PayPay
//
//  Created by Shreyansh Raj  Keshri on 07/12/23.
//

import UIKit

class HomeViewController: BaseViewController {
        
    @IBOutlet weak var swapButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()        
    }
    
    private func setupUI() {
        setNavBar(title: Constants.Home.navBarTitle, prefersLargeTitles: true)
        swapButton.layer.cornerRadius = 5.0
        swapButton.layer.masksToBounds = true
    }
    
    @IBAction func swapButtonAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            if sender.transform == .identity {
                self.swapButton.transform = CGAffineTransform(rotationAngle: .pi)
            } else {
                self.swapButton.transform = .identity
            }
        }
    }
        
}
