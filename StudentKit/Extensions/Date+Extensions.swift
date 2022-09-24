//
//  Date+Extensions.swift
//  StudentKit
//
//  Created by Alina Potapova on 24.09.2022.
//

import UIKit

extension Date {
    func adding(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }
}
