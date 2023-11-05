
import UIKit

class NoteDetailsViewController: UIViewController {
    
    //MARK: - Properties
    var note: Note?
    
    var saveNoteAction: (()->Void)?
    
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
        configureViews()
        editButton()
    }
    
    //MARK: - Configure
    func configureViews() {
        guard let note else { return }
        headerTextField.text = note.header
        contentTextView.text = note.content
    }
    
    //MARK: - Buttons
    private func saveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
    }
    
    private func editButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
    }
    
    @objc private func saveTapped() {
        editButton()
        headerTextField.isEnabled = false
        contentTextView.isEditable = false
        saveNoteAction?()
    }
    
    @objc private func editTapped() {
        saveButton()
        headerTextField.isEnabled = true
        contentTextView.isEditable = true
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
        headerTextField.isEnabled = false
        headerTextField.leftView = UIView(frame: CGRectMake(0, 0, 10, self.headerTextField.frame.height))
        headerTextField.leftViewMode = .always
        headerTextField.font = UIFont.boldSystemFont(ofSize: 30)
        headerTextField.layer.cornerRadius = 10
        headerTextField.layer.borderWidth = 1
        headerTextField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setupContentTextFieldUI() {
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.isEditable = false
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

