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
    case createOrUpdateNote(MemoNote)
    case deleteNote(MemoNote)
}

protocol MemoNoteServiceType {
    var noteEvent: PublishSubject<NoteEvent> { get }
    var event: PublishSubject<MemoNoteEvent> { get }
    
    func fetchNote(id: String)
    func createOrUpdateNote(note: MemoNote)
    func deleteNote(id: String)
}

class MemoNoteService: MemoNoteServiceType {
    var noteEvent: PublishSubject<NoteEvent>
    var event = PublishSubject<MemoNoteEvent>()
    let realm = Provider.shared.realm
    
    init(noteEvent: PublishSubject<NoteEvent>) {
        self.noteEvent = noteEvent
    }
    
    func fetchNote(id: String) {
        guard let memoNote = realm.objects(MemoNoteRealm.self).where({ $0.id == id }).first?.toDomain() else {
            return
        }
        
        if let note = memoNote.note {
            noteEvent.onNext(.fetchNote(note))
        }
        event.onNext(.fetchNote(memoNote))
    }
    
    func createOrUpdateNote(note: MemoNote) {
        do {
            try realm.write {
                realm.add(note.toRealm(), update: .modified)
                
                if let note = note.note {
                    noteEvent.onNext(.createOrUpdateNote(note))
                }
                event.onNext(.createOrUpdateNote(note))
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
                let memoNote = obj.toDomain()
                
                if let note = memoNote.note {
                    noteEvent.onNext(.deleteNote(note))
                }
                event.onNext(.deleteNote(memoNote))
            }
        } catch {
            print(error)
        }
    }
}
