

extension UIViewController {
    
    // 네트워크 연결 확인을 위한 변수 설정
    var network: NetworkManager {
       return NetworkManager.sharedInstance
    }
    
    var mainColor: UIColor {
        return UIColor(red:0.31, green:0.53, blue:0.27, alpha:1.0)
        //return UIColor(red:0.26, green:0.36, blue:0.35, alpha:1.0)
    }
    
    var subColor: UIColor {
        return UIColor(red:1.00, green:0.82, blue:0.48, alpha:1.0)
    }
    
    var grayColor0: UIColor {
        return UIColor(red:0.97, green:0.98, blue:0.98, alpha:1.0)
    }
    
    var grayColor1: UIColor {
        return UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.0)
    }
    
    var grayColor2: UIColor {
        return UIColor(red:0.91, green:0.93, blue:0.94, alpha:1.0)
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
    
    func checkNetwork() {
        NetworkManager.isUnreachable { _ in
            self.alert("네트워크가 연결되지 않았습니다. 네트워크 연결을 확인해 주세요") {
                // NetworkManager.stopNotifier()
            // 앱을 자동으로 닫는 코드(홈버튼 클릭과 동일)
            //UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
            }
        }
    }
    
}
extension UIView {

    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 1

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}


class Constants {
    public static let cellHeight: CGFloat = 50
    public static let sectionHeight: CGFloat = 60
    public static let sectionMargin: CGFloat = 10
    public static let keywordAreaHeight: CGFloat = 200
    public static let boonLabelHeight: CGFloat = 20
    public static let boonLabelMargin: CGFloat = 2
}
