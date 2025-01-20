import SwiftUI

struct GamePropsView: View {
    let game: Game
    let propType: PropType
    @StateObject private var viewModel = GamesViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            GameHeader(homeTeam: game.homeTeam, awayTeam: game.awayTeam)
            
            let props = viewModel.getProps(for: game, type: propType)
            if props.isEmpty {
                Text("No props available")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ForEach(props) { prop in
                    PlayerPropRow(
                        playerName: prop.playerName,
                        line: prop.line,
                        overPrice: prop.overPrice,
                        underPrice: prop.underPrice,
                        bookmaker: prop.bookmaker
                    )
                }
            }
        }
    }
} 