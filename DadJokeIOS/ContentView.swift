//
//  ContentView.swift
//  DadJokeIOS
//
//  Created by Andreas Liebich on 2020-12-08.
//

import SwiftUI

struct ContentView: View {
    
    @State private var theJoke = ""
    @State private var favouriteJokes: [FavouriteJoke] = []
    @State private var addedtoFavourite = false
    
    var body: some View {
        
        NavigationView() {
            VStack(alignment: .center) {
                Image("dadjoke.jpg")
                    .resizable()
                    .scaledToFit()
                
                Button(action: {
                    fetchJoke()
                }, label: {
                    Text("Generate Random Dad Joke!")
                })
                
                Button(action: {
                    favouriteJokes.append(FavouriteJoke(joke: theJoke))
                    addedtoFavourite = true
                    
                }, label: {
                    Text("Mark as favourite")
                })
                .disabled(addedtoFavourite)
                
                Text(theJoke)
                    .padding(.horizontal)
                   
                List(favouriteJokes) { currentJoke in
                    Text(currentJoke.joke)
                }
                
                
            }
            
            .navigationTitle("Dad Joke")
            
            .onAppear() {
                fetchJoke()
            }
        }
    }
    
    
    func fetchJoke() {
        
        
        let url = URL(string: "https://icanhazdadjoke.com")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            
            guard let jokeData = data else {
                
                
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                
                return
            }
            
            
            print(String(data: jokeData, encoding: .utf8)!)
            
            
            if let decodedJokeData = try? JSONDecoder().decode(Joke.self, from: jokeData) {
                
                print("Joke data decoded from JSON successfully")
                print("The Joke is: \(decodedJokeData.joke)")
                
                // Update the UI on the main thread
                DispatchQueue.main.async {
                    theJoke = decodedJokeData.joke
                    addedtoFavourite = false
                }
                
                
            } else {
                
                print("Invalid response from server.")
            }
            
        }.resume()
        
    }
    
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

