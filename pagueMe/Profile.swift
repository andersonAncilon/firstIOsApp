
import UIKit
import Firebase

class Profile: UIViewController {
    
    
    @IBOutlet weak var qtdDevedores: UILabel!
    @IBOutlet weak var valorTotal: UILabel!
    
    var qtd:Int = 0
    var ref:DatabaseReference?
    var handle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var total:Double = 0.0;
        ref = Database.database().reference()
        handle = ref?.observe(.childAdded, with: { (snapshot) in
            self.qtdDevedores.text = String(snapshot.childrenCount)
        })
        
        handle = ref?.observe(.childRemoved, with: { (snapshot) in
            self.qtdDevedores.text = String(snapshot.childrenCount)
        })
        
        handle = ref?.child("devedores").observe(.childAdded, with: { (snapshot) in
            if let item = snapshot.value as? [String: AnyObject] {
                let val = item["Valor"] as! String
                
                total = total + Double(val)!
                
                self.valorTotal.text = String(total)
                
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

}
