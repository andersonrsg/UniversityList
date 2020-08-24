//
//  University.swift
//  NovastoneCodeTest
//
//  Created by Anderson Gralha on 20/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import Foundation
import IGListKit

class University: NSObject, Codable, ListDiffable {
    
    let id = UUID().uuidString
    let webPages: [String]?
    let name: String?
    let alphaTwoCode: String?
    let stateProvince: String?
    let domains: [String]?
    let country: String?

    lazy var searchString: String = {
        return [name, alphaTwoCode, country].compactMap { $0 }.joined(separator: " ").lowercased()
    }()
    
    enum CodingKeys: String, CodingKey {
        case webPages = "web_pages"
        case name
        case alphaTwoCode = "alpha_two_code"
        case stateProvince = "state-province"
        case domains
        case country
    }

    init(webPages: [String]?, name: String?, alphaTwoCode: String?, stateProvince: String?, domains: [String]?, country: String?) {
        self.webPages = webPages
        self.name = name
        self.alphaTwoCode = alphaTwoCode
        self.stateProvince = stateProvince
        self.domains = domains
        self.country = country
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object
    }
    
}

