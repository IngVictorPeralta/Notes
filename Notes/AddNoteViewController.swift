//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Victor Peralta on 23/09/23.
//

import UIKit

class AddNoteViewController: UIViewController {

    @IBOutlet var notetitle: UITextField!
    
    @IBOutlet var noteContent: UITextView!
    
    //let noteManager = NoteManager()
    var oldNote : Note?
    var newNote : Note?
    var id : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dump(id)
        dump(oldNote)
        if(id != nil){
            
            notetitle.text = oldNote?.title
            noteContent.text = oldNote?.content
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem){
        self.dismiss(animated: true)
    }

    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        newNote = Note(title: notetitle.text!, content: noteContent.text, date: Date())
        
        //Add validation HW
        
        let destination = segue.destination as! NotesTableViewController
        destination.note = newNote
        destination.idBack = id
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(notetitle.text != "" && noteContent.text != ""){
            showToast(message: "Guardando nota...")
            return true
        }else{
            showToast(message: "Uno de tus datos viene vacio, revisa por favor.")
            return false
        }
        
    }

}
