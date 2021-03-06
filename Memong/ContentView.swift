//
//  ContentView.swift
//  Memong
//
//  Created by punky on 2020/12/26.
//

import SwiftUI

struct ContentView: View {
    @State var folders: [String] = []
    @State private var folderName: String = ""
    @State private var isEditing = false
    @State private var showingAlert = false
    @State private var activeAlert: ActiveAlert = .showingAlertDuplicated
    @State private var selectionListIndex: Int? = 0
    @State private var showingAlertDelete = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(folders.indices , id: \.self) { index in
                    if folders[index] == "X" {
                        Text("Folder List")
                            .frame(width: 0, height: 0)
                    } else {
                        
                        NavigationLink(destination: FileView(folderName: folders[index]), tag: index, selection: $selectionListIndex)
                        {
                            
                            if folders[index] == "" {
                                HStack {
                                    TextField(
                                        "New Folder",
                                        text: $folderName
                                    ) { isEditing in
                                        self.isEditing = isEditing
                                    } onCommit: {
                                        print("commit new Folder to \(self.folderName)")
                                    }
//                                    .frame(width: 100.0, height: 100.0)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .focusable()
                                    .controlSize(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
//                                    .lineLimit(nil)
//                                    .onAppear(perform: {
//                                        self.input = ""
//                                    })

                                    
                                    
                                    Button(action: createFolder) {
                                        Label("", systemImage: "plus")
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                    .alert(isPresented: $showingAlert) {
                                        
                                        switch activeAlert {
                                            case .showingAlertDuplicated:
                                                return  Alert(title: Text("Error"), message: Text("Duplicated folder name."))
                                            case .showingAlerteError:
                                                return  Alert(title: Text("Error"), message: Text("Sorry, We are not working now. Try again."))
                                        }
                                        
                                        
                                    }
                                    .padding(0)
                                    .help(Text("Save"))
                                    
                                    Button(action: {
                                        self.folders.removeLast()
                                    }) {
                                        Label("", systemImage: "clear")
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                    .padding(0)
                                    .help(Text("Cancel"))
                                    
                                }
                                
                            } else {
                                Text("\(folders[index])")
                            }
                        }
                        
                    }
                }
            }
            .toolbar {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
                .help(Text("Add Folder"))
                
                Button(action: clickTrash) {
                    Label("Delete Item", systemImage: "trash")
                }
                .help(Text("Delete Folder"))
                .alert(isPresented: $showingAlertDelete) {
                    return Alert(
                        title: Text("Are you sure?"),
                        message: Text("Do you want to delete?"),
                        primaryButton: .destructive(Text("Yes"), action: deleteItem),
                        secondaryButton: .cancel(Text("No"), action: {})
                      )
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 250,idealWidth: 260,maxWidth: 300, maxHeight: .infinity )
            
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear() {
            self.folders = CustomFileManager.getFolderList() ?? []
        }
        
    }
    
    // Add new folder item
    func addItem() {
        self.folders.append("")
    }
    
    // Click trash button
    func clickTrash() {
        self.showingAlertDelete = true
    }
    
    // Delete folder
    func deleteItem() {
        if self.folders.count == 1 {
            return
        }
        
        if let selectionIndex = self.selectionListIndex, selectionIndex == 0 {
            return
        }
        
        let selectionIndex = self.selectionListIndex ?? 0
        if CustomFileManager.removeFolder(of: folderName) {
            self.folders.remove(at: selectionIndex)
        }
    }
    
    func createFolder() {
        if folderName == "" {
            return
        }
        
        let resultCode = CustomFileManager.createFolder(folderName)
        
        if resultCode == 1 {
            print("has created new Folder \(self.folderName)")
            self.folders.removeLast()
            self.folders.append(self.folderName)
            self.folderName = ""
        } else if resultCode == 2 {
            self.showingAlert = true
            self.activeAlert = ActiveAlert.showingAlertDuplicated
        } else {
            self.showingAlert = true
            self.activeAlert = ActiveAlert.showingAlerteError
            self.folders.removeLast()
            
        }
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
