//
//  ContentView.swift
//  Memorize
//
//  Created by 林士平 on 2023/3/9.
//

import SwiftUI

// functional programming: struct
// -> UI code
// object-oriented programming: class
// -> hook up our model (logic) to UI

// : View -> behave like a view (rectangular area on screen)
struct ContentView: View {
    // var -> variable
    // body -> name of variables
    // : some View -> type of variables
    // (something that behaving like a view
    // -> think of the lego that be the content of ContentView
    // -> building lego out of lego)
    // normally type will be var i: Int / var s: String
    
    // below is a function:
    // functional programming language functions are everywhere
    
    // var body is not stored in memory!
    // when someone call body -> will execute below functions
    // body will be calculed by executing below functions
    // Text() -> behaave like a view (Think of another lego)
    
    // the type is not ZStack
    // -> the type of ZStack is determined by Views inside
    var body: some View {
        // argument with label!
        // the argument is not clear about what it is
        // if you only place 25.0 will get error!
        
        // Content combiner
        // content: function which can bag all Views (bag of legos)
        // if function is the last argument => can put it out
        // looks nicer
//        ZStack(alignment: .center, content: {
//        ZStack(alignment: .center) {
//        ZStack() {
        ZStack {
            RoundedRectangle(cornerRadius: 20.0)
                        .stroke(lineWidth: 3)
//                        .padding(.horizontal)
//                        .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
            Text("Hello there, CS193p!")
                .foregroundColor(Color.orange)
        }
        .padding(.horizontal)
        .foregroundColor(.red)
        // default color:
        // the combiner itself don't draw anything
        // the foregroundColor will be passed to all views inside
        
         // .fill() vs. .stroke() -> fill is a default
         // all things in the shape can use .stroke()
//        return RoundedRectangle(cornerRadius: 20.0)
//            .stroke(lineWidth: 3)
//            .padding(.horizontal)
//            .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
        
        // return Text("Hello there, CS193p!").foregroundColor(Color.orange).padding()
            
        // <struct>.function(argument)
        // .padding() -> default padding that may suit different devices
        // return type of .padding() vs. no will be different
    }
}

// There may be somewhere that have the declaration below:
//struct Text: View {
//    var body: some View {
//
//    }
//}






















//code for glueing code with previewer
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
