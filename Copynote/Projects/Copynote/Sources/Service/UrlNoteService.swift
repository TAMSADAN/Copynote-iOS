//
//  UrlNoteService.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/14.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

enum UrlNoteEvent {
    case fetchNote(UrlNote)
    case createNote(UrlNote)
    case updateNote(UrlNote)
    case deleteNote(UrlNote)
}

protocol UrlNoteServiceType {
    var event: PublishSubject<UrlNoteEvent> { get }
    
    func fetchNote(id: String)
    func createOrUpdateNote(note: UrlNote)
    func deleteNote(id: String)
}

class UrlNoteService: UrlNoteServiceType {
    var event = PublishSubject<UrlNoteEvent>()
    let realm = Provider.shared.realm
    
    func fetchNote(id: String) {
        guard let obj = realm.objects(UrlNoteRealm.self).where({ $0.id == id }).first else {
            return
        }
        
        event.onNext(.fetchNote(obj.toDomain()))
    }
    
    func createOrUpdateNote(note: UrlNote) {
        do {
            try realm.write {
                realm.add(note.toRealm(), update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteNote(id: String) {
        guard let obj = realm.objects(UrlNoteRealm.self).where({ $0.id == id }).first else {
            return
        }
        do {
            try realm.write {
                realm.delete(obj)
                event.onNext(.deleteNote(obj.toDomain()))
            }
        } catch {
            print(error)
        }
    }
}

