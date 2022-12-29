//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2022/12/29.
//

import ProjectDescription

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMinor(from: "15.0.0")),
    .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMinor(from: "5.0.0")),
    .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .upToNextMinor(from: "6.5.0")),
    .remote(url: "https://github.com/RxSwiftCommunity/RxGesture.git", requirement: .upToNextMinor(from: "4.0.0")),
    .remote(url: "https://github.com/ReactorKit/ReactorKit.git", requirement: .upToNextMinor(from: "3.2.0")),
    .remote(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", requirement: .upToNextMinor(from: "5.0.0")),
    .remote(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", requirement: .upToNextMajor(from: "4.2.2"))
])

let crt = CarthageDependencies([
    
])

let dependencies = Dependencies(
    carthage: crt,
    swiftPackageManager: spm,
    platforms: [.iOS]
)
