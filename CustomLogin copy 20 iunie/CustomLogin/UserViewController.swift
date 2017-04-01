//Poti sa stergi asta
//Nu mai exista view-ul
//!!!!!!!!!!!!!!!!!!!!!!!!





import UIKit
import Parse

class UserViewController: UIViewController{
    
    @IBOutlet weak var textview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = PFUser.currentUser()?.username
        textview.text="\(currentUser!)"
 

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logoutAction(sender: AnyObject) {
        PFUser.logOut()
        let alert = UIAlertView(title: "Success", message: "You are now logged out.", delegate: self, cancelButtonTitle: "OK")
        alert.show()
        self.performSegueWithIdentifier("Usertofirstview", sender: self)
    }
}