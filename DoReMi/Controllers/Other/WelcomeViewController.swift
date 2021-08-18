//
//  WelcomeViewController.swift
//  DoReMi
//
//  Created by mai ng on 8/15/21.
//

import UIKit


class WelcomeViewController: UIViewController {
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        title = "DoReMi"
        
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTagSignIn), for: .touchUpInside)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 20,
                                    y: view.height - 50  - view.safeAreaInsets.bottom,
                                    width: view.width-40,
                                    height: 50)
    }
    
    @objc func didTagSignIn() {
        let vc = AuthViewController()
        
        vc.completionHandler = {[weak self ]success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
            
        }
        
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)

    }
    
    private func handleSignIn(success: Bool) {
        // Log user in or yell at yell at them for error
        guard success else
        { let alert = UIAlertController(title: "Oops", message: "Something went wrong when signing in", preferredStyle: .alert)
            return}
        
        let mainTapTabBarVC = TabBarViewController()
        mainTapTabBarVC.modalPresentationStyle = .fullScreen
        present(mainTapTabBarVC, animated: true)
    }
    
}
