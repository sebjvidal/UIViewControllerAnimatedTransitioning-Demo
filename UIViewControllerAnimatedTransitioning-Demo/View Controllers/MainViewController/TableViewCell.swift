//
//  CustomTableViewCell.swift
//  UIViewControllerAnimatedTransitioning-Demo
//
//  Created by Seb Vidal on 27/01/2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    private var stackView: UIStackView!
    var heroImageView: UIImageView!
    private var detailView: UIView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupStackView()
        setupHeroImageView()
        setupDetailView()
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        selectionStyle = .none
    }
    
    private func setupStackView() {
        stackView = UIStackView()
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 15
        stackView.layer.cornerCurve = .continuous
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    private func setupHeroImageView() {
        heroImageView = UIImageView()
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(heroImageView)
        
        NSLayoutConstraint.activate([
            heroImageView.heightAnchor.constraint(equalTo: heroImageView.widthAnchor, multiplier: 0.75)
        ])
    }
    
    private func setupDetailView() {
        detailView = UIView()
        detailView.backgroundColor = .secondarySystemBackground
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(detailView)
        
        NSLayoutConstraint.activate([
            detailView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        detailView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 12)
        ])
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        detailView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -12),
            descriptionLabel.bottomAnchor.constraint(equalTo: detailView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with store: Store) {
        titleLabel.text = store.name
        descriptionLabel.text = store.description
        heroImageView.image = UIImage(named: store.image)
    }
}
