//
//  CircularProgressBarView.swift
//  StudentKit
//
//  Created by Alina Potapova on 06.09.2022.
//

import UIKit

class CircularProgressBarView: UIView {
    
    // MARK: - Private variables -

    private let timeLeftShapeLayer = CAShapeLayer()
    private let bgShapeLayer = CAShapeLayer()
    private var timeLeft: TimeInterval = 6000
    private var endTime: Date?
    private var timeLabel =  UILabel()
    private var timer = Timer()
    private let strokeIt = CABasicAnimation(keyPath: "strokeEnd")
    
    // MARK: - Inits -

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBar()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Functions -

    func setupBar() {
        drawBgShape()
        drawTimeLeftShape()
        addTimeLabel()

        strokeIt.fromValue = 0
        strokeIt.toValue = 1
        strokeIt.duration = timeLeft

        timeLeftShapeLayer.add(strokeIt, forKey: nil)

        endTime = Date().addingTimeInterval(timeLeft)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    func drawBgShape() {
        bgShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: self.frame.midX , y: self.frame.midY), radius:
            45, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        bgShapeLayer.strokeColor = UIColor.progressBarGray.cgColor
        bgShapeLayer.fillColor = UIColor.clear.cgColor
        bgShapeLayer.lineWidth = 12
        layer.addSublayer(bgShapeLayer)
    }

    func drawTimeLeftShape() {
        timeLeftShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: self.frame.midX , y: self.frame.midY), radius:
            45, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        timeLeftShapeLayer.strokeColor = UIColor.progressBarGreen.cgColor
        timeLeftShapeLayer.fillColor = UIColor.clear.cgColor
        timeLeftShapeLayer.lineWidth = 12
        layer.addSublayer(timeLeftShapeLayer)
    }

    func addTimeLabel() {
        timeLabel = UILabel(frame: CGRect(x: self.frame.midX - 45, y: self.frame.midY - 25, width: 90, height: 50))
        timeLabel.textAlignment = .center
        timeLabel.text = timeLeft.time
        timeLabel.font = UIFont.boldSystemFont(ofSize: 14)
        timeLabel.textColor = UIColor.white
        addSubview(timeLabel)
    }

    @objc func updateTime() {
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timeLabel.text = timeLeft.time
        } else {
            timeLabel.text = "00:00:00"
            timer.invalidate()
        }
    }
}


//class CircularProgressBarGoalsView: UIView {
//    // MARK: - Private variables -
//
//    private let timeLeftShapeLayer = CAShapeLayer()
//    private let bgShapeLayer = CAShapeLayer()
//    private var goalsLeft: Int = 3
//    private var currentGoals: Int = 1
//    private var percentLabel =  UILabel()
//    private let strokeIt = CABasicAnimation(keyPath: "strokeEnd")
//
//    // MARK: - Inits -
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupBar()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//
//    // MARK: - Functions -
//
//    func setupBar() {
//        drawBgShape()
//        drawTimeLeftShape()
//        addTimeLabel()
//
//        strokeIt.fromValue = 0
//        strokeIt.toValue = 1
//        strokeIt.duration = 1
////        print(Double(1/3))
//        timeLeftShapeLayer.add(strokeIt, forKey: nil)
//    }
//
//    func drawBgShape() {
//        bgShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: self.frame.midX , y: self.frame.midY), radius:
//            35, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
//        bgShapeLayer.strokeColor = UIColor.progressBarGray.cgColor
//        bgShapeLayer.fillColor = UIColor.clear.cgColor
//        bgShapeLayer.lineWidth = 8
//        layer.addSublayer(bgShapeLayer)
//    }
//
//    func drawTimeLeftShape() {
//        timeLeftShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: self.frame.midX , y: self.frame.midY), radius:
//            35, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
//        timeLeftShapeLayer.strokeColor = UIColor.progressBarGreen.cgColor
//        timeLeftShapeLayer.fillColor = UIColor.clear.cgColor
//        timeLeftShapeLayer.lineWidth = 8
//        layer.addSublayer(timeLeftShapeLayer)
//    }
//
//    func addTimeLabel() {
//        percentLabel = UILabel(frame: CGRect(x: self.frame.midX - 45, y: self.frame.midY - 25, width: 90, height: 50))
//        percentLabel.textAlignment = .center
//        percentLabel.text = String(currentGoals / goalsLeft) + "%"
//        percentLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        percentLabel.textColor = UIColor.white
//        addSubview(percentLabel)
//    }
//
////    @objc func updateTime() {
////        if timeLeft > 0 {
////            timeLeft = endTime?.timeIntervalSinceNow ?? 0
////            timeLabel.text = timeLeft.time
////        } else {
////            timeLabel.text = "00:00:00"
////            timer.invalidate()
////        }
////    }
//}
