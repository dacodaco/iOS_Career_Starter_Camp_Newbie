//
//  RegisterViewController.swift
//  ProjectManager
//
//  Created by YB on 2021/06/29.
//

import UIKit

class RegisterViewController: UIViewController {

    let leftButton = UIBarButtonItem.init(title: "Cancel",
                                          style: .done,
                                          target: self,
                                          action: #selector(didHitCancelButton))

    var rightButton = UIBarButtonItem.init(title: "Done",
                                           style: .done,
                                           target: self,
                                           action: #selector(didHitDoneButton))

    let registerTitle: UITextField = {
        let registerTitle = UITextField()

        registerTitle.backgroundColor = .white
        registerTitle.layer.shadowOffset = CGSize(width: 0, height: 3)
        registerTitle.layer.shadowColor = UIColor.black.cgColor
        registerTitle.layer.shadowOpacity = 0.6
        registerTitle.clipsToBounds = false
        registerTitle.placeholder = "Title"

        registerTitle.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: registerTitle.frame.height))
        registerTitle.leftViewMode = .always
        registerTitle.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: registerTitle.frame.height))
        registerTitle.rightViewMode = .always

        return registerTitle
    }()

    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()

        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    let registerDescription: UITextView = {
        let description = UITextView()

        description.backgroundColor = .white
        description.layer.shadowOffset = CGSize(width: 0, height: 3)
        description.layer.shadowColor = UIColor.black.cgColor
        description.layer.shadowOpacity = 0.6
        description.clipsToBounds = false
        description.text = "설명을 입력해주세요"
        description.textColor = UIColor.lightGray
        description.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        return description
    }()

    let stackView: UIStackView = {
        let myStackView = UIStackView()

        myStackView.axis = .vertical
        myStackView.alignment = .fill
        myStackView.spacing = 10
        
        return myStackView
    }()
    
    @objc func didHitCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didHitDoneButton() {
        self.dismiss(animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        registerDescription.delegate = self
        
        navigationItem.title = "TODO"
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(registerTitle)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(registerDescription)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        registerTitle.translatesAutoresizingMaskIntoConstraints = false
        registerDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            registerTitle.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1)
        ])
    }
}

extension RegisterViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "설명을 입력해주세요"
            textView.textColor = UIColor.lightGray
        }
    }
}
