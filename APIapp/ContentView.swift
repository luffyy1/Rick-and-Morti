//
//  ContentView.swift
//  APIapp
//
//  Created by Mac on 01.10.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var characters : [Character] = []
    var body: some View {
        List(characters){character in
            HStack{
                AsyncImage(url: URL(string: character.image)) { image in
                    switch image {
                    case .empty:
                        ProgressView()
                            .frame(width: 50, height: 50)
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    case .failure(let error):
                        Image(systemName: "profile")
                    @unknown default:
                        EmptyView()
                    }
                }
                Text(character.name)
            }
        }.onAppear(){
            fetchCharacters()
        }
    }
    func fetchCharacters(){
        guard let url = URL(string: "https://rickandmortyapi.com/api/character")
        else{
            return
        }
        URLSession.shared.dataTask(with: url){ data, response, error in
            
            if let error = error{
                print(error)
                return
            }
            
            guard let data = data else{
                return
            }
            
            do{
                let decoded = try JSONDecoder().decode(APIresponse.self, from: data)
                DispatchQueue.main.async{
                    self.characters = decoded.results
                }
            }
            catch{
                print(error.localizedDescription)
            }
            
            
        }
        .resume()
    }

}

#Preview {
    ContentView()
}
