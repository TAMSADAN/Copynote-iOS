//
//  SelectKindService.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/24.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

enum SelectKindEvent {
    case selectKind(Kind)
}

protocol SelectKindServiceType {
    var event: PublishSubject<SelectKindEvent> { get }
    
    func selectKind(kind: Kind)
}

class SelectKindService: SelectKindServiceType {
    var event = PublishSubject<SelectKindEvent>()
    
    func selectKind(kind: Kind) {
        event.onNext(.selectKind(kind))
    }
}
