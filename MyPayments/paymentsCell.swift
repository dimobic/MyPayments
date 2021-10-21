//
//  paymentsCell.swift
//  MyPayments
//
//  Created by Dima Chirukhin on 21.10.2021.
//

import UIKit

class paymentsCell: UITableViewCell {

    func labelCreate (_ label : UILabel) -> UILabel{
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }
    lazy var descLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        return labelCreate(label)
    }()
    lazy var amountLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .systemBlue
        return labelCreate(label)
    }()
    lazy var createdLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        return labelCreate(label)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()}
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initConstraints()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override func setSelected(_ selected: Bool, animated: Bool) { super.setSelected(selected, animated: animated) }

    func initConstraints(){
        self.contentView.addSubview(descLabel)
        self.contentView.addSubview(amountLabel)
        self.contentView.addSubview(createdLabel)
        
        descLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        descLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        descLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        //descLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, constant: -20).isActive = true
        
        amountLabel.topAnchor.constraint(equalTo: self.descLabel.bottomAnchor).isActive = true
        amountLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        amountLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        amountLabel.bottomAnchor.constraint(equalTo: self.createdLabel.topAnchor,constant: -5).isActive = true
        //amountLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, constant: -20).isActive = true
        
        createdLabel.topAnchor.constraint(equalTo: self.amountLabel.bottomAnchor).isActive = true
        createdLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        createdLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -5).isActive = true
        createdLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        //createdLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, constant: -20).isActive = true
        
    }
}
