//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Liz-Mary on 16.07.2023.
//

import Foundation
import StorageService

class ProfileViewModel {
    var reloadData: (() -> Void)?
    var user: User?
    var data: [Post] = [] {
        didSet {
            reloadData?()
        }
    }
   
    init() {
           loadData()
       }
       
       func loadData() {
           data = Post.make()
       }
    
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfRows(in section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return data.count
        } else {
            return 0
        }
    }
    
    func post(at index: Int) -> Post? {
        guard index >= 0 && index < data.count else {
            return nil
        }
        return data[index]
    }
}
