//
//  EditViewController.swift
//  pagueMe
//
//  Created by Anderson Ancilon on 11/12/18.
//  Copyright © 2018 Anderson Ancilon. All rights reserved.
//

import UIKit
import Firebase

class EditViewController: UIViewController {
    
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var value: UITextField!
    
    
    
    var devedor = Devedor(vrName: "", vrDesc: "", vrValue: "ccc")
    var ref:DatabaseReference = Database.database().reference()
    var index:IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        desc.text = devedor.vrDesc
        value.text = devedor.vrValue
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func update(_ sender: Any) {
        ref = self.ref.child("devedores").child(devedor.vrName!)
        ref.updateChildValues(["Descricao":desc.text, "Valor":value.text])
        desc.text = ""
        value.text = ""
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func remove(_ sender: Any) {
        ref = self.ref.child("devedores").child(devedor.vrName!)
        ref.removeValue {
            error, _ in
            let alert = UIAlertController(title: "Falhou", message: "Devedor não pode ser removido", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Confirmar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
       
       
        desc.text = ""
        value.text = ""
        
        self.dismiss(animated: true, completion: nil)
        
    }
   

}
