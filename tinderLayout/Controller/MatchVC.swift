//
//  MatchVC.swift
//  tinderLayout
//
//  Created by P21 Sistemas on 13/03/20.
//  Copyright © 2020 Lucas Inocencio. All rights reserved.
//

import UIKit

class MatchVC: UIViewController, UITextFieldDelegate {
    
    var usuario: Usuario? {
        didSet {
            if let usuario = usuario {
                imagePhotoView.image = UIImage(named: usuario.foto)
                messageLabel.text = "\(usuario.nome) curtiu você tambem"
            }
        }
    }
    
    let imagePhotoView: UIImageView = .fotoImageView(named: "pessoa-1")
    let likeImageView: UIImageView = .fotoImageView(named: "icone-like")
    let messageLabel: UILabel = .textBoldLabel(18, textColor: .white, numberOfLines: 1)
    
    let mensagemTxt: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        textField.placeholder = "Diag algo legal"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.textColor = .darkText
        textField.returnKeyType = .go
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.rightViewMode = .always
        
        return textField
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enviar", for: .normal)
        button.setTitleColor((UIColor(red: 62/255, green: 163/255, blue: 255/255, alpha: 1)), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Voltar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addSubview(imagePhotoView)
        imagePhotoView.fillSuperView()
        
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor]
        
        imagePhotoView.layer.addSublayer(gradient)
        
        mensagemTxt.delegate = self
        messageLabel.textAlignment = .center
        
        backButton.addTarget(self, action: #selector(handlerBack), for: .touchUpInside)
        
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        likeImageView.contentMode = .scaleAspectFit
        
        mensagemTxt.addSubview(sendButton)
        sendButton.fill(top: mensagemTxt.topAnchor, leading: nil, tralling: mensagemTxt.trailingAnchor, bottom: mensagemTxt.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16))
        
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [likeImageView, messageLabel, mensagemTxt, backButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        view.addSubview(stackView)
        stackView.fill(top: nil, leading: view.leadingAnchor, tralling: view.trailingAnchor, bottom: view.bottomAnchor, padding: .init(top: 0, left: 32, bottom: 46, right: 32))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.sendMessage()
        return true
    }
    
    @objc func handlerBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                UIView.animate(withDuration: duration) {
                    self.view.frame = CGRect(
                        x: UIScreen.main.bounds.origin.x,
                        y: UIScreen.main.bounds.origin.y,
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height - keyboardSize.height
                    )
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardHide(notification: NSNotification) {
        
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            UIView.animate(withDuration: duration) {
                self.view.frame = UIScreen.main.bounds
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    @objc func sendMessage() {
        if let mensagem = self.mensagemTxt.text {
            print(mensagem)
        }
    }
    
    
}


