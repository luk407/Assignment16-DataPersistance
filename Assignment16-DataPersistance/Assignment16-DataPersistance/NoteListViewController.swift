
import UIKit

class NoteListViewController: UIViewController {

    //MARK: - Properties
    var notes = Note.dummyData
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let notesTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        notesTableView.delegate = self
        notesTableView.dataSource = self
        addSubViews()
        setupConstraints()
        setupUI()
    }
    
    //MARK: - Methods
    private func addSubViews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(notesTableView)
    }
    
    private func setupConstraints() {
        setupMainStackViewConstraints()
        setupNotesTableViewConstraints()
    }
    
    private func setupUI() {
        setupMainStackViewUI()
        setupNotesTableViewUI()
        registerNoteTableViewCell()
        addNavBarButtons()
    }
    
    private func registerNoteTableViewCell() {
        notesTableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "noteCell")
    }
    
    //MARK: - UI
    private func setupMainStackViewUI() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.alignment = .center
    }
    
    private func setupNotesTableViewUI() {
        notesTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addNavBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    //MARK: - Actions
    @objc private func addTapped() {
        let addPage = AddNoteViewController()
        navigationController?.pushViewController(addPage, animated: true)
        
        addPage.addNoteAction = {
            self.notes.append(Note(header: addPage.headerTextField.text ?? "", content: addPage.contentTextView.text ?? ""))
            self.notesTableView.reloadData()
        }
    }
    
    //MARK: - Constraints
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupNotesTableViewConstraints() {
        NSLayoutConstraint.activate([
            notesTableView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            notesTableView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            notesTableView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            notesTableView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
        ])
    }
}

//MARK: - Extensions
extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let note = notes[indexPath.row]
        cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        if let noteCell = cell as? NoteTableViewCell {
            noteCell.configureCell(with: note)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Notes"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsPage = NoteDetailsViewController()
        detailsPage.note = notes[indexPath.row]
        navigationController?.pushViewController(detailsPage, animated: true)
        
        detailsPage.saveNoteAction = {
            self.notes[indexPath.row].header = detailsPage.headerTextField.text!
            self.notes[indexPath.row].content = detailsPage.contentTextView.text!
            self.notesTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = notes[indexPath.row]
            if let index = notes.firstIndex(where: { $0 === noteToDelete}) {
                notes.remove(at: index)
            }
            notesTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
