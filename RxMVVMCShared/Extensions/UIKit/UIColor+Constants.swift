import UIKit

public extension UIColor {
    static let tintColor = UIColor(hex: 0x00DEFF)
    static let backgroundColor = UIColor(hex: 0x2D2D37)
    static let lightGray12 = UIColor.black.withAlphaComponent(0.12)
    static let navigationBarColor = UIColor(hex: 0x373746)
    static let silver = UIColor(hex: 0xC0C0C0)
    
    // MARK: - Initializers
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(red: (hex >> 16) & 0xff, green: (hex >> 8) & 0xff, blue: hex & 0xff)
    }
    
    convenience init?(hexString: String) {
        var rgb: UInt32 = 0
        guard  Scanner(string: hexString).scanHexInt32(&rgb) else { return nil }
        
        self.init(hex: Int(rgb))
    }
}

extension UIColor {
    func imageWithColor(width: Int, height: Int) -> UIImage {
        let size = CGSize(width: width, height: height)
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
