//
//  TestAddList.swift
//  Memong
//
//  Created by punky on 2020/12/26.
//

import SwiftUI

struct TestAddList: View {
    @State var inputString = ["1", "2", "3", "4", "5"]
    
    init() {
    }
    
    var body: some View {
        Text("List Item with selectable Buttons").padding()
        
        List {
            
            ForEach(0..<5) { idx in
                
                HStack {
                    
                    Text("Title")
                    
                    TextField("Enter new value",text: $inputString[idx])
                    
                    Spacer()
                    
                    Button(action: {
                        
                        print("Button did select 1 at idx \(idx)")
                    }) {
                        
                        Text("Selectable 1")
                    }.buttonStyle(PlainButtonStyle())
                    .foregroundColor(Color.accentColor)
                    
                    Button(action: {
                        
                        print("Button did select 2 at idx \(idx)")
                    }) {
                        
                        Text("Selectable 2")
                    }.buttonStyle(PlainButtonStyle())
                    .foregroundColor(Color.accentColor)
                    
                }
            }
        }
    }
}

struct TestAddList_Previews: PreviewProvider {
    static var previews: some View {
        TestAddList()
    }
}
