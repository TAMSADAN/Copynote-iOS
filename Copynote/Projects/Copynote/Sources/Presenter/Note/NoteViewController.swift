//
//  NoteViewController.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit
import ReactorKit
import RxDataSources

class NoteViewController: LogoViewController, View {
    // MARK: - Properties

    typealias Reactor = NoteReactor
    typealias CategoryDataSource = RxCollectionViewSectionedReloadDataSource<CategorySectionModel>
    typealias NoteDataSource = RxCollectionViewSectionedReloadDataSource<NoteSectionModel>

    private lazy var categoryDataSource = CategoryDataSource { _, collectionView, indexPath, item -> UICollectionViewCell in
        switch item {
        case let .category(reactor):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCollectionViewCell.self), for: indexPath) as? CategoryCollectionViewCell else { return .init() }

            cell.reactor = reactor
            return cell
        }
    }
    
    private lazy var noteDataSource = NoteDataSource { _, collectionView, indexPath, item -> UICollectionViewCell in
        switch item {
        case let .kind(reactor):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: KindCollectionViewCell.self), for: indexPath) as? KindCollectionViewCell else { return .init() }
            
            cell.reactor = reactor
            return cell
            
        case let .post(reactor):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PostCollectionViewCell.self), for: indexPath) as? PostCollectionViewCell else { return .init() }
            
            cell.reactor = reactor
            return cell
        }
    }

    // MARK: - UI Components

    let categoryCollectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let noteCollectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Initializer
    
    init(reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Methods
    
    override func setupDelegate() {
        super.setupDelegate()
        
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CategoryCollectionViewCell.self))
        noteCollectionView.register(KindCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: KindCollectionViewCell.self))
        noteCollectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PostCollectionViewCell.self))
    }

    override func setupProperty() {
        super.setupProperty()

    }

    override func setupHierarchy() {
        super.setupHierarchy()

        contentView.addSubviews([categoryCollectionView, noteCollectionView])
    }

    override func setupLayout() {
        super.setupLayout()

        categoryCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        noteCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    func bind(reactor: NoteReactor) {
        rx.viewWillAppear
            .map { _ in .refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state
            .map(\.categorySections)
            .bind(to: categoryCollectionView.rx.items(dataSource: categoryDataSource))
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.noteSections)
            .bind(to: noteCollectionView.rx.items(dataSource: noteDataSource))
            .disposed(by: disposeBag)
    }
}
