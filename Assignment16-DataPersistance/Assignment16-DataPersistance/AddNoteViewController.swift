
import UIKit

class AddNoteViewController: UIViewController {
    
    //MARK: - Properties
    var addNoteAction: (()->Void)?
    
    private let emptyFieldsAlert = UIAlertController(title: "You must fill all fields", message: "Press OK to try again", preferredStyle: .alert)
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    let headerTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    let contentTextView: UITextView = {
        let textField = UITextView()
        return textField
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        setupConstraints()
        setupUI()
        addSaveButton()
    }
    
    //MARK: - Methods
    private func addSubViews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(headerTextField)
        mainStackView.addArrangedSubview(contentTextView)
    }
    
    private func setupConstraints() {
        setupMainStackViewConstraints()
        setupHeaderTextFieldConstraints()
        setupContentTextFieldConstraints()
    }
    
    private func setupUI() {
        setupMainStackViewUI()
        setupHeaderTextFieldUI()
        setupContentTextFieldUI()
        setupEmptyFieldsAlert()
    }
    
    //MARK: - Buttons
    private func addSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
    }
    
    @objc private func saveTapped() {
        if headerTextField.text == "" || contentTextView.text == "" {
            present(emptyFieldsAlert, animated: true, completion: nil)
        } else {
            addNoteAction?()
            navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - Allerts
    private func setupEmptyFieldsAlert() {
        let okActionEmptyFields = UIAlertAction(title: "OK", style: .cancel)
        emptyFieldsAlert.addAction(okActionEmptyFields)
    }
    
    //MARK: - UI
    private func setupMainStackViewUI() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.alignment = .center
        mainStackView.distribution = .fillProportionally
    }
    
    private func setupHeaderTextFieldUI() {
        headerTextField.translatesAutoresizingMaskIntoConstraints = false
        headerTextField.placeholder = "Note Title"
        headerTextField.leftView = UIView(frame: CGRectMake(0, 0, 10, self.headerTextField.frame.height))
        headerTextField.leftViewMode = .always
        headerTextField.font = UIFont.boldSystemFont(ofSize: 30)
        headerTextField.layer.cornerRadius = 10
        headerTextField.layer.borderWidth = 1
        headerTextField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setupContentTextFieldUI() {
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        contentTextView.font = UIFont.systemFont(ofSize: 20)
        contentTextView.layer.cornerRadius = 10
        contentTextView.layer.borderWidth = 1
        contentTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    //MARK: - Constraints
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    private func setupHeaderTextFieldConstraints() {
        NSLayoutConstraint.activate([
            headerTextField.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            headerTextField.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            headerTextField.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            headerTextField.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    private func setupContentTextFieldConstraints() {
        NSLayoutConstraint.activate([
            contentTextView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            contentTextView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            contentTextView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            contentTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }
}
