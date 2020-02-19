

extension UIViewController {
    
    // 네트워크 연결 확인을 위한 변수 설정
    var network: NetworkManager {
       return NetworkManager.sharedInstance
    }
    
    var mainColor: UIColor {
        
        // return UIColor(red:0.65, green:0.85, blue:1.00, alpha:1.0) // blue2
        return UIColor(red:0.45, green:0.75, blue:0.99, alpha:1.0) // blue3
        //return UIColor(red:0.31, green:0.53, blue:0.27, alpha:1.0)
        //return UIColor(red:0.26, green:0.36, blue:0.35, alpha:1.0)
    }
    
    var subColor: UIColor {
        return UIColor(red:0.20, green:0.60, blue:0.94, alpha:1.0) //blue5
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
    
    var grayColor5: UIColor {
        return UIColor(red:0.68, green:0.71, blue:0.74, alpha:1.0)
    }
    
    var grayColor6: UIColor {
        return UIColor(red:0.53, green:0.56, blue:0.59, alpha:1.0)
    }
    
    var grayColor7: UIColor {
        return UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.0)
    }
    
    var greenColor7: UIColor {
        return UIColor(red:0.22, green:0.70, blue:0.30, alpha:1.0)
    }
    
    var yellowColor7: UIColor {
        return UIColor(red:0.96, green:0.62, blue:0.00, alpha:1.0)
    }
    
    var pinkColor7: UIColor {
        UIColor(red:0.84, green:0.20, blue:0.42, alpha:1.0)
    }

    
    
    
    // upper area height를 위한 연산 프로퍼티
    var statusHeight: CGFloat {
        get {
            return UIApplication.shared.statusBarFrame.size.height
        }
    }
    
    var upperHeight: CGFloat {
        get {
            let safeHeight = UIApplication.shared.statusBarFrame.size.height
            
            let navi = self.storyboard?.instantiateViewController(withIdentifier: "side_navi") as! UINavigationController
            
            return  safeHeight + navi.navigationBar.frame.height
        }
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
    
    // delay 실행을 위한 함수
    func dispatchDelay(delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: closure)
    }
    
    // 랜덤 색상을 리턴하는 함수
    func getRandomColor()-> UIColor? {
        let color1 = UIColor(red:0.39, green:0.90, blue:0.70, alpha:1.0)
        let color2 = UIColor(red:0.55, green:0.91, blue:0.60, alpha:1.0)
        let color3 = UIColor(red:0.75, green:0.92, blue:0.46, alpha:1.0)
        let color4 = UIColor(red:0.13, green:0.79, blue:0.59, alpha:1.0)
        let color5 = UIColor(red:0.32, green:0.81, blue:0.40, alpha:1.0)
        let color6 = UIColor(red:0.58, green:0.85, blue:0.18, alpha:1.0)
        let colors = [color1, color2, color3, color4, color5, color6]
        
        return colors.randomElement()!
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

// 버튼 배경색 지정
extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        self.setBackgroundImage(backgroundImage, for: state)
    }
}

class Constants {
    // MainVC, CommunityVC의 table(header, cell) 관련 설정
    public static let cellHeight: CGFloat = 50
    public static let sectionHeight: CGFloat = 60
    public static let sectionMargin: CGFloat = 10
    public static let keywordAreaHeight: CGFloat = 200
    
    // refreshcontrol의 delaytime
    public static let delayTime: Double = 2
    
    // BoonVC의 item 사이즈 설정
    public static let boonWidthRatio: CGFloat = 4
    public static let boonHeightRatio: CGFloat = 5
    public static let boonImageHeightRatio: CGFloat = 2.7
    public static let boonLabelVerticalMarginS: CGFloat = 8
    public static let boonLabelVerticalMargin: CGFloat = 10
    public static let boonLabelHorizontalMargin: CGFloat = 7
    public static let boonItemDistance: CGFloat = 10
    
    // TabbarVC의 custom 관련 설정
    // public static let csHeaderHeight: CGFloat = 90
    public static let csTabbarHeight: CGFloat = 40
    
    // TabbarBoonVC의 custom 관련 설정
    public static let csBoonTabbarHeight: CGFloat = 40
    
    
}
