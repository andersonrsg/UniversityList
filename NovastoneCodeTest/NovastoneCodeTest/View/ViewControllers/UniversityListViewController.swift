//
//  UniversityListViewController.swift
//  NovastoneCodeTest
//
//  Created by Anderson Gralha on 21/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import UIKit
import IGListKit

protocol UniversityListViewControllerDelegate: class {
    func navigateToUniversityDetail(university: University)
}

class UniversityListViewController: UIViewController {
    
    // MARK: Properties
    let viewModel = UniversityListViewModel()
    weak var delegate: UniversityListViewControllerDelegate?
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    let collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    var refreshControl: UIRefreshControl!
    
    private var loadingFailed: Bool = false
    private var searchString = ""
    private var loading = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure View
        self.title = NSLocalizedString("Universities List", comment: "")
        view.addSubview(collectionView)
        
        configureCollectionView()
        refreshData()
        configureRefreshControl()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: - Setup
    func configureCollectionView() {
        // Configure collection View
        collectionView.register(UINib(nibName: "UniversityListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UniversityListCollectionViewCell")
        
        // Configure List Adapter
        adapter.collectionView = collectionView
        adapter.scrollViewDelegate = self
        adapter.dataSource = self
        refreshData()
    }
    
    func configureRefreshControl() {
        // Configure Refresh Controller
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("Pull down to refresh", comment: ""))
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    // MARK: - Fetch Data
    @objc func refreshData() {
        // Fetch Data
        viewModel.fetchUniversities { [weak self] response in
            if case .failure = response {
                self?.loadingFailed = true
            } else {
                self?.loadingFailed = false
            }
            DispatchQueue.main.async {
                self?.adapter.performUpdates(animated: true, completion: nil)
                self?.refreshControl.endRefreshing()
            }
        }
    }
    
    
    // MARK: - Helpers
    func getEmptyView() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.text = loadingFailed ? NSLocalizedString("Failed to load universities", comment: "") : NSLocalizedString("No data available", comment: "")
        return label
    }
    
}

// MARK: - ListAdapterDataSource
extension UniversityListViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var data: [ListDiffable]!
        
        if searchString.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            // Returns all results
            data = viewModel.data.map { $0.object as ListDiffable }
        } else {
            // Filtered Results
            data = viewModel.filteredData(searchString).map { $0.object as ListDiffable }
        }
        
        if loading {
            data.append(UniversityListViewModel.Data.loading.object)
        }
        return data
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        if let object = object as? String {
            if object == UniversityListViewModel.searchKey {
                let sectionController = SearchSectionController()
                sectionController.delegate = self
                return sectionController
            } else {
                let sectionController = SpinnerSectionController.spinnerSectionController()
                return sectionController
            }
        } else {
            return UniversitySectionController()
        }
        
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return getEmptyView()
    }
}

// MARK: - SearchSectionControllerDelegate
extension UniversityListViewController: SearchSectionControllerDelegate {
    func searchSectionController(_ sectionController: SearchSectionController, didChangeText text: String) {
        searchString = text
        adapter.performUpdates(animated: true, completion: nil)
    }
}

// MARK: - UIScrollViewDelegate
extension UniversityListViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard !viewModel.reachedListLimit() else { return }
        
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !loading && distance < 200 {
            loading = true
            adapter.performUpdates(animated: true, completion: nil)
            viewModel.fakeFetchMoreData() {
                DispatchQueue.main.async {
                    self.adapter.performUpdates(animated: true, completion: nil)
                    self.loading = false
                }
            }
        }
    }
    
}
