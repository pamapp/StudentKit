//
//  View+Extensions.swift
//  StudentKit
//
//  Created by Alina Potapova on 06.09.2022.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) { subviews.forEach { addSubview($0) } }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
