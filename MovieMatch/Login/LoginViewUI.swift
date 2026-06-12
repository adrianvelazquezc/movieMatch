//
//  LoginViewUI.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

//  LoginViewUI.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import UIKit
import Lottie

protocol LoginUIViewDelegate: AnyObject {
    func notifyUserAndPassword(name: String, password: String)
}

class LoginUIView: UIView {
    weak var delegate: LoginUIViewDelegate?
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "familyIcon")
        image.tintColor = .clear
        image.clipsToBounds = true
        return image
    }()
    
    lazy var userNameTextField: CMT_TextField = {
        let textField = CMT_TextField(placeholder: "Username")
        textField.delegate = self
        textField.text = "adrianvelazquezc"
        textField.returnKeyType = .next
        return textField
    }()

    lazy var userPasswordTextField: CMT_TextField = {
        let textField = CMT_TextField(placeholder: "Password")
        textField.delegate = self
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        textField.text = "Copel123"
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.tintColor = .orange
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        
        let paddingContainer = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        paddingContainer.addSubview(button)
        
        textField.rightView = paddingContainer
        textField.rightViewMode = .always
        return textField
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.backgroundColor = .systemGray
        button.isEnabled = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    public var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private var animationConstraints: [NSLayoutConstraint] = []
    
    public var animationView: LottieAnimationView?
    
    init(delegate: LoginUIViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        let gestoTap = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard(_:)))
        self.addGestureRecognizer(gestoTap)
        
        setUI()
        setConstraints()
    }
    
    func setUI() {
        self.backgroundColor = UIColor(red: 0.04, green: 0.08, blue: 0.11, alpha: 1.0)
        
        self.addSubview(containerView)
        containerView.addSubview(logoImageView)
        containerView.addSubview(userNameTextField)
        containerView.addSubview(userPasswordTextField)
        containerView.addSubview(continueButton)
        self.addSubview(errorLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 300),
            logoImageView.widthAnchor.constraint(equalToConstant: 300),
            
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            userNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            userNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            userPasswordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            userPasswordTextField.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),
            userPasswordTextField.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
            userPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            continueButton.topAnchor.constraint(equalTo: userPasswordTextField.bottomAnchor, constant: 50),
            continueButton.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            errorLabel.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 20),
            errorLabel.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
        ])
    }
    
    // MARK: - Actions
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        userPasswordTextField.isSecureTextEntry = !sender.isSelected
        if userPasswordTextField.isFirstResponder {
            userPasswordTextField.resignFirstResponder()
            userPasswordTextField.becomeFirstResponder()
        }
        showLottieAnimation()
    }
    
    private func showLottieAnimation() {
        if animationView != nil {
            removeLottieAnimation()
        }
        
        // Crear instancia en caliente
        let lottieView = LottieAnimationView(name: "Cat-Tongle")
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.loopMode = .playOnce
        lottieView.contentMode = .scaleAspectFit
        
        self.addSubview(lottieView)
        self.animationView = lottieView
        
        // Aplicar tus restricciones exactas
        animationConstraints = [
            lottieView.centerXAnchor.constraint(equalTo: userPasswordTextField.centerXAnchor, constant: -100),
            lottieView.centerYAnchor.constraint(equalTo: userPasswordTextField.centerYAnchor),
            lottieView.widthAnchor.constraint(equalToConstant: 200),
            lottieView.heightAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(animationConstraints)
        
        // Reproducir y limpiar al finalizar
        lottieView.play { [weak self] finished in
            if finished {
                self?.removeLottieAnimation()
            }
        }
    }
    
    private func removeLottieAnimation() {
        // Desactivar restricciones activas
        NSLayoutConstraint.deactivate(animationConstraints)
        animationConstraints.removeAll()
        
        // Quitar de la jerarquía de vistas y liberar memoria
        animationView?.removeFromSuperview()
        animationView = nil
    }
    
    @objc func dissmisKeyboard(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        processLogIn()
    }
    
    func processLogIn() {
        guard let username = userNameTextField.text, !username.isEmpty,
              let password = userPasswordTextField.text, !password.isEmpty else {
            errorLabel.text = "Username or password cannot be empty"
            return
        }
        self.delegate?.notifyUserAndPassword(name: username, password: password)
    }
}

extension LoginUIView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            userPasswordTextField.becomeFirstResponder()
        } else if textField == userPasswordTextField {
            processLogIn()
            textField.resignFirstResponder()
        }
        return true
    }
}

class CMT_TextField: UITextField {
    init(placeholder: String, defaultValue: String? = nil) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.black.cgColor
        text = defaultValue
        self.placeholder = placeholder
        layer.borderWidth = 0.5
        layer.cornerRadius = 10
        textColor = .black
        backgroundColor = .white
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        leftView = paddingView
        leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
