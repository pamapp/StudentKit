//
//  ChallengesViewController.swift
//  StudentKit
//
//  Created by Alina Potapova on 08.09.2022.
//

import UIKit

class ChallengesViewController: UIViewController {
    
    // MARK: - Public variables -

    lazy var timetableTitle: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame = CGRect(x: 20, y: 75, width: 400, height: 52)

        let label = UILabel()
        label.text = "My challenges"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black

        let labelDate = UILabel()
        labelDate.text = dateFormatter(Date.now)
        labelDate.textColor = .gray
        labelDate.font = UIFont.systemFont(ofSize: 12)

        view.addSubviews(label, labelDate)

        label.translatesAutoresizingMaskIntoConstraints = false
        labelDate.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            labelDate.topAnchor.constraint(equalTo: label.bottomAnchor),
            labelDate.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            labelDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
        ])

        return view
    }()
//
//    lazy var statsLabel: UIView = {
//        let view = UIView()
//        view.frame = CGRect(x: self.view.frame.midX - 175, y: 137, width: 350, height: 100)
//        view.backgroundColor = .black
//        view.layer.cornerRadius = 15
//
//        let lessonTitle = UILabel()
//        lessonTitle.text = "You are almost there!"
//        lessonTitle.numberOfLines = 0
//        lessonTitle.font = UIFont.boldSystemFont(ofSize: 17)
//        lessonTitle.textColor = .white
//
//        let lessonStatus = UILabel()
//        lessonStatus.text = "1/3 days goals completed"
//        lessonStatus.font = UIFont.systemFont(ofSize: 12)
//        lessonStatus.textColor = .gray
//
//        var circularProgressBar = CircularProgressBarGoalsView(frame: .zero)
//
//        view.addSubviews(lessonTitle, lessonStatus, circularProgressBar)
//
//        lessonTitle.translatesAutoresizingMaskIntoConstraints = false
//        lessonStatus.translatesAutoresizingMaskIntoConstraints = false
//        circularProgressBar.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            lessonTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
//            lessonTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
//
//            lessonStatus.topAnchor.constraint(equalTo: lessonTitle.bottomAnchor, constant: 10),
//            lessonStatus.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
//
//            circularProgressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
//            circularProgressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//        ])
//
//        return view
//    }()
//
//    lazy var challengeIcon: UIView = {
//        let view = UIView()
//
//        return view
//    }()
//
//
//    // MARK: - Functions -
//
    func dateFormatter(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, d"
        let time = formatter.string(from: date)
        return time
    }

    // MARK: - ViewController lifecycles -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(timetableTitle)
    }
}
