

import UIKit
import Firebase
import Foundation
import CoreData

class TableView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var myTableView: UITableView!
    
    var ref:DatabaseReference?
    
    var myList = [Devedor]()
    
    var handle:DatabaseHandle?
    
    var qtd:Int = 0
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = myList[indexPath.row]
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "detalhes") as! EditViewController
        
        myVC.devedor.vrName = index.vrName
        myVC.devedor.vrDesc = index.vrDesc
        myVC.devedor.vrValue = index.vrValue
        myVC.index = indexPath
        
    
        self.present(myVC, animated: true, completion: nil)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        let myCell = myList[indexPath.row]
        
        cell.name?.text =  myCell.vrName
        cell.desc?.text =  myCell.vrDesc
        cell.value?.text =  myCell.vrValue
        
        
        return(cell)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        ref = Database.database().reference()
        myList.removeAll()
        loadAdd()
        loadRemoved()
        loadUpdated()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func loadAdd() {
        myList.removeAll()
        handle = ref?.child("devedores").observe(.childAdded, with: { (snapshot) in
            if let item = snapshot.value as? [String: AnyObject] {
                let name = item["Nome"]
                let descr = item["Descricao"]
                let val = item["Valor"]
                let items = Devedor(vrName: name as? String, vrDesc: descr as? String, vrValue: val as? String)
                
                self.myList.append(items)
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
            }
            
        })
    }
    
    func loadRemoved() {
        handle = ref?.child("devedores").observe(.childRemoved, with: { (snapshot) in
            if let item = snapshot.value as? [String: String] {
                let name = item["Nome"]
                
                let index = self.myList.index{ $0.vrName == name }
                
                self.myList.remove(at: index!)
                
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
                
            }
        })
    }
    
    func loadUpdated() {
            //myList.removeAll()
            handle = ref?.child("devedores").observe(.childChanged, with: { (snapshot) in
                if let item = snapshot.value as? [String: String] {
                    
                    let name = item["Nome"]
                    let descr = item["Descricao"]
                    let val = item["Valor"]
                    
                    let items = Devedor(vrName: name as? String, vrDesc: descr as? String, vrValue: val as? String)
                    
                    let index = self.myList.index{ $0.vrName == name }
                    
                    self.myList.remove(at: index!)
                    
                    self.myList.append(items)
                    
                    DispatchQueue.main.async {
                        self.myTableView.reloadData()
                    }
                }
            })
    }
    
   
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    



}
