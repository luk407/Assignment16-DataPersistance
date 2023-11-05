
import UIKit

final class LoginViewController: UIViewController {
    
    //MARK: - Properties
    private let newUserAlert = UIAlertController(title: "Welcome. You have created a new user!", message: "Click OK button to go to the home page", preferredStyle: .alert)
    private let incorrectPasswordAlert = UIAlertController(title: "Password is incorrect!", message: "Press OK to try again", preferredStyle: .alert)
    
    private let emptyFieldsAlert = UIAlertController(title: "You must fill all fields", message: "Press OK to try again", preferredStyle: .alert)
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        setupConstraints()
        setupUI()
        addActions()
        setupAlerts()
    }
    
    //MARK: - Methods
    private func addSubViews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(usernameTextField)
        mainStackView.addArrangedSubview(passwordTextField)
        mainStackView.addArrangedSubview(signInButton)
    }
    
    private func setupConstraints() {
        setupMainStackViewConstraints()
        setupUsernameTextFieldConstraints()
        setupPasswordTextFieldConstraints()
        setupSignInButtonConstraints()
    }
    
    private func setupUI() {
        setupMainStackViewUI()
        setupUsernameTextFieldUI()
        setupPasswordTextFieldUI()
        setupSignInButtonUI()
    }
    
    private func addActions() {
        signInButtonTapped()
    }
    
    private func setupAlerts() {
        setupNewUserAlert()
        setupIncorrectPasswordAlert()
        setupEmptyFieldsAlert()
    }
    
    //MARK: - Setup Alerts
    private func setupNewUserAlert() {
        let okActionNewUser = UIAlertAction(title: "OK", style: .cancel) { action in
            self.navigateToNoteListPage()
        }
        newUserAlert.addAction(okActionNewUser)
    }
    
    private func setupIncorrectPasswordAlert() {
        let okActionIncorrectPassword = UIAlertAction(title: "OK", style: .cancel)
        incorrectPasswordAlert.addAction(okActionIncorrectPassword)
    }
    
    private func setupEmptyFieldsAlert() {
        let okActionEmptyFields = UIAlertAction(title: "OK", style: .cancel)
        emptyFieldsAlert.addAction(okActionEmptyFields)
    }
    
    //MARK: - Button Actions
    private func navigateToNoteListPage() {
        let noteListPage = NoteListViewController()
        self.navigationController?.pushViewController(noteListPage, animated: true)
    }
    
    private func signInButtonTapped() {
        signInButton.addAction(UIAction(handler: { [self] action in
            if usernameTextField.text == "" || passwordTextField.text == "" {
                present(emptyFieldsAlert, animated: true, completion: nil)
            } else if checkForLogin(username: usernameTextField.text!, password: passwordTextField.text!) {
                navigateToNoteListPage()
            } else {
                present(incorrectPasswordAlert, animated: true, completion: nil)
            }
            }), for: .touchUpInside)
        }
                     
    //MARK: - KeyChain
    private func saveLoginInfo(username: String, password: String) {
        let passwordData = password.data(using: .utf8)
        
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username as AnyObject,
            kSecValueData as String: passwordData as AnyObject,
        ]
        
        SecItemAdd(query as CFDictionary, nil)
    }
    
    private func getLoginInfo(username: String) -> String? {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username as AnyObject,
            kSecReturnData as String: kCFBooleanTrue as AnyObject,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        
        guard let passwordData = result as? Data else { return nil }
        
        return String(data: passwordData, encoding: .utf8)
    }
    
    //MARK: - Check if it's a first time login
    private func checkForLogin(username: String, password: String) -> Bool {
        if UserDefaults.standard.bool(forKey: username) {
            UserDefaults.standard.set(true, forKey: username)
            if getLoginInfo(username: username) == passwordTextField.text {
                return true
            } else {
                return false
            }
        } else {
            UserDefaults.standard.set(true, forKey: username)
            saveLoginInfo(username: username, password: password)
            self.present(newUserAlert, animated: true, completion: nil)
            return true
        }
    }
    
    //MARK: - UI
    private func setupMainStackViewUI() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 10
        mainStackView.alignment = .center
    }
    
    private func setupUsernameTextFieldUI() {
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.autocapitalizationType = .none
        usernameTextField.placeholder = "Username"
        usernameTextField.leftView = UIView(frame: CGRectMake(0, 0, 10, self.usernameTextField.frame.height))
        usernameTextField.leftViewMode = .always
        usernameTextField.layer.cornerRadius = 10
        usernameTextField.layer.borderColor = UIColor.blue.cgColor
        usernameTextField.layer.borderWidth = 2
    }
    
    private func setupPasswordTextFieldUI() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.placeholder = "Password"
        passwordTextField.leftView = UIView(frame: CGRectMake(0, 0, 10, self.passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderColor = UIColor.blue.cgColor
        passwordTextField.layer.borderWidth = 2
    }
    
    private func setupSignInButtonUI() {
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.layer.cornerRadius = 10
        signInButton.layer.borderColor = UIColor.blue.cgColor
        signInButton.layer.borderWidth = 2
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(.black, for: .normal)
    }
    
    //MARK: - Constraints
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.widthAnchor.constraint(equalToConstant: 300),
            mainStackView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    private func setupUsernameTextFieldConstraints() {
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            usernameTextField.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            usernameTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
        ])
    }
    
    private func setupPasswordTextFieldConstraints() {
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            passwordTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
        ])
    }
    
    private func setupSignInButtonConstraints() {
        NSLayoutConstraint.activate([
            signInButton.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            signInButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            signInButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
        ])
    }
}
