//
//  MainTableViewCell.swift
//  TableViewExample
//
//  Created by Fury on 29/05/2019.
//  Copyright © 2019 Fury. All rights reserved.
//

import SnapKit

class SRTableViewCell: UITableViewCell {

    static let identifier = "MainTableViewCell"

    let placeName: UILabel = {
        let placeName = UILabel()
        placeName.translatesAutoresizingMaskIntoConstraints = false
        placeName.font = UIFont.boldSystemFont(ofSize: 17)
        return placeName
    }()

    let address: UILabel = {
        let address = UILabel()
        address.translatesAutoresizingMaskIntoConstraints = false
        address.font = UIFont.systemFont(ofSize: 14)
        return address
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addContentView()
        autoLayout()
    }

    private func addContentView() {
        contentView.addSubview(placeName)
        contentView.addSubview(address)
    }

    private func autoLayout() {
        placeName.snp.makeConstraints {(maker) in
            maker.top.equalTo(self.snp.top).offset(8)
            maker.leading.equalTo(self.snp.leading).inset(10)
            maker.trailing.equalTo(self.snp.trailing).inset(10)
            maker.width.equalTo(self.snp.width).inset(10)
        }
        address.snp.makeConstraints {(maker) in
            maker.top.equalTo(placeName.snp.bottom).offset(5)
            maker.leading.equalTo(self.snp.leading).inset(10)
            maker.trailing.equalTo(self.snp.trailing).inset(10)
            maker.width.equalTo(self.snp.width).inset(10)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
