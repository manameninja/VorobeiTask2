//
//  ViewController.swift
//  VorobeiTask2
//
//  Created by Даниил Павленко on 06.04.2024.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    let firstButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("First Button", for: .normal)
        return button
    }()

    let secondButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Second Medium Button", for: .normal)
        return button
    }()

    let thirdButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Third", for: .normal)
        return button
    }()

    lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstButton, secondButton, thirdButton])
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(buttonsStackView)
        
        //add constraints
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.leftAnchor.constraint(lessThanOrEqualTo: view.leftAnchor),
            buttonsStackView.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor)
        ])

        thirdButton.touch = { [weak self] in
            self?.showNewViewController()
        }
    }
    
    //MARK: - Methods
    func showNewViewController() {
        let viewController = ModalController()
        viewController.modalPresentationStyle = .popover
        present(viewController, animated: true, completion: { })
    }
}

class ModalController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

class CustomButton: UIButton {

    var touch: (() -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        configureButtons()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureButtons() {
        contentHorizontalAlignment = .center
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBlue
        config.imagePlacement = .trailing
        config.contentInsets = .init(top: 10, leading: 14, bottom: 10, trailing: 14)
        config.image = UIImage(systemName: "arrow.right.circle.fill")
        config.imagePadding = 8
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)

        configuration = config
    }

    @objc func touchUp() {
        touch?()
    }
    
    //MARK: - Change color button
    override func tintColorDidChange() {
        switch tintAdjustmentMode {
        case .dimmed:
            var config = configuration
            config?.background.backgroundColor = .systemGray2
            config?.baseForegroundColor = .systemGray3
            configuration = config
        case .normal:
            var config = configuration
            config?.background.backgroundColor = .systemBlue
            config?.baseForegroundColor = .white
            configuration = config
        default:
            break
        }
    }
}

//MARK: - Animate ex
extension UIButton {
    func touchIn() {
            UIView.animate(withDuration: 0.1, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: {
                self.transform = .init(scaleX: 0.9, y: 0.9)
            })
        }
        
        func touchEnd() {
            UIView.animate(withDuration: 0.1, delay: 0, options: [.allowUserInteraction, .curveEaseOut], animations: {
                self.transform = .identity
            })
        }
        
        open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            touchIn()
        }
        
        open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesEnded(touches, with: event)
            touchEnd()
        }
}

