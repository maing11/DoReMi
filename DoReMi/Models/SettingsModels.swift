//
//  SettingsModels.swift
//  DoReMi
//
//  Created by mai ng on 8/17/21.
//

import Foundation


struct Section {
    let title: String
    let options: [Option]
}


struct Option {
    let title: String
    let handler:() -> Void
    
}
