//
//  SelectLocationService.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/24.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

enum SelectLocationEvent {
    case selectLocation(Location)
}

protocol SelectLocationServiceType {
    var event: PublishSubject<SelectLocationEvent> { get }
    
    func selectLocation(location: Location)
}

class SelectLocationService: SelectLocationServiceType {
    var event = PublishSubject<SelectLocationEvent>()
    
    func selectLocation(location: Location) {
        event.onNext(.selectLocation(location))
    }
}

