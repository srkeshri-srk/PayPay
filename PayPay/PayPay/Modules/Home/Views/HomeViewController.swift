//
//  HomeViewController.swift
//  PayPay
//
//  Created by Shreyansh Raj  Keshri on 07/12/23.
//

import UIKit

class HomeViewController: BaseViewController {
        
    @IBOutlet weak var swapButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    let homeVM: HomeViewModelProtocol = HomeViewModel.builder()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI() 
    }
    
    private func setupUI() {
        setNavBar(title: Constants.Home.navBarTitle, prefersLargeTitles: true)
        swapButton.layer.cornerRadius = 5.0
        swapButton.layer.masksToBounds = true
        
        topView.backgroundColor = .vistaBlue
        bottomView.backgroundColor = .cadetGrey
        swapButton.backgroundColor = .khaki
        swapButton.tintColor = .black
        
        topTextField.setupUnderLine()
        bottomTextField.setupUnderLine()
        
        topTextField.placeholder = "USD"
        bottomTextField.placeholder = "INR"
    }
    
    @IBAction func swapButtonAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            if sender.transform == .identity {
                self.swapButton.transform = CGAffineTransform(rotationAngle: .pi)
            } else {
                self.swapButton.transform = .identity
            }
        }
        
        let topTFTextValue = topTextField.text
        let bottomTFTextValue = bottomTextField.text
        let topTFPlaceholder = topTextField.placeholder
        let bottomTFPlaceholder = bottomTextField.placeholder
        
        topTextField.text = bottomTFTextValue
        bottomTextField.text = topTFTextValue
        topTextField.placeholder = bottomTFPlaceholder
        bottomTextField.placeholder = topTFPlaceholder
    }
    
    @IBAction func topTextFieldEditingChanged(_ sender: UITextField) {
        homeVM.convert(from: "USD", to: "INR", amount: 100.0) { value in
            DispatchQueue.main.async {
                self.bottomTextField.text = value.formatted(.currency(code: "INR"))
            }
        }
    }
    
    
    @IBAction func BottomTextFieldEditingChanged(_ sender: UITextField) {
        homeVM.convert(from: "INR", to: "USD", amount: 100.0) { value in
            DispatchQueue.main.async {
                self.topTextField.text = value.formatted(.currency(code: "USD"))
            }
        }
    }
    
}
