//
//  RegisterationController.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/06.
//

import UIKit
import Firebase

class RegistrationController : UIViewController {
  
  //MARK: - Properties
  
  private var viewModel = RegistrationViewModel()
  
  weak var delegate : AuthenticationDelegate?
  
  private var profileImage : UIImage?
  
  private let plusPhotoButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
    button.tintColor = .white
    button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
    button.imageView?.contentMode = .scaleAspectFill
    button.clipsToBounds = true
    return button
  }()
  
  private lazy var emailContainerView : InputContainerView = {
    let containerView = InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
    return containerView
  }()
  
  private lazy var fullNameContainerView : InputContainerView = {
    let containerView = InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullnameTextField)
    return containerView
  }()
  
  private lazy var userNameContainerView : InputContainerView = {
    let containerView = InputContainerView(image:  #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: usernameTextField)
    return containerView
  }()
  
  private lazy var passwordContainerView : InputContainerView = {
    let containerView = InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
    return containerView
  }()
  
  private let emailTextField = CustomTextField(placeholder: "Email")
  private let fullnameTextField = CustomTextField(placeholder: "Full Name")
  private let usernameTextField = CustomTextField(placeholder: "Username")
  
  private let passwordTextField : CustomTextField = {
    let tf = CustomTextField(placeholder: "Password")
    tf.isSecureTextEntry = true
    return tf
  }()
  
  private let signupButton : CustomButton = {
    let button = CustomButton(title: "Sign Up")
    button.isEnabled = false
    button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
    return button
  }()
  
  private let alreadyHaveAccountButton : UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor : UIColor.white])
    attributedTitle.append(NSAttributedString(string: "Log In", attributes: [.font : UIFont.boldSystemFont(ofSize: 16), .foregroundColor : UIColor.white]))
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
    return button
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureNotificationObservers()
  }
  
  //MARK: - Functions
  func configureUI() {
    configureGradientLayer()
    
    let stack = UIStackView(arrangedSubviews: [emailContainerView, fullNameContainerView, userNameContainerView, passwordContainerView, signupButton])
    stack.axis = .vertical
    stack.spacing = 16
    
    [plusPhotoButton, stack, alreadyHaveAccountButton].forEach {
      view.addSubview($0)
    }
    
    plusPhotoButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
      $0.width.equalTo(200)
      $0.height.equalTo(200)
    }
    
    signupButton.snp.makeConstraints {
      $0.height.equalTo(50)
    }
    
    stack.snp.makeConstraints {
      $0.top.equalTo(plusPhotoButton.snp.bottom).offset(25)
      $0.leading.equalToSuperview().offset(32)
      $0.trailing.equalToSuperview().offset(-32)
    }
    
    alreadyHaveAccountButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(32)
      $0.trailing.equalToSuperview().offset(-32)
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
  
  func configureNotificationObservers() {
    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  //MARK: - Selectors
  @objc func handleSelectPhoto() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    present(imagePickerController, animated: true, completion: nil)
  }
  
  @objc func handleShowLogin() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func handleRegistration() {
    guard let email = emailTextField.text else { return }
    guard let password = passwordTextField.text else { return }
    guard let fullname = fullnameTextField.text else { return }
    guard let username = usernameTextField.text?.lowercased() else { return }
    guard let profileImage = profileImage else {return}
    
    let credentials = RegistrationCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
    
    showLoader(true, withText: "Signing You Up")
    AuthService.shared.createUser(credentials: credentials) { error in
      if let error = error {
        print("Debug : Failed to create user : \(error.localizedDescription)")
        self.showLoader(false)
        return
      }
      self.showLoader(false)
      self.delegate?.authenticationComplete()
    }
  }
  
  @objc func textDidChange(sender : UITextField) {
    if sender == emailTextField {
      viewModel.email = sender.text
    } else if sender == passwordTextField {
      viewModel.password = sender.text
    } else if sender == fullnameTextField {
      viewModel.fullname = sender.text
    } else {
      viewModel.username = sender.text
    }
    checkFormStatus()
  }
  
  @objc func keyboardWillShow() {
    if view.frame.origin.y == 0 {
      self.view.frame.origin.y -= 88
    }
  }
  
  @objc func keyboardWillHide() {
    if view.frame.origin.y != 0 {
      self.view.frame.origin.y = 0
    }
  }
}

  //MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension RegistrationController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.originalImage] as? UIImage
    profileImage = image
    plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    plusPhotoButton.layer.borderColor = UIColor.white.cgColor
    plusPhotoButton.layer.borderWidth = 3.0
    plusPhotoButton.layer.cornerRadius = 200 / 2
    dismiss(animated: true, completion: nil)
  }
}

  //MARK: - AuthenticationControllerProtocol
extension RegistrationController : AuthenticationControllerProtocol {
  func checkFormStatus() {
    if viewModel.formIsValid {
      signupButton.isEnabled = true
      signupButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    } else {
      signupButton.isEnabled = false
      signupButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    }
  }
}
