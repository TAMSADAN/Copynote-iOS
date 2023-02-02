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

class NoteViewController: NavigationViewController, View {
    // MARK: - Properties

    typealias Reactor = NoteReactor
    typealias LocationDataSource = RxCollectionViewSectionedReloadDataSource<LocationSectionModel>
    typealias NoteDataSource = RxCollectionViewSectionedReloadDataSource<NoteSectionModel>
    
    private let pushCreateOrUpdateNoteScreen: (_ note: Note) -> CreateOrUpdateNoteViewController
    private let pushCopyBottomSheetScreen: (_ note: Note) -> CopyBottomSheetViewController
    private let pushSettingScreen: () -> SettingViewController

    private lazy var locationDataSource = LocationDataSource { _, collectionView, indexPath, item -> UICollectionViewCell in
        switch item {
        case let .location(reactor):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LocationCollectionViewCell.self), for: indexPath) as? LocationCollectionViewCell else { return .init() }

            cell.reactor = reactor
            return cell
        }
    }
    
    private lazy var noteDataSource = NoteDataSource { _, collectionView, indexPath, item -> UICollectionViewCell in
        guard let reactor = self.reactor else { return .init() }
        
        switch item {
        case let .post(cellReactor):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PostCollectionViewCell.self), for: indexPath) as? PostCollectionViewCell else { return .init() }
            
            cell.reactor = cellReactor
            cell.button.rx.tap
                .bind { [weak self] _ in
                    self?.willPresentCopyBottomSheetViewController(note: cellReactor.currentState.note)
                }
                .disposed(by: cell.disposeBag)
            
            return cell
            
        case .empty:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EmptyCell.self), for: indexPath) as? EmptyCell else { return .init() }
            
            return cell
        }
    } configureSupplementaryView: { [weak self] dataSource, collectionView, _, indexPath -> UICollectionReusableView in
        guard let reactor = self?.reactor else { return .init() }
        switch dataSource[indexPath.section].model {
        case let .post(items):
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: PostCollectionViewHeader.self), for: indexPath) as? PostCollectionViewHeader else { return .init() }

            header.prepareForReuse()
            
            header.reactor = .init(selectedKind: reactor.currentState.selectedKind,
                                   noteService: reactor.noteService)
            
            header.kindButtons.enumerated().forEach({ indx, button in
                button.rx.tap
                    .map { .tapKind(Kind.allCases[safe: indx] ?? .all) }
                    .bind(to: reactor.action)
                    .disposed(by: header.disposeBag)
            })
            
            return header
        }
    }

    // MARK: - UI Components
    
    let logoView: UIView = .init()
    let logoLabel: UILabel = .init()
    let logoDivider: UIView = .init()
    let plusButton: UIButton = .init(type: .system)
    let settingButton: UIButton = .init(type: .system)
    let locationCollectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let noteCollectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Initializer
    
    init(reactor: Reactor,
         pushCreateNoteScreen: @escaping (_ note: Note) -> CreateOrUpdateNoteViewController,
         pushCopyBottomSheetScreen: @escaping (_ note: Note) -> CopyBottomSheetViewController,
         pushSettingScreen: @escaping () -> SettingViewController) {
        self.pushCreateOrUpdateNoteScreen = pushCreateNoteScreen
        self.pushCopyBottomSheetScreen = pushCopyBottomSheetScreen
        self.pushSettingScreen = pushSettingScreen
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Methods
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        showNavigtaionBar(isHidden: true)
    }
    
    override func setupDelegate() {
        super.setupDelegate()
        
        locationCollectionView.register(LocationCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: LocationCollectionViewCell.self))
        noteCollectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PostCollectionViewCell.self))
        noteCollectionView.register(EmptyCell.self, forCellWithReuseIdentifier: String(describing: EmptyCell.self))
        noteCollectionView.register(PostCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: PostCollectionViewHeader.self))
    }

    override func setupProperty() {
        super.setupProperty()
        
        logoLabel.font = CopynoteFontFamily.HappinessSansPrint.regular.font(size: 20)
        logoLabel.text = "copy note ."

        logoDivider.backgroundColor = .black
        
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = .black
        plusButton.setTitleColor(.black, for: .normal)
        plusButton.titleLabel?.font = CopynoteFontFamily.HappinessSansPrint.title.font(size: 30)
        
        settingButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        settingButton.tintColor = .black
    }

    override func setupHierarchy() {
        super.setupHierarchy()

        contentView.addSubviews([logoView, locationCollectionView, noteCollectionView])
        
        logoView.addSubviews([logoLabel, logoDivider, plusButton, settingButton])
    }

    override func setupLayout() {
        super.setupLayout()
        
        logoView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }

        logoLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }

        logoDivider.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        plusButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(settingButton.snp.leading).offset(-10)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
        
        settingButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
        
        locationCollectionView.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        noteCollectionView.snp.makeConstraints {
            $0.top.equalTo(locationCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    func bind(reactor: NoteReactor) {
        rx.viewWillAppear
            .map { _ in .refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        plusButton.rx.tap
            .compactMap { (UUID().uuidString,
                           reactor.currentState.selectedKind.toDomain(),
                           reactor.currentState.selectedLocation) }
            .map({ id, kind, location in
                return Note(id: id, kind: kind, location: location, title: "", content: "")
            })
            .bind { [weak self] note in
                self?.willPushCreateOrUpdateNoteViewController(note: note)
            }
            .disposed(by: disposeBag)
        
        settingButton.rx.tap
            .bind { [weak self] in
                self?.willPushSettingViewController()
            }
            .disposed(by: disposeBag)
        
        noteCollectionView.rx.setDataSource(noteDataSource).disposed(by: disposeBag)
        
        Observable.zip(
            noteCollectionView.rx.itemSelected,
            noteCollectionView.rx.modelSelected(type(of: self.noteDataSource).Section.Item.self)
        )
        .map { .tapNoteItem($0, $1) }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)

        reactor.state
            .map(\.locationSections)
            .bind(to: locationCollectionView.rx.items(dataSource: locationDataSource))
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.noteSections)
            .withUnretained(self)
            .bind { this, sections in
                this.noteDataSource.setSections(sections)
                this.noteCollectionView.reloadData()
                this.noteCollectionView.collectionViewLayout = this.makeCompositionLayout(from: sections)
            }
            .disposed(by: disposeBag)
    }
}

