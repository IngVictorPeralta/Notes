//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Victor Peralta on 22/09/23.
//

import UIKit

class NotesTableViewController: UITableViewController {

    @IBOutlet var tableViewNotes: UITableView!
    
    @IBOutlet var emptyNoteView: UIView!
    let noteManager = NoteManager()
    var note : Note?
    var selectedNoteId : Int?
    var idBack : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteManager.loadNotes()
        anyNotes()
        
    }
    func anyNotes(){
        print(noteManager.countNotes())
        if noteManager.countNotes() == 0 {
            emptyNoteView.isHidden = false
            tableViewNotes.backgroundView = emptyNoteView
        }else{
            emptyNoteView.isHidden = true
            tableViewNotes.backgroundView = emptyNoteView
        }
    }
    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return noteManager.countNotes()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell
        
        let actualNote = noteManager.getNote(at: indexPath.row)
        
        cell.titleNote.text = actualNote.title
        
        cell.detailNote.text = actualNote.content
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            noteManager.deleteNote(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            anyNotes()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected:", indexPath.row)
        selectedNoteId = indexPath.row
        //selectedNote = noteManager.getNote(at: indexPath.row)
        //showToast(message: selectedNoteId.)
        print("Enviando:",selectedNoteId!)
        self.performSegue(withIdentifier: "addTaskSegue",sender:Self.self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let noteNav = segue.destination as! UINavigationController
        let noteAdd = noteNav.viewControllers.first as! AddNoteViewController
        
        noteAdd.id = selectedNoteId
        if(selectedNoteId != nil){
            noteAdd.oldNote = noteManager.getNote(at: selectedNoteId!)
        }
    }
    
    @IBAction func unWindFromAddNoteTableViewController(segue: UIStoryboardSegue){
        print("unwind segue!")
        let source = segue.source as! AddNoteViewController
        note = source.newNote
        idBack = source.id
        
        if(idBack == nil){
            noteManager.createNote(note: note!)
            print("#",noteManager.countNotes())
            print("notes:",noteManager.getNotes())
            
            //noteManager.saveNotes()
        }else{
            noteManager.updateNote(note: note!, at: idBack!)
        }
        selectedNoteId = nil
        anyNotes()
        tableViewNotes.reloadData()
    }

}
