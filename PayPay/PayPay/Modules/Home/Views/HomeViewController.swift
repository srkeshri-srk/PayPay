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
    var topMenuElements: [UIMenuElement] = []
    var bottomMenuElements: [UIMenuElement] = []
    var topSelectedMenuValue: String = ""
    var bottomSelectedMenuValue: String = ""
    
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
        topTextField.placeholder = "..."
        bottomTextField.placeholder = "..."
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
                        
            for currency in menuDataSource.keys.sorted() {
                if self.topSelectedMenuValue.isEmpty {
                    self.topSelectedMenuValue = currency
                    self.updateUI()
                }
                
                if self.bottomSelectedMenuValue.isEmpty {
                    self.bottomSelectedMenuValue = currency
                    self.updateUI()
                }
                
                self.topMenuElements.append(UIAction(title: currency, handler: { action in
                    self.topSelectedMenuValue = action.title
                    self.updateUI()
                }))
                
                self.bottomMenuElements.append(UIAction(title: currency, handler: { action in
                    self.bottomSelectedMenuValue = action.title
                    self.updateUI()
                }))
            }
            
            DispatchQueue.main.async {
                self.topMenuButton.menu = UIMenu(options: .displayInline, children: self.topMenuElements)
                self.topMenuButton.showsMenuAsPrimaryAction = true
                self.topMenuButton.changesSelectionAsPrimaryAction = true
                
                self.bottomMenuButton.menu = UIMenu(options: .displayInline, children: self.bottomMenuElements)
                self.bottomMenuButton.showsMenuAsPrimaryAction = true
                self.bottomMenuButton.changesSelectionAsPrimaryAction = true
            }
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.topTextField.placeholder = self.topSelectedMenuValue
            self.bottomTextField.placeholder = self.bottomSelectedMenuValue
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
        let topSelected = topSelectedMenuValue
        let bottomSelected = bottomSelectedMenuValue
        
        topTextField.text = bottomTFTextValue
        bottomTextField.text = topTFTextValue
        topSelectedMenuValue = bottomSelected
        bottomSelectedMenuValue = topSelected
        updateUI()
    }
    
    @IBAction func topTextFieldEditingChanged(_ sender: UITextField) {
        guard let value = sender.text, let amount = Double(value) else { return }
        
        viewModel.convert(from: topSelectedMenuValue, to: bottomSelectedMenuValue, amount: amount) { value in
            DispatchQueue.main.async {
                self.bottomTextField.text = value.formatted(.currency(code: self.bottomSelectedMenuValue))
            }
        }
    }
    
        
    @IBAction func BottomTextFieldEditingChanged(_ sender: UITextField) {
        guard let value = sender.text, let amount = Double(value) else { return }
        
        viewModel.convert(from: bottomSelectedMenuValue, to: topSelectedMenuValue, amount: amount) { value in
            DispatchQueue.main.async {
                self.topTextField.text = value.formatted(.currency(code: self.topSelectedMenuValue))
            }
        }
    }
}
