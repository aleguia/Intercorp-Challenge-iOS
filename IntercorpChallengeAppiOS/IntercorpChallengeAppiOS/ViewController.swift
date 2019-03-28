

import UIKit
import FirebaseUI
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func iniciarSesionTapped(_ sender: UIButton) {
        
        // Get the default auth UI object
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil  else {
            // log the error
            return
        }
        
        // Set ourselves as the delegate
        authUI?.delegate = self
        
        // Get a reference to the auth UI view controller
        let authViewController = authUI!.authViewController()
        
        // Show it
        present(authViewController, animated: true, completion: nil)
        
    }
}

extension ViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        // Check if there was an error
        guard error == nil else {
            // Log the error
            return
        }
        
        //authDataResult?.user.uid
        
        performSegue(withIdentifier: "goHome", sender: self)
    }
}
