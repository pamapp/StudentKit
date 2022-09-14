//
//  TabBar.swift
//  StudentKit
//
//  Created by Alina Potapova on 08.09.2022.
//

import UIKit

class TabBar: UITabBarController {
    let model = LessonsPerDayDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        UITabBar.appearance().barTintColor = .black
        UITabBar.appearance().backgroundColor = .clear
        tabBar.tintColor = .black
        setupVC()
    }
    
    func setupVC() {
        viewControllers = [
            createNavController(for: LessonsViewController(model: model!), title: NSLocalizedString("Lessons", comment: ""), image: UIImage(systemName: "book")!),
            createNavController(for: ChallengesViewController(), title: NSLocalizedString("Challenges", comment: ""), image: UIImage(systemName: "chart.bar.xaxis")!),
            createNavController(for: MentalHealthViewController(), title: NSLocalizedString("Mental Health", comment: ""), image: UIImage(systemName: "brain.head.profile")!),
            createNavController(for: SettingsViewController(), title: NSLocalizedString("Settings", comment: ""), image: UIImage(systemName: "gearshape")!)
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
