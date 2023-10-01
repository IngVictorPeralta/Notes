//
//  NoteManager.swift
//  Notes
//
//  Created by Victor Peralta on 22/09/23.
//

import Foundation

class NoteManager{
    private var notes : [Note] = []
    
    func createNote(note: Note){
        notes.append(note)
        saveNotes()
    }
    
    func deleteNote(at index : Int){
        notes.remove(at: index)
        saveNotes()
    }
    
    func countNotes() -> Int {
        return notes.count
    }
    
    func getNote(at index : Int) -> Note {
        print("get: ",index)
        return notes[index]
    }
    
    func getNotes() -> [Note]{
        return notes
    }
    // NoteManager.swift

    func getFilePath() -> URL{
            let fileManager = FileManager.default
            let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            let noteUrlPath = documentDirectory.appendingPathComponent("notes.json")
            print(noteUrlPath)
            return URL(string: noteUrlPath.absoluteString)!
        }
        
        func loadNotes(){
            let notesPath = getFilePath()
            
            let fileManager = FileManager.default
            
            if(fileManager.fileExists(atPath: notesPath.path)){
                
                do{
                    let jsonData = fileManager.contents(atPath: notesPath.path)
                    
                    notes = try JSONDecoder().decode([Note].self, from: jsonData!)
                    
                }catch let error{
                    print(error)
                }
            }else{
                // File doesn't exist
            }
            
            
        }
        
        func saveNotes(){
            let fileManager = FileManager.default
            
            do{
                let jsonData = try JSONEncoder().encode(notes)
                fileManager.createFile(atPath: getFilePath().path, contents: jsonData)
                
            }catch let error{
                print(error)
            }
        }
    /*func loadNotes(){
        //load notes from fileSystem
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let notesPath = documentDirectory.appendingPathComponent("notes.json")
            print(notesPath)
        if fileManager.fileExists(atPath: notesPath.absoluteString){
            do{
                let jsonData = fileManager.contents(atPath: notesPath.absoluteString)
                print("json: ", jsonData)
                notes = try JSONDecoder().decode([Note].self, from: jsonData!)
            }catch let error{
                print("error", error)
            }
        }else{
            print("MSG: Files does not exists")
        }
    }
    func saveNotes() {
        // Guarda las notas en el sistema de archivos
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let notesPath = documentDirectory.appendingPathComponent("notes.json")
        
        do {
            let jsonData = try JSONEncoder().encode(notes)
            print(notesPath)
            fileManager.createFile(atPath: notesPath.path, contents: jsonData)
        } catch let error {
            print(error)
        }
    }*/
/*func saveNotes(){
        //saves notes to fileSystem
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let notesPath = documentDirectory.appendingPathComponent("notes.json")
        
        do{
            let jsondata = try JSONEncoder().encode(notes)
            print(notesPath)
            fileManager.createFile(atPath: notesPath.absoluteString, contents: jsondata)
        }catch let error{
            print(error)
        }
    }*/
    
    //MARK: Homework
    func updateNote(note : Note, at index : Int){
        //updateNote
        notes[index] = note
        saveNotes()
    }
}
