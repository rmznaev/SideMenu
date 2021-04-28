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
    
    lazy var infoVC = InfoViewController()
    
    private var menuState: MenuState = .close

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemGreen
        
        addChildVCs()
    }

    private func addChildVCs() {
        // Menu
        menuVC.delegate = self
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
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch self.menuState {
        case .open:
            // CLOSE IT
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .close
                    DispatchQueue.main.async {
                        completion?()
                    }
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

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        // close side menu & then navigate another vc
        toggleMenu(completion: nil)
        switch menuItem {
        case .home:
            self.goHome()
        case .info:
            self.goInfo()
        case .appRating:
            break
        case .shareApp:
            break
        case .settings:
            break
        }
    }
    
    private func goHome() {
        infoVC.view.removeFromSuperview()
        infoVC.didMove(toParent: self)
        homeVC.title = "Home"
    }
    
    private func goInfo() {
        homeVC.addChild(infoVC)
        homeVC.view.addSubview(infoVC.view)
        infoVC.view.frame = view.frame
        infoVC.didMove(toParent: homeVC)
        homeVC.title = infoVC.title
    }
}
