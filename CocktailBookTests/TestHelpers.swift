//
//  TestHelpers.swift
//  CocktailBookTests
//
//  Created by Arun Kumar on 12/12/2023.
//

import UIKit
import Foundation

func tap(_ button: UIButton) {
    button.sendActions(for: .touchUpInside)
}

func tap(_ button: UIBarButtonItem) {
_ = button.target?.perform(button.action, with: nil)
}
