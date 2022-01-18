//
//  ProgramsView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-15.
//

import SwiftUI

struct ProgramsView: View {
    @State var programs:Programs
    var body: some View {
        UrlWebView(urlToDisplay: programs.programurl ?? "")
            .navigationTitle(programs.name ?? "")
    }
}

struct ProgramsView_Previews: PreviewProvider {
    static var previews: some View {
//        ProgramsView()
        Text("Programs View")
    }
}



