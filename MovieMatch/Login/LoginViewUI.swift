//
//  LoginViewUI.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import UIKit

protocol LoginUIViewDelegate: AnyObject {
    func notifyUserAndPassword(name: String, password: String)
}

class LoginUIView: UIView {
    weak var delegate: LoginUIViewDelegate?
    
    
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
        
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    @objc func dissmisKeyboard(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
}
