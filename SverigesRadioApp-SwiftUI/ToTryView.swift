////
////  ToTryView.swift
////  SverigesRadioApp-SwiftUI
////
////  Created by Nureddin Elmas on 2022-01-12.
////
//
//import SwiftUI
//
//struct Responsen: Decodable, Identifiable {
//    var users : [User]
//}
//
//struct User: Decodable, Identifiable {
//    let id: String
//    let isActive: Bool
//    let name: String
//    let age: Int
//    let company: String
//    let email: String
//    let address: String
//    let about: String
//    let registered: String
//    let tags: [String]
//
//    let friends : Friends
//
//    struct Friends: Decodable, Identifiable {
//        let id: String
//        let name: String
//    }
//}
//
//
//struct ToTryView: View {
//    @State var users = [User]()
//    var body: some View {
//        List {
//            ForEach(users) { item in
//                VStack(alignment: .leading){
//                    Text(item.name)
//                        .font(.headline)
//                    Text(item.name)
//                }
//            }
//            .onAppear {
//                loadData()
//            }
//        }
//
//    }
//
//    func loadData() {
//        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
//            print("Invalid URL")
//            return
//        }
//        let request = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: request) {data, response, error in
//            if let data = data {
//                if let decodedResponse = try? JSONDecoder().decode(Responsen.self, from: data) {
//                    DispatchQueue.main.async {
//                        self.users = decodedResponse.users
//                    }
//                    return
//                }
//            }
//            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
//
//        }.resume()
//    }
//}
//
//struct ToTryView_Previews: PreviewProvider {
//    static var previews: some View {
//        ToTryView()
//    }
//}
