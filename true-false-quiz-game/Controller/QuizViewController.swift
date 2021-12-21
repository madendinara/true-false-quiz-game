//
//  QuizViewController.swift
//  true-false-quiz-game
//
//  Created by Динара Зиманова on 12/20/21.
//

import UIKit
import SnapKit

class QuizViewController: UIViewController {

    // MARK: - Internal properties
    var timer: Timer?
    var state = State(questions: questions)

    // MARK: - Properties
    public lazy var countsView: UIView = {
        let view = UIView()
        return view
    }()
    public lazy var timeProgressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.layer.borderColor = UIColor.white.cgColor
        label.text = "00:15"
        label.backgroundColor = .green
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .light)
        return label
    }()
    public lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .black
        label.text = "Question"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    public lazy var trueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .green
        button.setTitle("👍True", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(handleAnswer), for: .touchUpInside)
        return button
    }()
    public lazy var falseButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.setTitle("👎False", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(handleAnswer), for: .touchUpInside)
        return button
    }()
    public lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [trueButton, falseButton])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    lazy var messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 48, weight: .semibold)
        label.alpha = 0
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        startGame()
    }
    
    // MARK: - Methods
    func configureView() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.view.addSubview(messageLabel)
        [countsView, timeProgressLabel, questionLabel, buttonsStackView].forEach { view.addSubview($0) }
        makeConstaints()
    }
    
    func updateProgress(to progress: Double) {
        countsView.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview().multipliedBy(progress)
            make.height.equalTo(32)
            make.leading.equalToSuperview()
        }
    }
    
    func makeConstaints() {
        updateProgress(to: 0)
        timeProgressLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.45)
            make.height.equalTo(45)
            make.top.equalTo(countsView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(timeProgressLabel.snp.bottom).offset(24)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(questionLabel)
            make.top.equalTo(questionLabel.snp.bottom).offset(16)
            make.height.equalTo(80)
        }
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

