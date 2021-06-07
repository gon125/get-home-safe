//
//  RouteRequestViewController.swift
//  GetHomeSafe
//
//  Created by khs on 2021/06/02.
//

import RIBs
import RxSwift
import UIKit
import SVGKit

protocol RouteRequestPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RouteRequestViewController: UIViewController, RouteRequestPresentable, RouteRequestViewControllable {

    weak var listener: RouteRequestPresentableListener?
    
    private var placeData: [PlaceData] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RRTableViewCell.self, forCellReuseIdentifier: RRTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addPlaceDataSet(placeName: "경북대학교 대구캠퍼스", address: "대구 북구 대학로 80")
        addPlaceDataSet(placeName: "경북대학교 상주캠퍼스", address: "경북 상주시 경상대로 2559")
        addPlaceDataSet(placeName: "경북대학교병원", address: "대구 중구 동덕로 130")
        
        let upperView = makeUpperView()
        makeTableView(below: upperView)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.backgroundColor = UIColor.white
    }

    private func addPlaceDataSet(placeName: String, address: String) {
        placeData.append(PlaceData.init(placeName: placeName, address: address))
    }
    
    private func makeUpperView() -> UIView {
        let upperView = UIView()
        upperView.backgroundColor = UIColor(displayP3Red: 123/255, green: 162/255, blue: 239/255, alpha: 1)
        view.addSubview(upperView)
        upperView.snp.makeConstraints {(maker)in
            maker.top.equalTo(self.view)
            maker.left.right.equalTo(self.view.safeAreaLayoutGuide)
            maker.height.equalTo(160)
        }
        
        var sourceField: UITextField
        var destField: UITextField
        
        (sourceField, destField) = makeTextField(upperView)
        makeImageButton(sourceField, destField)
        
        return upperView
    }
    
    private func makeTextField(_ upperView: UIView) -> (UITextField, UITextField) {
        let sourceField = customTextField()
        sourceField.placeholder = "출발지 : 현재 위치"
        view.addSubview(sourceField)
        sourceField.snp.makeConstraints {(maker) in
            maker.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            maker.left.equalTo(upperView).offset(15)
            maker.width.equalTo(upperView.snp.width).inset(40)
            maker.height.equalTo(40)
        }
        
        let destField = customTextField()
        destField.placeholder = "도착지"
        view.addSubview(destField)
        destField.snp.makeConstraints { (maker) in
            maker.top.equalTo(sourceField.snp.bottom).offset(10)
            maker.left.equalTo(upperView).offset(15)
            maker.width.equalTo(upperView.snp.width).inset(40)
            maker.height.equalTo(40)
        }
        
        return (sourceField, destField)
    }
    
    private func makeImageButton(_ sourceField: UITextField, _ destField: UITextField) {
        let cancleButton = UIButton()
        let cancleSVG: SVGKImage = SVGKImage(named: "letter-x")
        let cancleImg: UIImage = cancleSVG.uiImage
        
        cancleButton.setImage(cancleImg, for: .normal)
        view.addSubview(cancleButton)
        cancleButton.snp.makeConstraints {(maker)in
            maker.top.equalTo(sourceField.snp.top).offset(5)
            maker.left.equalTo(sourceField.snp.right).offset(10)
            maker.width.equalTo(30)
            maker.bottom.equalTo(sourceField.snp.bottom).inset(5)
        }
    
        let naviButton = UIButton()
        let naviSVG: SVGKImage = SVGKImage(named: "magnifying-glass")
        let naviImg: UIImage = naviSVG.uiImage

        naviButton.setImage(naviImg, for: .normal)
        view.addSubview(naviButton)
        naviButton.snp.makeConstraints {(maker)in
            maker.top.equalTo(destField.snp.top).offset(5)
            maker.left.equalTo(destField.snp.right).offset(10)
            maker.width.equalTo(30)
            maker.bottom.equalTo(destField.snp.bottom).inset(5)
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
        myTextField.attributedPlaceholder = NSAttributedString(string: "Placeholder Color", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)/*, NSAttributedString.Key.foregroundColor : UIColor.darkGray*/])
        myTextField.textColor = UIColor.darkGray

        return myTextField
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placeData.count
    }
        
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(placeData[indexPath.row])!")
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> UITableViewCell {
//        cell.seletionStyle = .none
        self.performSegue(withIdentifier: "yourIdentifier", sender: self)
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        let (testName) = placeData[indexPath.row]
        cell.textLabel?.text = testName.placeName
        return cell
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

extension RouteRequestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RRTableViewCell.identifier, for: indexPath)
        cell.placeName.text = placeData[indexPath.row].placeName ?? ""
        cell.address.text = String(placeData[indexPath.row].address)
        return cell
    }
}
