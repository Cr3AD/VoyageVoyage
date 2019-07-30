//
//  TraductionViews.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 25/07/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit

extension MakeATradViewController {
    
    

    
    func addTraductionView(langIn: String, langOut: String, textInput: String, textOutput: String) {
        
        // Parameters
        let traductionViewSize = traductionScrollView.bounds
        let numberOfView = Double(traductionScrollView.subviews.count - 2)
        let traductionViewWidth = Double(traductionViewSize.width)
        let position = numberOfView * 110
        
        print("position is \(position)")
        

        var arrayOfInfoViews = [UIView]()
        var arrayOfTranslatedText = [UIView]()

        //////////////////
        // main Stack view
        let mainStackView = UIStackView(frame: CGRect(x: 0, y: position , width: traductionViewWidth, height: 110))
        mainStackView.axis = .horizontal
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillProportionally
        mainStackView.spacing = 10
//        mainStackView.layer.cornerRadius = 20 // radius
        
        // INFO traction label
        let infoStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 15, height: traductionViewWidth))
        infoStackView.axis = .vertical
        infoStackView.distribution = .fillEqually
        infoStackView.layer.cornerRadius = 20 // radius?
        
        // TEXT + translated label
        let textStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: traductionViewWidth, height: traductionViewWidth))
        textStackView.axis = .vertical
        textStackView.distribution = .fillEqually
        ///////////////////////////////
        
        ////// labels //////
        
        //langInLabel
        let langInLabel = UILabel()
        langInLabel.text = langIn
        arrayOfInfoViews.append(langInLabel)
        langInLabel.font = UIFont.systemFont(ofSize : 14)
        
        

        // langOutLabel
        let langOutLabel = UILabel()
        langOutLabel.text = langOut
        arrayOfInfoViews.append(langOutLabel)
        langOutLabel.font = UIFont.systemFont(ofSize : 14)
        langOutLabel.textAlignment = .center
        langOutLabel.backgroundColor = .black
        langOutLabel.font.withSize(15)
        langOutLabel.textColor = .white
        langOutLabel.layer.cornerRadius = 10 // radius?
        langOutLabel.preferredMaxLayoutWidth = 20
        
        ////// text labels //////
        
        // text input
        let textInputLabel = UILabel()
        textInputLabel.text = textInput
        arrayOfTranslatedText.append(textInputLabel)
        textInputLabel.font = UIFont.systemFont(ofSize : 14)
        
        let textOutputLabel = UILabel()
        textOutputLabel.text = textOutput
        arrayOfTranslatedText.append(textOutputLabel)
        textOutputLabel.font = UIFont.systemFont(ofSize : 14)
        
        ////// others //////
        
//        let lineView = UIView(frame: CGRect(x: 0, y: position, width: traductionViewWidth, height: 1))
//        lineView.backgroundColor = .black
//        let lineViewHeightConnstraint = NSLayoutConstraint(item: lineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
//        let lineViewWidthConnstraint = NSLayoutConstraint(item: lineView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
//        lineView.addConstraint(lineViewHeightConnstraint)
//        lineView.addConstraint(lineViewWidthConnstraint)

        
//        print("view added")
//
        for views in arrayOfInfoViews {
            print(views)
            infoStackView.addArrangedSubview(views)
        }
        for views in arrayOfTranslatedText {
            print(views)
            textStackView.addArrangedSubview(views)
        }

        
        mainStackView.addArrangedSubview(infoStackView)
        mainStackView.addArrangedSubview(textStackView)
//        mainStackView.addArrangedSubview(lineView)
        
        
        traductionScrollView.addSubview(mainStackView)
        traductionScrollView.alwaysBounceHorizontal = false
    }
    
}
