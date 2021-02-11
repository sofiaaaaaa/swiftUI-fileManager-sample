//
//  DetailView.swift
//  Memong
//
//  Created by punky on 2020/12/28.
//

import SwiftUI

struct DetailView: View {
    var fileName: String
    var folderName: String
    @State public var fullText: String = ""


    var body: some View {
        VStack {
            Text("\(folderName) / \(fileName) ")
                .font(.custom("HelveticaNeue", size: 16))
            
            TextEditor(text: $fullText)
                .foregroundColor(Color.gray)
                .font(.custom("HelveticaNeue", size: 13))
                .padding()
                .onChange(of: fullText, perform: { value in
                    CustomFileManager.saveFile(of: fileName, in: folderName, contents: fullText)
                })
                .onAppear {
                     self.fullText =  CustomFileManager.self.getFileContents(of: fileName, in: folderName)
                 }
        }
        .toolbar {
            Button(action: addListBullet) {
                Label("Add List bullet", systemImage: "list.bullet")
            }
            .help(Text("Add List bullet"))
            
            Button(action: addListNumber) {
                Label("Add List Number", systemImage: "list.number")
            }
            .help(Text("Add List Number"))
            
            Button(action: getToday) {
                Label("Add Today", systemImage: "calendar")
            }
            .help(Text("Add Today"))
            
        }
        .frame(minWidth: 500,idealWidth: 500, maxHeight: .infinity )

        
        
    }
    
    func addListBullet() {
        self.fullText += "\n· \n· \n· "
    }
    
    func addListNumber() {
        self.fullText += "\n1. \n2. \n3. "
    }
    
    func getToday() {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy.MM.dd HH:mm:ss"

        let formattedDate = format.string(from: date)
        self.fullText += "\n"
        self.fullText += formattedDate
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(fileName: "xxx.txt", folderName: "ccc")
    }
}
