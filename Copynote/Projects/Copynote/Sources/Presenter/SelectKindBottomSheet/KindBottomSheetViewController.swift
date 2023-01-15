//
//  KindBottomSheetViewController.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import UIKit
import ReactorKit
import RxDataSources

class SelectKindBottomSheetViewController: BottomSheetViewController, View {
    // MARK: - Properties
    
    typealias Reactor = SelectKindBottomSheetReactor
    typealias DataSource = RxCollectionViewSectionedReloadDataSource<SelectKindSectionModel>
    
    private lazy var dataSource = DataSource { _, collectionView, indexPath, item -> UICollectionViewCell in
        switch item {
        case let .kind(reactor):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SelectKindCollectionViewCell.self), for: indexPath) as? SelectKindCollectionViewCell else { return .init() }
            
            cell.reactor = reactor
            
            return cell
        }
    }
    
    // MARK: - UI Components
    
    let contentView: UIView = .init()
    
    // MARK: - Initializer
    
    init(mode: BottomSheetViewController.Mode, reactor: Reactor) {
        super.init(mode: mode)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addContentView(view: contentView)
    }
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
    }
    
    override func setupLayout() {
        super.setupLayout()
    }
    
    func bind(reactor: Reactor) {
        
    }
}
