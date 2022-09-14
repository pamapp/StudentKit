//
//  TimeInterval+Extensions.swift
//  StudentKit
//
//  Created by Alina Potapova on 08.09.2022.
//

import UIKit

extension TimeInterval {
    // MARK: - Current lesson timer format -
    var time: String {
        return String(format:"%02d:%02d:%02d",
                      Int(self/60/60),
                      Int((self.truncatingRemainder(dividingBy: 3600)) / 60),
                      Int(ceil(truncatingRemainder(dividingBy: 60))))
    }
}
