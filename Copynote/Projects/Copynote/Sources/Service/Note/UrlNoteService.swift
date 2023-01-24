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
    case createOrUpdateNote(UrlNote)
    case deleteNote(UrlNote)
}

protocol UrlNoteServiceType {
    var noteEvent: PublishSubject<NoteEvent> { get }
    var event: PublishSubject<UrlNoteEvent> { get }
    
    func fetchNote(id: String)
    func createOrUpdateNote(note: UrlNote)
    func deleteNote(id: String)
}

class UrlNoteService: UrlNoteServiceType {
    var noteEvent: PublishSubject<NoteEvent>
    var event = PublishSubject<UrlNoteEvent>()
    let realm = Provider.shared.realm
    
    init(noteEvent: PublishSubject<NoteEvent>) {
        self.noteEvent = noteEvent
    }
    
    func fetchNote(id: String) {
        guard let urlNote = realm.objects(UrlNoteRealm.self).where({ $0.id == id }).first?.toDomain() else {
            return
        }
        
        if let note = urlNote.note {
            noteEvent.onNext(.fetchNote(note))
        }
        event.onNext(.fetchNote(urlNote))
    }
    
    func createOrUpdateNote(note: UrlNote) {
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
        guard let obj = realm.objects(UrlNoteRealm.self).where({ $0.id == id }).first else {
            return
        }
        do {
            try realm.write {
                realm.delete(obj)
                let urlNote = obj.toDomain()
                
                if let note = urlNote.note {
                    noteEvent.onNext(.deleteNote(note))
                }
                event.onNext(.deleteNote(urlNote))
            }
        } catch {
            print(error)
        }
    }
}

