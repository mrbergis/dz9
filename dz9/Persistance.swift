//
//  Persistance.swift
//  dz9
//
//  Created by Андрей Адельбергис on 26.10.2021.
//

import Foundation

class Persistacne{
    static let shared = Persistacne()
    
    private let kUserNameKey = "Persistacne.kUserNameKey"
    private let kSurNameKey = "Persistacne.kSurNameKey"
    
    var userName: String? {
            set { UserDefaults.standard.set(newValue, forKey: kUserNameKey) }
            get { return UserDefaults.standard.string(forKey: kUserNameKey)}
        }
    var surName: String? {
            set { UserDefaults.standard.set(newValue, forKey: kSurNameKey) }
            get { return UserDefaults.standard.string(forKey: kSurNameKey)}
        }
}
