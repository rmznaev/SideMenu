//
//  MenuViewController.swift
//  SideMenu
//
//  Created by Ramazan Abdullayev on 28.04.21.
//

import UIKit

class MenuViewController: UIViewController {
    
    enum MenuOptions: String, CaseIterable {
        case home = "Home"
        case info = "Information"
        case appRating = "App Rating"
        case shareApp = "Share App"
        case settings = "Settings"
        
        var imageName: String {
            switch self {
            case .home:
                return "house.circle.fill"
            case .info:
                return "info.circle.fill"
            case .appRating:
                return "star.circle.fill"
            case .shareApp:
                return "square.and.arrow.up.fill"
            case .settings:
                return "gearshape.fill"
            }
        }
    }

    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .none
        view.register(UITableViewCell.self, forCellReuseIdentifier: "menuCell")
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        view.backgroundColor = .menuBG
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = CGRect(x: 0,
                                 y: view.safeAreaInsets.top,
                                 width: view.bounds.size.width,
                                 height: view.bounds.size.height)
    }

}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .white
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .menuBG
        cell.contentView.backgroundColor = .menuBG
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension UIColor {
    public static let menuBG = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
}
