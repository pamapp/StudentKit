//
//  SubjectTableViewCell.swift
//  StudentKit
//
//  Created by Alina Potapova on 06.09.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - Private variables -
    
    private let titleLabel = UILabel()
    private let timeLabel = UILabel()
    private let typeLabel = UILabel()
    private let dateLabel = UILabel()
    
    // MARK: - Public variables -
    
    public var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    public var time: String? {
        didSet {
            self.timeLabel.text = time
        }
    }
    
    public var type: String? {
        didSet {
            self.typeLabel.text = type
        }
    }
    
    public var date: String? {
        didSet {
            self.dateLabel.text = date
        }
    }

    // MARK: - Initializers -
    
    required init?(coder: NSCoder) { fatalError() }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let timeLabelView = CellLabelView(corner: .left)
        timeLabelView!.backgroundColor = .clear
        
        let typeLabelView = CellLabelView(corner: .right)
        typeLabelView!.backgroundColor = .clear
        
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byClipping
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 10
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        timeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        timeLabel.font = UIFont.boldSystemFont(ofSize: 13)
        timeLabel.textColor = .white
        
        typeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        typeLabel.font = UIFont.boldSystemFont(ofSize: 13)
        typeLabel.textColor = .white
        
        timeLabelView!.translatesAutoresizingMaskIntoConstraints = false
        typeLabelView!.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubviews(titleLabel, timeLabelView!, timeLabel, typeLabelView!, typeLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 40),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            
            timeLabelView!.widthAnchor.constraint(equalToConstant: 135),
            timeLabelView!.heightAnchor.constraint(equalToConstant: 30),
            timeLabelView!.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            timeLabelView!.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            timeLabel.centerYAnchor.constraint(equalTo: timeLabelView!.centerYAnchor),
            timeLabel.centerXAnchor.constraint(equalTo: timeLabelView!.centerXAnchor),
            
            typeLabelView!.widthAnchor.constraint(equalToConstant: 140),
            typeLabelView!.heightAnchor.constraint(equalToConstant: 30),
            typeLabelView!.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            typeLabelView!.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            
            typeLabel.centerYAnchor.constraint(equalTo: typeLabelView!.centerYAnchor),
            typeLabel.centerXAnchor.constraint(equalTo: typeLabelView!.centerXAnchor, constant: 5),
        ])
    }
    
    // MARK: - Functions -

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = UIColor.cellBackground
    }
}


class CellLabelView: UIView {
    // MARK: - Public enum -
    
    enum Corner: String {
        case right, left
    }
    
    // MARK: - Private variables -
    
    private var corner: Corner!
    private var path: UIBezierPath!
    
    // MARK: - Initializers -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init?(corner: Corner) {
        super.init(frame: .zero)
        self.corner = corner
    }
    
    // MARK: - Functions -
    
    override func draw(_ rect: CGRect) {
        self.createRectangle()
        UIColor.black.setFill()
        path.fill()
    }
    
    func createRectangle() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        
        if corner == .right {
            path.addQuadCurve(to: CGPoint(x: 40, y: self.frame.size.height), controlPoint: CGPoint(x: 0.0, y: self.frame.size.height))
            path.addLine(to: CGPoint(x: 40, y: self.frame.size.height))
            path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
            path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
        } else {
            path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
            path.addLine(to: CGPoint(x: self.frame.size.width - 40, y: self.frame.size.height))
            path.addQuadCurve(to: CGPoint(x: self.frame.size.width, y: 0.0), controlPoint: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
            path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
        }
        
        path.close()
    }
}
