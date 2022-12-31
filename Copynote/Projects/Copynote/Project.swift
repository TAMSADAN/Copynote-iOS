import ProjectDescription

protocol ProjectFactory {
    var projectName: String { get }
    var dependencies: [TargetDependency] { get }

    func generateTarget() -> [Target]
    func generateConfigurations() -> Settings
}

// MARK: - Base Project Factory
class BaseProjectFactory: ProjectFactory {
    let projectName: String = "Copynote"

    let infoPlist: [String: InfoPlist.Value] = [
        "CFBundleShortVersionString": "1.0",
        "CFBundleVersion": "1",
        "UILaunchStoryboardName": "LaunchScreen",
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ]
                ]
            ]
        ],
        "UIAppFonts": [
            "Item 0": "Pretendard-Medium.otf",
            "Item 1": "Pretendard-Regular.otf",
            "Item 2": "Pretendard-SemiBold.otf",
            "Item 3": "Pretendard-Bold.otf",
            "Item 4": "Happiness-Sans-Regular.otf",
            "Item 5": "Happiness-Sans-SemiBold.otf",
            "Item 6": "Happiness-Sans-Bold.otf"
        ]
    ]

    let dependencies: [TargetDependency] = [
        .external(name: "Moya"),
        .external(name: "Alamofire"),
        .external(name: "RxMoya"),
        .external(name: "SnapKit"),
        .external(name: "RxSwift"),
        .external(name: "RxCocoa"),
        .external(name: "RxGesture"),
        .external(name: "RxDataSources"),
        .external(name: "ReactorKit"),
        .external(name: "KeychainAccess"),
    ]

    func generateConfigurations() -> Settings {
        Settings.settings(configurations: [
            .debug(name: "Debug", xcconfig: .relativeToCurrentFile("Sources/Config/Debug.xcconfig")),
            .release(name: "Release", xcconfig: .relativeToCurrentFile("Sources/Config/Release.xcconfig"))
        ])
    }

    func generateTarget() -> [Target] {
        [
            Target(
                name: projectName,
                platform: .iOS,
                product: .app,
                bundleId: "com.TAMSADAN.\(projectName)",
                deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
                infoPlist: .extendingDefault(with: infoPlist),
                sources: ["Sources/**"],
                resources: "Resources/**",
                entitlements: "\(projectName).entitlements",
//                scripts: [.pre(path: "Scripts/SwiftLintRunScript.sh", arguments: [], name: "SwiftLint")],
                dependencies: dependencies
            ),

            Target(
                name: "\(projectName)Tests",
                platform: .iOS,
                product: .unitTests,
                bundleId: "com.TAMSADAN.\(projectName).Tests",
                infoPlist: .default,
                sources: ["Tests/**"],
                dependencies: [.target(name: projectName)]
            )
        ]
    }
}

// MARK: - Project
let factory = BaseProjectFactory()

let project: Project = .init(
    name: factory.projectName,
    organizationName: factory.projectName,
    settings: factory.generateConfigurations(),
    targets: factory.generateTarget()
)
