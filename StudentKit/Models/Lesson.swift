//
//  Lesson.swift
//  StudentKit
//
//  Created by Alina Potapova on 09.09.2022.
//

import SwiftSoup
import UIKit

struct Lesson: Codable, Equatable {
    var id: UUID
    var date: String
    var time: String
    var name: String
    var type: String
    var audience: String
    
    var timeStart: Date {
        let time: String = self.time
        let date: String = self.date
        
        let yearString = getStringDate(format: "yyyy-MM")
        let timeSubstring = String(time.dropLast(6))
        
        let indexDay = date.index(date.startIndex, offsetBy: 2) // get day
        let dateSubstring = date[..<indexDay]
        
        let fullDateString = yearString + "-" + dateSubstring + "T" + timeSubstring + ":00+0000"
        
        return convertStringToDate(dateStr: fullDateString)
    }
    
    var timeEnd: Date {
        let time: String = self.time
        let date: String = self.date
        
        let yearString = getStringDate(format: "yyyy-MM")
        let timeSubstring = String(time.dropFirst(6))

        let indexDay = date.index(date.startIndex, offsetBy: 2) //get day
        let dateSubstring = date[..<indexDay]
        
        let fullDateString = yearString + "-" + dateSubstring + "T" + timeSubstring + ":00+0000"

        return convertStringToDate(dateStr: fullDateString)
    }
    
    static func == (lhs: Lesson, rhs: Lesson) -> Bool {
        return lhs.time == rhs.time
    }

    func convertStringToDate(dateStr: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: dateStr)!
    }
    
    func dateDay() -> String {
        let indexDay = self.date.index(self.date.startIndex, offsetBy: 2) // get day
        return String(self.date[..<indexDay])
    }
    
    func getStringDate(format: String) -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}

struct LessonsPerDayDataSource {
    
    // MARK: - Private variables -

    private var listOfLessons: [[Lesson]]
    
    // MARK: - Initializer -

    init?() {
        let myUrlString = "https://ruz.spbstu.ru/faculty/95/groups/35464"
        guard let myURL = URL(string: myUrlString) else { return nil }
        
        var lessons : [Lesson] = []
        var lessonsList: [[Lesson]] = []
        
        do {
            let myHtmlString = try String(contentsOf: myURL, encoding: .utf8)
            let htmlContent = myHtmlString
            do {
                let doc = try SwiftSoup.parse(htmlContent)
                do {
                    let schedule__day = "schedule__day"

                    let lesson__subject = "lesson__subject"
                    let lesson__type = "lesson__type"
                    let lesson__time = "lesson__time"
                    let schedule__date = "schedule__date"
                    
                    let tempList = try doc.getElementsByClass(schedule__day).array()

                    for (_, element) in tempList.enumerated() {
                        let nameDayData = try element.getElementsByClass(lesson__subject).array()
                        let typeDayData = try element.getElementsByClass(lesson__type).array()
                        let timeDayData = try element.getElementsByClass(lesson__time).array()
                        let dateDayData = try element.getElementsByClass(schedule__date).array()
                        
                        lessons = try nameDayData.enumerated().map { (index, element) in Lesson(id: UUID(),
                                                                   date: try dateDayData[0].text(),
                                                                   time: try timeDayData[index].text(),
                                                                   name: try nameDayData[index].child(2).text(),
                                                                   type: try typeDayData[index].text(),
                                                                   audience: "")}
                        var uniqueLessons = [Lesson]()
                        
                        for lesson in lessons {
                            if !uniqueLessons.contains(lesson) {
                                uniqueLessons.append(lesson)
                            }
                        }
                        
                        lessonsList.append(uniqueLessons)
                    }
                }
                catch {
                }
            }
        }
        catch let error {
            print("Error: \(error)")
        }
        
        self.listOfLessons = lessonsList
    }

    // MARK: - Functions -
    
    func numberOfSections() -> Int { listOfLessons.count }
    func numberOfRows(_ section: Int) -> Int { listOfLessons[section].count }
    
    func lessonByIndexPath(for indexPath: IndexPath) -> [Lesson] { listOfLessons[indexPath.section] }
    func headerTitle(_ section: Int) -> String { listOfLessons[section][0].date}

    func getIndexList() -> [Lesson] {
        var indexForArray: Int = 0
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        for index in 0..<listOfLessons.count {
            if listOfLessons[index][0].dateDay() == dateFormatter.string(from: date) {
                indexForArray = index
            }
        }
        return listOfLessons[indexForArray]
    }
    
    func currentLesson() -> Lesson {
        var dayLessons: [Lesson]
        var currentLesson : Lesson = listOfLessons[0][0]
        let currentDate = Date.now.adding(hours: 3)
        
        dayLessons = getIndexList()
        
        for element in dayLessons {
            if element.timeStart <= currentDate && element.timeEnd >= currentDate {
                currentLesson = element
            }
        }
        
        return currentLesson
    }
}
