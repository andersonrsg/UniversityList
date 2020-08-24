//
//  UniversityListViewModel.swift
//  NovastoneCodeTest
//
//  Created by Anderson Gralha on 21/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import UIKit
import IGListKit

class UniversityListViewModel {
    static let searchKey = "search"
    static let loadingKey = "loading"
    
    enum FetchUniversitiesResult: Equatable {
        case success
        case failure(Error)
        
        static func == (lhs: UniversityListViewModel.FetchUniversitiesResult, rhs: UniversityListViewModel.FetchUniversitiesResult) -> Bool {
            switch (lhs, rhs) {
            case (.failure(let lhsError), .failure(let rhsError)):
                return lhsError as NSError == rhsError as NSError
            case (.success, .success):
                return true
            default:
                return false
            }
        }
    }
    enum Data {
        
        case search
        case university(University)
        case loading
        
        var diffIdentifier: String {
            switch self {
            case .search:
                return searchKey
            case .university(let university):
                return university.id
            case .loading:
                return loadingKey
            }
        }
        
        var object: ListDiffable {
            switch self {
            case .search:
                return UniversityListViewModel.searchKey as ListDiffable
            case .university(let university):
                return university
            case .loading:
                return UniversityListViewModel.loadingKey as ListDiffable
            }
        }
    }
    
    // MARK: - Properties
    private var universities: [University] = []
    
    var dataCount = 20
    var data: [Data] {
        guard universities.count > 0 else {
            return []
        }
        return [Data.search] + universities.prefix(dataCount).map { Data.university($0) }
    }
    
    // MARK: - Initialization
    init() {
    }
    convenience init(universities: [University]) {
        self.init()
        self.universities = universities
    }
    
    // MARK: - Fetch
    func fetchUniversities(completion: @escaping (FetchUniversitiesResult) -> Void)  {
        NetworkingController.shared.fetchUniversities(completion: { [weak self] response in
            switch response {
            case .success(universities: let universities):
                self?.universities = universities
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func fakeFetchMoreData(completion: @escaping () -> Void)  {
        DispatchQueue.global(qos: .default).async {
            sleep(2)
            self.dataCount += 20
            completion()
        }
    }
    
    // MARK: - Filtering
    func filteredData(_ searchString: String) -> [Data] {
        return [Data.search] + universities.prefix(dataCount).filter { $0.searchString.contains(searchString.lowercased()) }.map { Data.university($0) }
    }
    
    // MARK: - Helpers
    func reachedListLimit() -> Bool {
        return dataCount >= universities.count
    }
    
}
