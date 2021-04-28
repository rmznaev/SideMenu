//
//  ViewController.swift
//  SideMenu
//
//  Created by Ramazan Abdullayev on 28.04.21.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case open
        case close
    }
    
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    
    private let menuState: MenuState = .close

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemGreen
        
        addChildVCs()
    }

    private func addChildVCs() {
        // Menu
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        // Home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
    }
}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        // Animating menu goes here
        print("did tap menu")
        
        switch self.menuState {
        case .open: break
            // CLOSE IT
        case .close: break
            // OPEN IT
        }
    }
}
