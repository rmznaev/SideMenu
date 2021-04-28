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
    var navVC: UINavigationController?
    
    private var menuState: MenuState = .close

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
        self.navVC = navVC
    }
}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        // Animating menu goes here
        print("did tap menu")
        
        switch self.menuState {
        case .open:
            // CLOSE IT
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .close
                }
            }
        case .close:
            // OPEN IT
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .open
                }
            }

        }
    }
}
