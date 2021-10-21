//
//  ViewController.swift
//  MyPayments
//
//  Created by Dima Chirukhin on 21.10.2021.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    lazy var signInLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Вход в аккаунт"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = .systemBlue
        return label
    }()
    lazy var loginLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Логин"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left

        return label
    }()
    lazy var loginText: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Введите логин"
        text.returnKeyType = .next
        text.layer.borderWidth = 1
        text.layer.cornerRadius = 20
        text.layer.borderColor = UIColor.gray.cgColor
        text.leftViewMode = .always
        text.leftView = UIView(frame: CGRect(x:0, y:0, width:10, height:10))
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        text.text = "demo"
        return text
    }()
    lazy var passwordLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Пароль"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var passwordText : UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.returnKeyType = .join
        //text.isSecureTextEntry = true
        text.placeholder = "Введите пароль"
        text.text = "12345"
        text.layer.borderWidth = 1
        text.layer.cornerRadius = 20
        text.layer.borderColor = UIColor.gray.cgColor
        text.leftViewMode = .always
        text.leftView = UIView(frame: CGRect(x:0, y:0, width:10, height:10))
        return text
    }()
    lazy var joinButton :UIButton = {
        let but  = UIButton(type: .system)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setTitle("Войти", for: .normal)
        but.backgroundColor = .systemBlue
        but.layer.borderWidth = 1
        but.layer.cornerRadius = 20
        but.layer.borderColor = UIColor.gray.cgColor
        but.setTitleColor(.white, for: .normal)
        but.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        but.addTarget(self, action: #selector(joinButtonTouuch), for: .touchUpInside)
        return but
    }()
    lazy var helpButton :UIButton = {
        let but  = UIButton(type: .system)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.titleLabel?.textAlignment = .right
        but.setTitleColor(.black, for: .normal)
        but.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    
        var attrs = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor : UIColor.systemBlue,
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        var attributedString = NSMutableAttributedString(string:"")
        let buttonTitleStr = NSMutableAttributedString(string:"Забыли пароль?", attributes:attrs)
        attributedString.append(buttonTitleStr)
        but.setAttributedTitle(attributedString, for: .normal)

        but.addTarget(self, action: #selector(helpButtonTouuch), for: .touchUpInside)
        return but
    }()
    
    @objc func joinButtonTouuch(){
        DispatchQueue.main.async { [self] in
            let answ = SignIn(login: loginText.text, password: passwordText.text)
            if answ.0 == true{
                let viewController = PaymentsTableViewController()
                viewController.token = answ.1
                let navigation = UINavigationController(rootViewController: viewController)
                navigation.modalPresentationStyle = .fullScreen
                navigation.modalTransitionStyle = .flipHorizontal
                self.present(navigation, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Ошибка входа", message: answ.1, preferredStyle: .alert)
                let aletactoin = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
                alert.addAction(aletactoin)
                present(alert,animated: true,completion: nil)
            }
        }
    }
    @objc func helpButtonTouuch(){
        let alert = UIAlertController(title: "Ваши данные для входа", message: "Логин: demo \n Пароль: 12345", preferredStyle: .alert)
        let aletactoin = UIAlertAction(title: "Запомнил", style: .cancel, handler: nil)
        alert.addAction(aletactoin)
        present(alert,animated: true,completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginText {
            textField.resignFirstResponder()
            passwordText.becomeFirstResponder()
        } else if textField == passwordText {
            textField.resignFirstResponder()
            joinButton.sendActions(for: .touchUpInside)
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
        passwordText.delegate = self
        loginText.delegate = self
    }
    
    func addSubviews() {
        self.view.addSubview(signInLabel)
        self.view.addSubview(loginLabel)
        self.view.addSubview(loginText)
        self.view.addSubview(passwordLabel)
        self.view.addSubview(passwordText)
        self.view.addSubview(joinButton)
        self.view.addSubview(helpButton)

    }
    func setupConstraints() {
        signInLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 100).isActive = true
        signInLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        signInLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        signInLabel.heightAnchor.constraint(equalTo: loginLabel.heightAnchor).isActive = true
        
        loginLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        loginLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        loginLabel.topAnchor.constraint(equalTo: signInLabel.bottomAnchor,constant: 10).isActive = true
        loginLabel.heightAnchor.constraint(equalTo: signInLabel.heightAnchor).isActive = true

        loginText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        loginText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        loginText.topAnchor.constraint(equalTo: loginLabel.bottomAnchor,constant: -5).isActive = true
        loginText.heightAnchor.constraint(equalTo: loginLabel.heightAnchor).isActive = true
        
        passwordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        passwordLabel.rightAnchor.constraint(equalTo: helpButton.leftAnchor).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: loginText.bottomAnchor,constant: 20).isActive = true
        passwordLabel.heightAnchor.constraint(equalTo: loginLabel.heightAnchor).isActive = true
        passwordLabel.widthAnchor.constraint(equalTo: helpButton.widthAnchor).isActive = true
        
        helpButton.leftAnchor.constraint(equalTo: passwordLabel.rightAnchor).isActive = true
        helpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        helpButton.topAnchor.constraint(equalTo: loginText.bottomAnchor,constant: 20).isActive = true
        helpButton.heightAnchor.constraint(equalTo: loginLabel.heightAnchor).isActive = true
        
        passwordText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        passwordText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        passwordText.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor,constant: -5).isActive = true
        passwordText.heightAnchor.constraint(equalTo: loginLabel.heightAnchor).isActive = true

        joinButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        joinButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        joinButton.topAnchor.constraint(equalTo: passwordText.bottomAnchor,constant: 35).isActive = true
        joinButton.heightAnchor.constraint(equalTo: loginLabel.heightAnchor).isActive = true
    }
}

