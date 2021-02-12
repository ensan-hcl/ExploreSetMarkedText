//
//  KeyboardView.swift
//  MyKeyboard
//
//  Created by β α on 2021/02/11.
//

import Foundation
import SwiftUI

struct KeyboardView: View {
    let proxy: UITextDocumentProxy
    @State private var left: String? = nil
    @State private var center: String? = nil
    @State private var right: String? = nil

    private func formDocumentContextInput(_ value: String?) -> String {
        if let value = value{
            if value == "\n"{
                return "\\n"
            }
            if value == ""{
                return "empty"
            }
            return value
        }else{
            return "nil"
        }
    }

    private func setDocumentContextInput(){
        self.left = formDocumentContextInput(proxy.documentContextBeforeInput)
        self.center = formDocumentContextInput(proxy.selectedText)
        self.right = formDocumentContextInput(proxy.documentContextAfterInput)
    }

    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Button{
                        let string = "markedtext1"
                        let range = NSRange(location: string.utf8.count, length: 0)
                        self.proxy.setMarkedText(string, selectedRange: range)
                        self.setDocumentContextInput()
                    } label: {
                        Text("marked text 1")
                            .padding()
                    }

                    Button{
                        let string = "somenewtext"
                        let range = NSRange(location: string.utf8.count-5, length: 0)
                        self.proxy.setMarkedText(string, selectedRange: range)
                        self.setDocumentContextInput()
                    } label: {
                        Text("marked text 2")
                            .padding()
                    }
                }
                HStack{
                    Button{
                        self.proxy.unmarkText()
                        self.setDocumentContextInput()
                    } label: {
                        Text("unmark")
                            .padding()
                    }
                    Button{
                        self.proxy.deleteBackward()
                        self.setDocumentContextInput()
                    } label: {
                        Image(systemName: "delete.left")
                            .padding()
                    }
                }

                HStack{

                    Button{
                        let string = "input"
                        self.proxy.insertText(string)
                        self.setDocumentContextInput()
                    } label: {
                        Text("input text").padding()
                    }

                    Button{
                        let string = "\n"
                        self.proxy.insertText(string)
                        self.setDocumentContextInput()
                    } label: {
                        Image(systemName: "return").padding()
                    }

                }

                HStack{
                    Button{
                        self.proxy.adjustTextPosition(byCharacterOffset: -1)
                        self.setDocumentContextInput()
                    } label: {
                        Image(systemName: "arrow.left")
                            .padding()
                    }
                    Button{
                        self.proxy.adjustTextPosition(byCharacterOffset: 1)
                        self.setDocumentContextInput()
                    } label: {
                        Image(systemName: "arrow.right")
                            .padding()
                    }
                }

                Button{
                    self.setDocumentContextInput()
                } label: {
                    Text("print")
                }
                VStack{
                    Text("left: \(left ?? "nil")")
                    Text("center: \(center ?? "nil")")
                    Text("right: \(right ?? "nil")")
                }

            }
        }
        .frame(height: UIScreen.main.bounds.height/2)
    }
}
