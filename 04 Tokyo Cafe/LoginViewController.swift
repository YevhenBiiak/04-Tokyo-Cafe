//
//  LoginViewController.swift
//  04 Tokyo Cafe
//
//  Created by Евгений Бияк on 06.06.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var bgImageView: UIImageView = {
        let imgView = UIImageView(frame: UIScreen.main.bounds)
        imgView.image = UIImage(named: "bg-blur")
        imgView.contentMode = .scaleAspectFill
        imgView.frame = UIScreen.main.bounds
        return imgView
    }()
    
    lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 0.2109183669, blue: 0.9036154747, alpha: 1)
        label.font = UIFont(name: "Hiragino Maru Gothic ProN", size: 70)
        label.shadowColor = #colorLiteral(red: 0.5653312206, green: 0.05673880875, blue: 0.452085197, alpha: 1)
        label.shadowOffset = CGSize(width: 3, height: 4)
        label.text = "TOKYO"
        return label
    }()
    
    lazy var sublogoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        label.font = UIFont(name: "Hiragino Maru Gothic ProN", size: 50)
        label.shadowColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        label.shadowOffset = CGSize(width: 2, height: 2)
        label.text = "cafe"
        return label
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8667051792, green: 0.9142229557, blue: 0.9523989558, alpha: 1)
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 20)
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.keyboardType = .phonePad
        textField.backgroundColor = #colorLiteral(red: 0.03297083452, green: 0.06359940022, blue: 0.1634483039, alpha: 1)
        textField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = CGFloat(0.5)
        textField.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        textField.placeholder = "Phone number"
        return textField
    }()
        
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 8
        button.addTarget(nil, action: #selector(loginButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    let storage = UserDefaults.standard
    
    var codeGenerator: GeneratorProtocol!
    var phone: Int!
    var code: String!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        codeGenerator = CodeGenerator()
        code = codeGenerator.getRandomValue()
        
        addSubviews()
        addConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @objc func loginButtonTapped(sender: UIButton) {
        textField.resignFirstResponder()
        guard let text = Int(textField.text ?? "") else {
            textField.text = nil
            if phoneLabel.text == nil {
                textField.placeholder = "Enter the phone number"
            } else {
                textField.placeholder = "Enter the code"
            }
            return
        }
        if phoneLabel.text == nil {
            loginButton.isEnabled = false
            sendMessage(withCode: code, complition: {
                self.loginButton.isEnabled = true
            })
            phone = text
            phoneLabel.text = "📞  \(text)"
            textField.text = nil
            textField.placeholder = "Enter the code"
        } else if String(text) == code {
            storage.set(phone, forKey: "account")
            dismiss(animated: true)
        } else {
            textField.text = nil
            textField.placeholder = "Wrong code"
        }
    }
    
    // MARK: - Help funcs
    
    private func sendMessage(withCode code: String, complition: @escaping () -> Void) {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            let alert = UIAlertController(title: "Your code: \(code)", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                complition()
            }
            alert.addAction(action)
            action.isEnabled = false
            self.present(alert, animated: true)
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                action.isEnabled = true
            }
        }
    }

    private func addSubviews() {
        view.addSubview(bgImageView)
        view.addSubview(logoLabel)
        view.addSubview(sublogoLabel)
        view.addSubview(textField)
        view.addSubview(loginButton)
        view.addSubview(phoneLabel)
    }
    private func addConstraints() {
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        logoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        logoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        sublogoLabel.translatesAutoresizingMaskIntoConstraints = false
        sublogoLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 20).isActive = true
        sublogoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        sublogoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        phoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35).isActive = true
        phoneLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -40).isActive = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: CGFloat(44)).isActive = true
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 40).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
    }
}
