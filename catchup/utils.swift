extension UIViewController {
    
    var mainColor: UIColor {
        return UIColor(red:0.31, green:0.53, blue:0.27, alpha:1.0)
        //return UIColor(red:0.26, green:0.36, blue:0.35, alpha:1.0)
    }
    
    var subColor: UIColor {
        return UIColor(red:1.00, green:0.82, blue:0.48, alpha:1.0)
    }
    
    func alert(_ message: String, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
                completion?()
            }
            
            alert.addAction(okAction)
            self.present(alert, animated: false)
        }
    }
}
