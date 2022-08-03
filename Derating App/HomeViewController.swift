
import UIKit

class HomeViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TÏTULO"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = RGBColor(r: 214, g: 164, b: 64)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var goToDeratingScreen: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.backgroundColor = RGBColor(r: 214, g: 164, b: 64)
        button.tintColor = RGBColor(r: 245, g: 238, b: 184)
        button.setTitle("Calcular corrente de Derating", for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(routeToDeratingScreen), for: .touchUpInside)
        return button
    }()
    
    private lazy var goToLifeSpanScreen: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.backgroundColor = RGBColor(r: 214, g: 164, b: 64)
        button.tintColor = RGBColor(r: 245, g: 238, b: 184)
        button.setTitle("Estimar Vida Útil", for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(routeToLifeSpanScreen), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    
    @objc func routeToDeratingScreen() {
        let newViewController = DeratingHomeViewController()
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @objc func routeToLifeSpanScreen() {
        let newViewController = LifeSpanViewController()
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func addSubviews() {
        view.backgroundColor = RGBColor(r: 68, g: 127, b: 166)
        view.addSubview(titleLabel)
        view.addSubview(goToDeratingScreen)
        view.addSubview(goToLifeSpanScreen)
        addConstraints()
    }
    
    
    func addConstraints() {
        titleLabel.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 70,
            leftConstant: 30,
            rightConstant: 30
        )
        goToDeratingScreen.anchor(
            top: titleLabel.bottomAnchor,
            left: titleLabel.leftAnchor,
            right: titleLabel.rightAnchor,
            topConstant: 90,
            heightConstant: 100
        )
        goToLifeSpanScreen.anchor(
            top: goToDeratingScreen.bottomAnchor,
            left: goToDeratingScreen.leftAnchor,
            right: goToDeratingScreen.rightAnchor,
            topConstant: 50,
            heightConstant: 100
        )
    }
    
    func RGBColor(r: Float, g: Float, b: Float) -> UIColor {
        return UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 1.0)
    }
}

