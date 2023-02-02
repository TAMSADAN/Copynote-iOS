//
//  SelectLocationBottomSheetViewController.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/24.
//  Copyright © 2023 Copynote. All rights reserved.
//

import UIKit
import ReactorKit
import RxDataSources

class SelectLocationBottomSheetViewController: BottomSheetViewController, View {
    // MARK: - Properties
    
    typealias Reactor = SelectLocationBottomSheetReactor
    typealias DataSource = RxCollectionViewSectionedReloadDataSource<SelectLocationSectionModel>
    
    private lazy var dataSource = DataSource { _, collectionView, indexPath, item -> UICollectionViewCell in
        switch item {
        case let .location(reactor):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SelectLocationCollectionViewCell.self), for: indexPath) as? SelectLocationCollectionViewCell else { return .init() }
            
            cell.reactor = reactor
            
            return cell
        }
    }
    
    // MARK: - UI Components
    
    let contentView: UIView = .init()
    let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
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
    
    override func setupDelegate() {
        super.setupDelegate()
        
        collectionView.register(SelectLocationCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SelectLocationCollectionViewCell.self))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([collectionView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .map { _ in .refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        Observable.zip(
            collectionView.rx.itemSelected,
            collectionView.rx.modelSelected(type(of: self.dataSource).Section.Item.self)
        )
        .map { .tapLocationItem($0, $1) }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        collectionView.rx.setDataSource(dataSource).disposed(by: disposeBag)
        
        reactor.state
            .map(\.sections)
            .withUnretained(self)
            .bind { this, sections in
                this.dataSource.setSections(sections)
                this.collectionView.reloadData()
                this.collectionView.setCollectionViewLayout(this.makeCompositionLayout(from: sections), animated: false)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.dismiss)
            .filter { $0 }
            .bind { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}

extension SelectLocationBottomSheetViewController {
    private func makeCompositionLayout(from sections: [SelectLocationSectionModel]) -> UICollectionViewCompositionalLayout {
        let layout: UICollectionViewCompositionalLayout = .init { [weak self] index, _ in
            switch sections[safe: index]?.model {
            case let .location(items):
                return self?.makeLocationLayoutSection(from: items)
                
            case .none:
                return .none
            }
        }
        return layout
    }
    
    private func makeLocationLayoutSection(from items: [SelectLocationItem]) -> NSCollectionLayoutSection {
        let layoutItems: [NSCollectionLayoutItem] = items.map { item in
            let layoutItem: NSCollectionLayoutItem = .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)))
            return layoutItem
        }
        let layoutGroup: NSCollectionLayoutGroup = .vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: layoutItems)
        
        let layoutSection: NSCollectionLayoutSection = .init(group: layoutGroup)
        
        return layoutSection
    }
}
