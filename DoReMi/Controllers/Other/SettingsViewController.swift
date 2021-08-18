//
//  SettingsViewController.swift
//  DoReMi
//
//  Created by mai ng on 8/15/21.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController, UITableViewDelegate{

    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    private var sections = [Section]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    private func configureModel() {
        sections.append(Section(title: "Profile", options: [Option(title: "View Your Profile", handler: { [weak self] in DispatchQueue.main.async {
            self?.viewProfile()
        }
            
        })]))
        
        sections.append(Section(title: "Account", options: [Option(title: "Sign Out", handler: { [weak self] in DispatchQueue.main.async {
            self?.signOutTapped()
        }
        })]))

    }
    
    private func signOutTapped() {
        
    }
        
        
        private func viewProfile() {
            let vc = ProfileViewController()
            vc.title = "Profile"
            vc.navigationItem.largeTitleDisplayMode = .always
            navigationController?.pushViewController(vc, animated: true)
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}



extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Call handler for cll
        let model = sections[indexPath.section].options[indexPath.row]
        model.handler()

    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
}
