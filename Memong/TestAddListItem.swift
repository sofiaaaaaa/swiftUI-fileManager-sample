//
//  TestAddListItem.swift
//  Memong
//
//  Created by punky on 2020/12/26.
//

import SwiftUI

struct TestAddListItem: View {
    
    @State private var list : [String] = ["Chris"]
    @State private var quarterNumber = 0
    
    var body: some View {
        Group () {
            
            NavigationView{
                Button(action: {
                    self.list.append("whatever")
                }) {
                    Text("tap me")
                }
                List(list, id: \.self) { item in
                    
                    NavigationLink(
                        destination: View2(text: "hallo")
//                            .navigationBarTitle(Text("Categories"), displayMode: .automatic)
                    ) {
                        Text("Categories")
                    }
//                    }.isDetailLink(false)
                    
                }
            }
        }
    }
}

struct View2: View {
    
    var text : String
    
    var body: some View {
        
        Text(text)
    }
}

struct TestAddListItem_Previews: PreviewProvider {
    static var previews: some View {
        TestAddListItem()
    }
}
