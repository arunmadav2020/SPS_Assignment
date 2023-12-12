//
//  CustomTableView.swift
//  CocktailBook
//
//  Created by Arun Kumar on 12/12/2023.
//

import Foundation
import UIKit

class CustomTableView: UITableView {

    override public func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }
}

