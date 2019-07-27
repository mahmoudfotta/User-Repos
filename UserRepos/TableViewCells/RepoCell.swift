//
//  RepoCell.swift
//  UserRepos
//
//  Created by Mahmoud Abolfotoh on 7/26/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {
    static let reuseIdentifier = "Repo cell id"
    
    var userImageView = NetworkImageView()
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var languageLabel = UILabel()
    var infoStackView = UIStackView()
    var forksStackView = UIStackView()
    var dateLabel = UILabel()
    var forksLabel = UILabel()
    var forksImageView = UIImageView(image: UIImage(named: "fork"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.contentMode = .scaleAspectFit
        addSubview(userImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .blue
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        addSubview(titleLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .darkGray
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        addSubview(descriptionLabel)
        
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.textColor = .gray
        languageLabel.font = UIFont.systemFont(ofSize: 14)
        
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.alignment = .fill
        infoStackView.distribution = .equalSpacing
        infoStackView.axis = .horizontal
        infoStackView.spacing = 15
        infoStackView.addArrangedSubview(dateLabel)
        infoStackView.addArrangedSubview(languageLabel)
        infoStackView.addArrangedSubview(forksStackView)
        addSubview(infoStackView)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .gray
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        
        forksLabel.textColor = .gray
        forksLabel.font = UIFont.systemFont(ofSize: 14)
        
        forksStackView.translatesAutoresizingMaskIntoConstraints = false
        forksStackView.alignment = .fill
        forksStackView.axis = .horizontal
        forksStackView.spacing = 4
        forksStackView.addArrangedSubview(forksImageView)
        forksStackView.addArrangedSubview(forksLabel)
        
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            userImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            userImageView.widthAnchor.constraint(equalToConstant: 50),
            userImageView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 3),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
           
            infoStackView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            infoStackView.trailingAnchor.constraint(lessThanOrEqualTo: descriptionLabel.trailingAnchor),
            infoStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            infoStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundImageView()
    }
    
    func roundImageView() {
        userImageView.layer.cornerRadius = 5
        userImageView.layer.masksToBounds = true
    }
}
