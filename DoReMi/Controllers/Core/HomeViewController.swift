//
//  HomeViewController.swift
//  DoReMi
//
//  Created by mai ng on 8/15/21.
//

import UIKit


class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browse"
        view.backgroundColor = .yellow
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .done,
            target: self,
            action: #selector(didTapSettings))
        fetchData()
    }
    
    
    private func fetchData() {
        APICaller.shared.getNewReleasae {result in
            switch result {
            case .success(let model): break
            case . failure(let error): break
            }
        }
    }
    
    @objc func didTapSettings() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.navigationController?.pushViewController(vc, animated: true)
    
    }
}
