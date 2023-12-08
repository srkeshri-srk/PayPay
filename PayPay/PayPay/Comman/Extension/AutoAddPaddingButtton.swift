//
//  AutoAddPaddingButtton.swift
//  PayPay
//
//  Created by Shreyansh Raj  Keshri on 08/12/23.
//

import UIKit

class AutoAddPaddingButtton: UIButton {
    override var intrinsicContentSize: CGSize {
        get {
            let baseSize = super.intrinsicContentSize
            return CGSize(width: baseSize.width + 20, height: baseSize.height)
        }
    }
}
