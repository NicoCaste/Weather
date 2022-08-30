//
//  SearchView.swift
//  Weather
//
//  Created by nicolas castello on 29/08/2022.
//

import UIKit

protocol SearchMovieViewProtocol {
    func closeSearchView()
}

class SearchMovieView: UIView {
    lazy private var textField: UITextField = UITextField()
    lazy private var clearInputButton: UIButton = UIButton()
    lazy private var closeButton: UIButton = UIButton()
    lazy private var magnifyInGlass: UIImageView = UIImageView()
    private var viewModel: SearchViewModel?
    private var keyboardActive: Bool = false
    private var animatedCharacter: [Bool]?
    private var firstLoad = true
    private var errorLoad: Bool = false
    var delegate: SearchMovieViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setSearchView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSearchView() {
        viewModel = SearchViewModel()
        setCloseButton()
        setCharactersTextField()
        setClearInputButton()
    }
    
    func setTextField(colors: WeatherColor?) {
        guard let colors = colors else { return }
        DispatchQueue.main.async { [weak self] in
            self?.closeButton.setTitleColor(colors.headerColor, for: .normal)
            self?.textField.textColor = colors.headerColor
            self?.textField.backgroundColor = UIColor(cgColor: colors.topColor)
            
        }
    }
    
    private func setCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(closeButton)
        closeButton.setTitle("Cancel", for: .normal)
        closeButton.addTarget(self, action: #selector(closeSearchView), for: .touchUpInside)
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.heightAnchor.constraint(equalToConstant: 28),
            closeButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    //MARK: - SetNewArtistsTextField
    private func setCharactersTextField() {
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        textField.font = UIFont(name: "Noto Sans Myanmar Bold", size: 14)
        let text = " search".capitalized
        let str = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor :UIColor.gray])
        textField.attributedPlaceholder = str
        textField.textColor = .white
        textField.backgroundColor = .white
        setSearchCharacterIcon()
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
        
        textField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        textField.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant:  -10).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.layer.cornerRadius = 5
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField ) {
        guard let textFieldtext = textField.text else {return}
        viewModel?.findCityFor(name: textFieldtext)
    }
    
    private func setClearInputButton() {
        clearInputButton.translatesAutoresizingMaskIntoConstraints = false
        textField.addSubview(clearInputButton)
        clearInputButton.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        clearInputButton.tintColor = .lightGray
        clearInputButton.addTarget(self, action: #selector(clearInput), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            clearInputButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            clearInputButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -10),
            clearInputButton.heightAnchor.constraint(equalToConstant: 20),
            clearInputButton.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc private func clearInput() {
        textField.attributedText = nil
        NotificationCenter.default.post(name: NSNotification.Name.clearPrediction, object: nil, userInfo: nil)
    }

    private func setSearchCharacterIcon() {
        magnifyInGlass.image = UIImage(systemName: "magnifyingglass")
        textField.leftView = magnifyInGlass
        textField.leftViewMode = .always
        magnifyInGlass.tintColor = .gray
        magnifyInGlass.heightAnchor.constraint(equalToConstant: 25).isActive = true
        magnifyInGlass.widthAnchor.constraint(equalToConstant: 25).isActive = true

    }
    
    @objc private func closeSearchView() {
        NotificationCenter.default.post(name: NSNotification.Name.clearPrediction, object: nil, userInfo: nil)
        delegate?.closeSearchView()
    }
}
