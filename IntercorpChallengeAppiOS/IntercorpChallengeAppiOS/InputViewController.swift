

import UIKit
import FirebaseAuth
import FirebaseDatabase

class InputViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var contrasenaTF: UITextField!
    @IBOutlet weak var nombreTF: UITextField!
    @IBOutlet weak var apellidoTF: UITextField!
    @IBOutlet weak var edadLabel: UILabel!
    @IBOutlet weak var fechaDeNacimientoTF: UITextField!
    
    private var datePicker: UIDatePicker?
    
    var age: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        edadLabel.text = "Edad: \(age)"
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(InputViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(InputViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        datePicker?.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
        datePicker?.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        
        fechaDeNacimientoTF.inputView  = datePicker
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY"
        
        fechaDeNacimientoTF.text = dateFormatter.string(from: datePicker.date)
        
        view.endEditing(true)
        
        
        let now = Date()
        let birthday: Date = datePicker.date
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        age = ageComponents.year!
        
        edadLabel.text = "Edad: \(age)"
    }
    
    @IBAction func registrateTapped(_ sender: UIButton) {
        
//        Auth.auth().currentUser != nil {
//            // User is signed in.
//
//            let user = Auth.auth().currentUser
//
//            if let user = user {
//                let uid = user.uid
//                let email = user.email
//                let firstName = user.displayName
//                var newPassword = "123456"
//
//                user.updatePassword(to: newPassword, completion: nil)
//
//
//
//
//
//            }
//        }
        
        Auth.auth().createUser(withEmail: emailTF.text!, password: contrasenaTF.text!, completion: { user, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let user = user {
                
                let ref = Database.database().reference()
                let usersReference = ref.child("users")
                // let usersReference = ref.child("users").child()
                let uid = user.user.uid
                
                let newUserReference = usersReference.child(uid)
                
                newUserReference.setValue(["nombre": self.nombreTF.text!,
                                           "apellido": self.apellidoTF.text!,
                                           "edad" : self.age.description,
                                           "fechaDN" : self.fechaDeNacimientoTF.text!])
                
            }
            
        })

        
//        Auth.auth().createUser(withEmail: "user97@gmail.com", password: "123456", completion: { user, error in
//            if error != nil {
//                print(error!.localizedDescription)
//                return
//            }
//
//            if let user = user {
//
//                let ref = Database.database().reference()
//                let usersReference = ref.child("users")
//                // let usersReference = ref.child("users").child()
//                let uid = user.user.uid
//
//                let newUserReference = usersReference.child(uid)
//
//                newUserReference.setValue(["nombre": self.nombreTF.text!,
//                                           "apellido": self.apellidoTF.text!,
//                                           "edad" : self.age.description,
//                                           "fechaDN" : self.fechaDeNacimientoTF.text!])
//
//            }
//
//        })
        
        
    }
    
}
