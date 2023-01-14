//
//  MemoNoteService.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/14.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

enum MemoNoteEvent {
    case fetchNote(MemoNote)
    case createNote(MemoNote)
    case updateNote(MemoNote)
    case deleteNote(MemoNote)
}

protocol MemoNoteServiceType {
    var event: PublishSubject<MemoNoteEvent> { get }
    
    func fetchNote(id: String)
    func createNote(note: MemoNote)
    func updateNote(note: MemoNote)
    func deleteNote(id: String)
}

class MemoNoteService: MemoNoteServiceType {
    var event = PublishSubject<MemoNoteEvent>()
    let realm = Provider.shared.realm
    
    func fetchNote(id: String) {
        guard let obj = realm.objects(MemoNoteRealm.self).where({ $0.id == id }).first else {
            return
        }
        
        event.onNext(.fetchNote(obj.toDomain()))
    }
    
    func createNote(note: MemoNote) {
        do {
            try realm.write {
                let obj = note.toRealm()
                obj.id = UUID().uuidString
                
                realm.add(obj)
                event.onNext(.createNote(note))
            }
        } catch {
            print(error)
        }
    }
    
    func updateNote(note: MemoNote) {
        do {
            try realm.write {
                realm.add(note.toRealm(), update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteNote(id: String) {
        guard let obj = realm.objects(MemoNoteRealm.self).where({ $0.id == id }).first else {
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
