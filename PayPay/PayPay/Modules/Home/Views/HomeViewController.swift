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
    @IBOutlet weak var topMenuButton: AutoAddPaddingButtton!
    @IBOutlet weak var bottomMenuButton: AutoAddPaddingButtton!
    
    let viewModel: HomeViewModelProtocol = HomeViewModel.builder()
    var menuChildren: [UIMenuElement] = []
    var topSelectedMenuValue: String = ""
    var bottomSelectedMenuValue: String = ""
    let topActionClosure = { (action: UIAction) in
        print(action.title)
    }
    let bottomActionClosure = { (action: UIAction) in
        print(action.title)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI() 
        setupCurrencyMenu()
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
    
    func setupCurrencyMenu() {
        [topMenuButton, bottomMenuButton].forEach { button in
            button?.layer.cornerRadius = 5.0
            button?.layer.borderColor = UIColor.white.cgColor
            button?.layer.borderWidth = 1.0
            button?.layer.masksToBounds = true
            button?.tintColor = .white
            button?.setTitleColor(.white, for: .normal)
        }
        
        viewModel.getAllCurrency { [weak self] menuDataSource in
            guard let self = self else { return }
            
            for currency in menuDataSource.keys {
                self.menuChildren.append(UIAction(title: currency, handler: topActionClosure))
            }
            
            DispatchQueue.main.async {
                [self.topMenuButton, self.bottomMenuButton].forEach { button in
                    button?.menu = UIMenu(options: .displayInline, children: self.menuChildren)
                    button?.showsMenuAsPrimaryAction = true
                    button?.changesSelectionAsPrimaryAction = true
                }
            }
        }
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
        guard let value = sender.text, let amount = Double(value) else { return }
        
        viewModel.convert(from: "USD", to: "INR", amount: amount) { value in
            DispatchQueue.main.async {
                self.bottomTextField.text = value.formatted(.currency(code: "INR"))
            }
        }
    }
    
    
    @IBAction func BottomTextFieldEditingChanged(_ sender: UITextField) {
        guard let value = sender.text, let amount = Double(value) else { return }

        viewModel.convert(from: "INR", to: "USD", amount: amount) { value in
            DispatchQueue.main.async {
                self.topTextField.text = value.formatted(.currency(code: "USD"))
            }
        }
    }
    
}
