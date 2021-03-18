//
//  TopTextFieldDelegate.swift
//  test
//
//  Created by AnnieWilson on 3/18/21.
//

import Foundation
import UIKit

// MARK: TopTextFieldDelegate: NSOject, UITextFieldDelegate

class TopTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//        textField.placeholder = "Top"
//        textField.textAlignment = .center
        
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    

}


