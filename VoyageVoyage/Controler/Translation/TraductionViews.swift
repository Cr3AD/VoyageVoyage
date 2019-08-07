//
//  TraductionViews.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 25/07/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit

extension MakeATradViewController {
    
    func makeLangChoosenLabel(with lang: String) -> UILabel {
        
        let langChoosenLabel = UILabel()
        langChoosenLabel.text = lang
        langChoosenLabel.backgroundColor = .black
        langChoosenLabel.textColor = .white
        langChoosenLabel.alpha = 1
        langChoosenLabel.textAlignment = .center
        
        return langChoosenLabel
    }
    
    func makeTextTraductionLabel(with text: String) -> UILabel {
        
        let textTradLabel = UILabel()
        textTradLabel.text = text
        textTradLabel.backgroundColor = .black
        textTradLabel.textColor = .white
        textTradLabel.alpha = 0.75
        textTradLabel.numberOfLines = 0
        
        return textTradLabel
    }
    
    func makeInternalStackView(width: Int) -> UIStackView {
        
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: width, height: .max))
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.distribution = .fillProportionally
        
        return stackView
    }
    
    func makeMainStackView(x: Int, y: Int, width: Int, height: Int) -> UIStackView {
        
        let mainStackView = UIStackView(frame: CGRect(x: x, y: y, width: width, height: height))
        mainStackView.axis = .horizontal
        mainStackView.alignment = .fill
        mainStackView.spacing = 2
        mainStackView.distribution = .fill
        
        return mainStackView
    }
    
    func makeMainView(x: Int, y: Int, width: Int, height: Int) -> UIView {
        
        let mainView = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = 15
        
        return mainView
    }

    func makeTraductionView(langIn: String, langOut: String, textInput: String, textOutput: String) {
        
        // Parameters
        let traductionViewSize = traductionScrollView?.bounds
        let traductionViewWidth = (traductionViewSize?.width ?? 0)
        
        let numberOfView = traductionScrollView?.subviews.count ?? 0
        let position = (numberOfView - 2) * 110 + 10
        
        let infoView = makeInternalStackView(width: (traductionViewWidth * 0.2).intValue)
        infoView.addArrangedSubview(makeLangChoosenLabel(with: langIn))
        infoView.addArrangedSubview(makeLangChoosenLabel(with: langOut))
        
        let textView = makeInternalStackView(width: (traductionViewWidth * 0.8).intValue)
        textView.addArrangedSubview(makeTextTraductionLabel(with: textInput))
        textView.addArrangedSubview(makeTextTraductionLabel(with: textOutput))
        let mainStackView = makeMainStackView(x: 0, y: 0, width: traductionViewWidth.intValue, height: 105)
        mainStackView.addArrangedSubview(infoView)
        mainStackView.addArrangedSubview(textView)

        let mainView = makeMainView(x: 0, y: position, width: traductionViewWidth.intValue, height: 110)
        mainView.addSubview(mainStackView)
        
        traductionScrollView?.addSubview(mainView)
        traductionScrollView?.alwaysBounceHorizontal = false
    }
    
}



