
import UIKit

final class NoteTableViewCell: UITableViewCell {

    //MARK: - Properties
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let noteHeaderLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let noteContentLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubViews()
        setupConstraints()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Prepare for Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        noteHeaderLabel.text = nil
        noteContentLabel.text = nil
    }
    
    //MARK: - Methods
    private func addSubViews() {
        self.addSubview(mainStackView)
        mainStackView.addArrangedSubview(noteHeaderLabel)
        mainStackView.addArrangedSubview(noteContentLabel)
    }
    
    private func setupConstraints() {
        setupMainStackViewConstraints()
        setupNoteHeaderLabelConstraints()
        setupNoteContentLabelConstraints()
    }
    
    private func setupUI() {
        setupMainStackViewUI()
        setupNoteHeaderLabelUI()
        setupNoteContentLabelUI()
    }
    
    func configureCell(with model: Note) {
        noteHeaderLabel.text = model.header
        noteContentLabel.text = model.content
    }
    
    //MARK: - UI
    private func setupMainStackViewUI() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.layoutMargins = .init(top: 8, left: 24, bottom: 8, right: 24)
        mainStackView.axis = .vertical
        mainStackView.spacing = 5
        mainStackView.alignment = .center
        mainStackView.distribution = .fillProportionally
    }
    
    private func setupNoteHeaderLabelUI() {
        noteHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        noteHeaderLabel.font = UIFont.boldSystemFont(ofSize: 30)
        noteHeaderLabel.textAlignment = .left
        noteHeaderLabel.textColor = .black
        noteHeaderLabel.numberOfLines = 1
    }
    
    private func setupNoteContentLabelUI() {
        noteContentLabel.translatesAutoresizingMaskIntoConstraints = false
        noteContentLabel.font = UIFont.systemFont(ofSize: 20)
        noteContentLabel.textAlignment = .left
        noteContentLabel.textColor = .black
        noteContentLabel.numberOfLines = 4
    }
    
    //MARK: - Constraints
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),
            mainStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupNoteHeaderLabelConstraints() {
        NSLayoutConstraint.activate([
            noteHeaderLabel.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            noteHeaderLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            noteHeaderLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            noteHeaderLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setupNoteContentLabelConstraints() {
        NSLayoutConstraint.activate([
            noteContentLabel.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            noteContentLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            noteContentLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            noteContentLabel.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
}
