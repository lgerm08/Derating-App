
import UIKit

class HomeViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "DERATING APP"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor().RGBColor(r: 50, g: 161, b: 230)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var goToDeratingScreen: ButtonComponent = {
        let buttonView = ButtonComponent(title: "Calcular corrente de Derating")
        buttonView.button.addTarget(self, action: #selector(routeToDeratingScreen), for: .touchUpInside)
        return buttonView
    }()
    
    private lazy var goToLifeSpanScreen: ButtonComponent = {
        let buttonView = ButtonComponent(title: "Estimar Vida Útil")
        buttonView.button.addTarget(self, action: #selector(routeToLifeSpanScreen), for: .touchUpInside)
        return buttonView
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
        view.backgroundColor = .white
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
}

