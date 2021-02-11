//
//  FileView.swift
//  Memong
//
//  Created by punky on 2020/12/28.
//

import SwiftUI

struct FileView: View {
    var folderName: String
    @State var fileList: [String] = []
    @State private var fileName: String = ""
    @State private var isEditing = false
    @State private var showingAlert = false
    @State private var activeAlert: ActiveAlert = .showingAlertDuplicated
    @State private var selectionListIndex2: Int? = 0
    @State private var showingAlertDelete = false

    
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(fileList.indices , id: \.self) { index in
                    
                    if fileList[index] == "X" {
                        Text("File List")
                            .frame(width: 0, height: 0)
                    } else {
                        NavigationLink(destination: DetailView(fileName: fileList[index], folderName: folderName), tag: index , selection: $selectionListIndex2) {
                            if fileList[index] == "" {
                                HStack {
                                    TextField(
                                        "New File",
                                        text: $fileName
                                    ) { isEditing in
                                        self.isEditing = isEditing
                                    } onCommit: {
                                        print("commit new file to \(self.fileName)")
                                    }
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .focusable()
                                    .padding(.trailing, 10)
                                    .controlSize(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)

                                    
                                    Button(action: createFile) {
                                        Label("", systemImage: "plus")
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                    .alert(isPresented: $showingAlert) {
                                        
                                        switch activeAlert {
                                            case .showingAlertDuplicated:
                                                return  Alert(title: Text("Error"), message: Text("Duplicated file name."))
                                            case .showingAlerteError:
                                                return  Alert(title: Text("Error"), message: Text("Sorry, We are not working now. Try again."))
                                        }
                                    }
                                    .help(Text("Save"))
                                    
                                    Button(action: {
                                        self.fileList.removeLast()
                                    }) {
                                        Label("", systemImage: "clear")
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                    .help(Text("Cancel"))
                                }
                            } else {
                                Text("\(fileList[index])")
                            }
                        }
                    }
                }
                .animation(.default)
            }
            .listStyle(SidebarListStyle())
            .toolbar {
                Button(action: addItem) {
                    Label("Write File", systemImage: "square.and.pencil")
                }
                .help(Text("Write File"))
                
                Button(action: clickTrash) {
                    Label("Delete File", systemImage: "trash")
                }
                .help(Text("Delete File"))
                .alert(isPresented: $showingAlertDelete) {
                    return Alert(
                        title: Text("Are you sure?"),
                        message: Text("Do you want to delete?"),
                        primaryButton: .destructive(Text("Yes"), action: removeItem),
                        secondaryButton: .cancel(Text("No"), action: {})
                      )
                }
            }
            .frame(minWidth: 250,idealWidth: 260,maxWidth: 300, maxHeight: .infinity )

            
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear() {
            self.fileList = CustomFileManager.getFileList(folderName) ?? []
        }
        
    }
    
    // Add a new File
    func addItem() {
        self.fileList.append("")
    }
    
    // Click trash button
    func clickTrash() {
        self.showingAlertDelete = true
    }
    
    // Remove a file
    func removeItem() {
        
        if self.fileList.count == 1 {
            return
        }
        
        if let selectionIndex = self.selectionListIndex2, selectionIndex == 0 {
            return
        }
        
        if let selectionIndex = self.selectionListIndex2, CustomFileManager.removeFile(of: fileList[selectionIndex], in: folderName) {
            print("sucess~")
            let result = fileList.remove(at: selectionIndex)
            print("delete~ \(result) \(fileList)")
        }
    }
    
    // Create file
    func createFile() {
        if fileName == "" {
            return
        }
        
        let resultCode: (Int, String) = CustomFileManager.createNewFile(of: fileName, in: folderName)
        
        if resultCode.0 == 1 {
            print("has created new Folder \(self.fileName)")
            self.fileList.removeLast()
            self.fileList.append(resultCode.1)
            self.fileName = ""
            print("content \(resultCode.1)")
        } else if resultCode.0 == 2 {
            self.showingAlert = true
            self.activeAlert = ActiveAlert.showingAlertDuplicated
            
        } else {
            self.showingAlert = true
            self.activeAlert = ActiveAlert.showingAlerteError
            self.fileList.removeLast()
            
        }
        
    }
}

struct FileView_Previews: PreviewProvider {
    static var previews: some View {
        FileView(folderName: "ccc")
    }
}
