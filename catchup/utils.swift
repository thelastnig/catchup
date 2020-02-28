extension UIViewController {
    
    // 네트워크 연결 확인을 위한 변수 설정
    var network: NetworkManager {
       return NetworkManager.sharedInstance
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
    
    // rotation animation
    func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 0.5
        rotation.isCumulative = true
        
        let rotation2: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation2.toValue = NSNumber(value: Double.pi * 2)
        rotation2.duration = 0.35
        rotation2.beginTime = 0.75
        rotation2.isCumulative = true
        
//        let jumpUp: CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.y")
//        jumpUp.toValue = -10
//        jumpUp.duration = 0.25
//        jumpUp.beginTime = 1
//        jumpUp.isCumulative = true
        
        
        let pause: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        pause.fromValue = 1
        pause.toValue = 1
        pause.beginTime = 2
        pause.duration = 3
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [rotation, rotation2, pause]
        animationGroup.duration = 5
        animationGroup.beginTime = 2
        animationGroup.repeatCount = .greatestFiniteMagnitude
        
        self.layer.add(animationGroup, forKey: "rotation&pause")
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

// 라벨에 letter spacing 설정
extension UILabel {
  func addCharacterSpacing(kernValue: Double = 1.15) {
    if let labelText = text, labelText.count > 0 {
      let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
      attributedText = attributedString
    }
  }
}

