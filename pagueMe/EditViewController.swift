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
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var value: UITextField!
    
    
    
    var devedor = Devedor(vrName: "aaa", vrDesc: "bbb", vrValue: "ccc")
    var ref:DatabaseReference = Database.database().reference()
    var index:IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = devedor.vrName
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
    
    @IBAction func remove(_ sender: Any) {
        ref = self.ref.child("devedores").child(devedor.vrName!)
        ref.removeValue {
            error, _ in
            let alert = UIAlertController(title: "Falhou", message: "Devedor não pode ser removido", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Confirmar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        let alert = UIAlertController(title: "Sucesso", message: "Devedor removido", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Confirmar", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
       
        
    }
   

}
