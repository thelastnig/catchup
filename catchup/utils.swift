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
extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
}


class Constants {
    public static let cellHeight: CGFloat = 38
    public static let sectionHeight: CGFloat = 50
    public static let keywordAreaHeight: CGFloat = 200
    public static let boonLabelHeight: CGFloat = 40
    public static let boonLabelMargin: CGFloat = 5
}
