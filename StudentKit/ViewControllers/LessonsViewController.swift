//
//  LessonsViewController.swift
//  StudentKit
//
//  Created by Alina Potapova on 29.08.2022.
//

import UIKit
import SwiftSoup

class LessonsViewController: UIViewController {
    
    // MARK: - Private variables -
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var model : LessonsPerDayDataSource

    // MARK: - Public variables -
    
    lazy var nextLessons: UILabel = {
        let title = UILabel(frame: CGRect(x: 20, y: 300, width: 100, height: 20))
        title.text = "Next lessons"
        title.font = UIFont.boldSystemFont(ofSize: 15)
        title.textColor = .black
        return title
    }()
    
    lazy var timetableTitle: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame = CGRect(x: 20, y: 75, width: 400, height: 52)
        
        let label = UILabel()
        label.text = "Timetable of classes"
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
    
    lazy var currentLesson: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 23, y: 137, width: self.view.frame.width - 46, height: 130)
        view.backgroundColor = .black
        view.layer.cornerRadius = 15
        
        let lessonTitle = UILabel()
        lessonTitle.text = "Математическое \nмоделирование"
        lessonTitle.numberOfLines = 0
        lessonTitle.font = UIFont.boldSystemFont(ofSize: 17)
        lessonTitle.textColor = .white

        let lessonStatus = UILabel()
        lessonStatus.text = "Lesson is about to end!"
        lessonStatus.font = UIFont.systemFont(ofSize: 12)
        lessonStatus.textColor = .gray
        
        let lessonTime = UILabel()
        lessonTime.text = "12:00 - 13:45"
        lessonTime.font = UIFont.systemFont(ofSize: 12)
        lessonTime.textColor = .gray
        
        var circularProgressBarView = CircularProgressBarView(frame: .zero)
        
        view.addSubviews(lessonTitle, lessonStatus, lessonTime, circularProgressBarView)
        
        lessonTitle.translatesAutoresizingMaskIntoConstraints = false
        lessonStatus.translatesAutoresizingMaskIntoConstraints = false
        lessonTime.translatesAutoresizingMaskIntoConstraints = false
        circularProgressBarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            lessonTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            lessonTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),

            lessonTime.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            lessonTime.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            lessonStatus.bottomAnchor.constraint(equalTo: lessonTime.topAnchor, constant: -10),
            lessonStatus.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            circularProgressBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            circularProgressBarView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        return view
    }()

    // MARK: - Initializers -
    
    init(model: LessonsPerDayDataSource) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - ViewController lifecycles -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(timetableTitle, currentLesson, nextLessons)
        setupTableView()
    }

    required init(coder: NSCoder) { fatalError() }
    
    // MARK: - Functions -
    
    func dateFormatter(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, d"
        let time = formatter.string(from: date)
        return time
    }

}

extension LessonsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = model.lessonByIndexPath(for: indexPath)[indexPath.row]
        if model.name.count > 40 {
            return 110
        }
        return 95
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear

        let label = UILabel(frame: CGRect(x: 23, y: 0, width: self.view.frame.width - 46, height: 20))
        label.text = model.headerTitle(section)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.textAlignment = .right
        headerView.addSubview(label)
        
        return headerView
    }
}

extension LessonsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        model.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.numberOfRows(section)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 15
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 23, dy: 10)
        cell.layer.mask = maskLayer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectcell", for: indexPath) as! CustomTableViewCell
        cell.selectionStyle = .none
        
        let model = model.lessonByIndexPath(for: indexPath)[indexPath.row]
        cell.title = model.name
        cell.type = model.type
        cell.time = model.time
        self.model.dateToDate(lesson: model)
        return cell
    }
}

extension LessonsViewController {
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds.inset(by: .init(top: 328, left: 0, bottom: 90, right: 0))
        tableView.backgroundColor = .clear
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "subjectcell")
    }
}
