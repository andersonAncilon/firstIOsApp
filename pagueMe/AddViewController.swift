

import UIKit
import Firebase

class AddViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var value: UITextField!
    
    var ref:DatabaseReference?
  
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func add(_ sender: Any) {
        ref = Database.database().reference()
     
        
        if let doubleFromText = Double(value.text!) {
            if(name.text != "") {
                ref?.child("devedores").child(name.text!).setValue(["Nome":name.text, "Descricao":desc.text, "Valor":value.text ])
                
                let alert = UIAlertController(title: "Sucesso", message: "Devedor adicionado com sucesso!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Confirmar", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                name.text = ""
                desc.text = ""
                value.text = ""
            }
        } else {
            let alert = UIAlertController(title: "Falha", message: "Digite o valor corretamente (Ex: 5.50)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Confirmar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
