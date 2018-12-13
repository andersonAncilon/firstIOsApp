

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func register(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(login.text, forKey: "login")
        defaults.set(password.text, forKey: "senha")
        let myVC = storyboard?.instantiateViewController(withIdentifier: "table") as! TableView
        
        self.present(myVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
