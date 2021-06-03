//
//  SearchRequestViewController.swift
//  GetHomeSafe
//
//  Created by khs on 2021/06/02.
//

import RIBs
import RxSwift
import UIKit
import SVGKit

protocol SearchRequestPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SearchRequestViewController: UIViewController, SearchRequestPresentable, SearchRequestViewControllable {

    weak var listener: SearchRequestPresentableListener?

    private var placeData: [PlaceData] = []

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SRTableViewCell.self, forCellReuseIdentifier: SRTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addPlaceDataSet(placeName: "경북대", address: "대구..")
        addPlaceDataSet(placeName: "대구대", address: "경북..")
        addPlaceDataSet(placeName: "서울대", address: "서울..")
        
        let upperView = makeUpperView()
        makeTableView(below: upperView)
        
        view.backgroundColor = UIColor.white
    }

    private func addPlaceDataSet(placeName: String, address: String) {
        placeData.append(PlaceData.init(placeName: placeName, address: address))
    }

    private func makeUpperView() -> UIView {
        let upperView = UIView()
        upperView.backgroundColor = UIColor(displayP3Red: 123/255, green: 162/255, blue: 239/255, alpha: 1)
        view.addSubview(upperView)
        upperView.snp.makeConstraints {(maker) in
            maker.top.equalTo(self.view)
            maker.left.right.equalTo(self.view.safeAreaLayoutGuide)
            maker.height.equalTo(110)
        }
        
        let searchField = makeTextField(upperView)
        makeImageButton(searchField)

        return upperView
    }

    private func makeTextField(_ upperView: UIView) -> UITextField {
        let searchField = customTextField()
        searchField.placeholder = "Search"
        view.addSubview(searchField)
        searchField.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            maker.left.equalTo(upperView).inset(15)
            maker.bottom.equalTo(upperView).inset(10)
            maker.width.equalTo(upperView.snp.width).inset(40)
        }
        return searchField
    }

    private func makeImageButton(_ searchField: UITextField) {
        let cancleButton = UIButton()
        let cancleSVG: SVGKImage = SVGKImage(named: "letter-x")
        let cancleImg: UIImage = cancleSVG.uiImage

        cancleButton.setImage(cancleImg, for: .normal)
        cancleButton.tintColor = UIColor.white
        view.addSubview(cancleButton)
        cancleButton.snp.makeConstraints {(maker) in
            maker.top.equalTo(searchField.snp.top).offset(10)
            maker.left.equalTo(searchField.snp.right).offset(10)
            maker.width.equalTo(30)
            maker.bottom.equalTo(searchField.snp.bottom).inset(10)
        }
    }
    
    private func makeTableView(below: UIView) {
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.separatorInset.left = 0
        view.addSubview(tableView)
        tableView.snp.makeConstraints {(maker) in
            maker.top.equalTo(below.snp.bottom)
            maker.left.right.equalTo(self.view)
            maker.bottom.equalTo(self.view.snp.bottom)
        }
    }

    private func customTextField() -> TextFieldWithPadding {
        let myTextField = TextFieldWithPadding()
        myTextField.layer.cornerRadius = 4
        myTextField.layer.borderWidth = 0.5
        myTextField.layer.borderColor = UIColor.white.cgColor
        myTextField.backgroundColor = UIColor.white
        myTextField.attributedPlaceholder = NSAttributedString(string: "Placeholder Color", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        myTextField.textColor = UIColor.gray

        return myTextField
    }
}

class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 12,
        bottom: 10,
        right: 12
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}

extension SearchRequestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SRTableViewCell.identifier, for: indexPath)
        cell.placeName.text = placeData[indexPath.row].placeName ?? ""
        cell.address.text = String(placeData[indexPath.row].address)
        return cell
    }
}
