//
//  UIToggleButton.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/05/12.
//

import UIKit
import SwiftUI

class UIToggleButton: UIButton {
    var onBackgroundColor: UIColor = .yellow
    var offBackgroundColor: UIColor = .white
    func toggle() { isOn = !isOn }
    
    // MARK: - Private
    private(set) var isOn: Bool = false {
        didSet {
            self.backgroundColor = isOn ? onBackgroundColor : offBackgroundColor
        }
    }
}
