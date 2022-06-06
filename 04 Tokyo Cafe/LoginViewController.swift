//
//  LoginViewController.swift
//  04 Tokyo Cafe
//
//  Created by Евгений Бияк on 06.06.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    let bgImageView: UIImageView = {
        let imgView = UIImageView(frame: UIScreen.main.bounds)
        imgView.image = UIImage(named: "BGImage")
        imgView.contentMode = .scaleAspectFill
        imgView.frame = UIScreen.main.bounds
        imgView.alpha = 0.2
        return imgView
    }()
    
    let logoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = #colorLiteral(red: 1, green: 0.2109183669, blue: 0.9036154747, alpha: 1)
        label.font = UIFont(name: "Hiragino Maru Gothic ProN", size: 80)
        label.shadowColor = #colorLiteral(red: 0.5653312206, green: 0.05673880875, blue: 0.452085197, alpha: 1)
        label.shadowOffset = CGSize(width: 3, height: 4)
        label.numberOfLines = 2
        label.text = "TOKYO"
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 20)
        return label
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.keyboardType = .phonePad
        textField.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = CGFloat(0.5)
        textField.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        textField.placeholder = "Phone number"
        return textField
    }()
        
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 8
        button.addTarget(nil, action: #selector(loginButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        addConstraints()
//        addBlurEffect()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @objc func loginButtonTapped(sender: UIButton) {
        loginButton.isEnabled = false
        phoneTextField.resignFirstResponder()
        phoneLabel.text = phoneTextField.text
        phoneTextField.text = nil
        phoneTextField.placeholder = "Enter the code"
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.showAlertWithCode()
        }
        
    }
    
    // MARK: - Help funcs
    
    private func showAlertWithCode() {
        let alert = UIAlertController(title: "Your code", message: "3577", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.loginButton.isEnabled = true
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func addSubviews() {
        view.addSubview(bgImageView)
        view.addSubview(logoLabel)
        view.addSubview(phoneTextField)
        view.addSubview(loginButton)
        view.addSubview(phoneLabel)
    }
    private func addConstraints() {
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        logoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        logoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        phoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35).isActive = true
        phoneLabel.bottomAnchor.constraint(equalTo: phoneTextField.topAnchor, constant: -40).isActive = true
        
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        phoneTextField.heightAnchor.constraint(equalToConstant: CGFloat(50)).isActive = true
        phoneTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 40).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
    }
    
    private func addBlurEffect() {
        let backView = UIView(frame: bgImageView.bounds)
        backView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 5/100)
        bgImageView.addSubview(backView)

        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bgImageView.bounds
        bgImageView.addSubview(blurEffectView)
    }

}