extension NoteViewController {
    func willPushCreateOrUpdateNoteViewController(note: Note) {
        let viewController = pushCreateOrUpdateNoteScreen(note)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func willPushSettingViewController() {
        let viewController = pushSettingScreen()
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func willPresentCopyBottomSheetViewController(note: Note) {
        let viewController = pushCopyBottomSheetScreen(note)
        
        present(viewController, animated: true)
    }
}

extension NoteViewController {
    func makeCompositionLayout(from sections: [NoteSectionModel]) -> UICollectionViewCompositionalLayout {
        let layout: UICollectionViewCompositionalLayout = .init { [weak self] index, _ in
            switch sections[safe: index]?.model {
            case let .post(items):
                return self?.makePostLayoutSection(from: items)
            case .none:
                return .none
            }
        }
        return layout
    }
    
    func makePostLayoutSection(from items: [NoteItem]) -> NSCollectionLayoutSection {
        let layoutItems: [NSCollectionLayoutItem] = items.map { item in
            let layoutItem: NSCollectionLayoutItem = .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(104)))
            layoutItem.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
            return layoutItem
        }
        let layoutGroup: NSCollectionLayoutGroup = .vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: layoutItems)
        layoutGroup.interItemSpacing = .fixed(12)
        
        let layoutSection: NSCollectionLayoutSection = .init(group: layoutGroup)
        let header: NSCollectionLayoutBoundarySupplementaryItem = .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.pinToVisibleBounds = true
        layoutSection.boundarySupplementaryItems = [header]
        layoutSection.contentInsets = .init(top: 10, leading: 0, bottom: 0, trailing: 0)
        return layoutSection
    }
}
