import SwiftUI

struct GamesView: View {
    @StateObject private var viewModel = GamesViewModel()
    @State private var selectedLeague = "NBA"
    var onGameSelected: ((String) -> Void)?
    
    let leagues = ["NBA", "NFL", "NHL", "NCAAF", "NCAAB", "MLB"]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("Games")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                
                // League Selector
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(leagues, id: \.self) { league in
                            LeagueButton(
                                title: league,
                                isSelected: selectedLeague == league
                            ) {
                                if selectedLeague != league {
                                    selectedLeague = league
                                    Task {
                                        await viewModel.fetchGames(for: league)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                    Spacer()
                } else if let error = viewModel.error {
                    Spacer()
                    VStack {
                        Text("Error loading games")
                            .foregroundColor(.red)
                        Text(error.localizedDescription)
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    Spacer()
                } else if viewModel.games.isEmpty {
                    Spacer()
                    Text("No games available")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.games) { game in
                                GameCard(game: game, onGameSelected: onGameSelected)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchGames(for: selectedLeague)
            }
        }
    }
}

struct DateButton: View {
    let date: Date
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(dayOfWeek)
                    .font(.system(size: 12, weight: .medium))
                Text(dayAndMonth)
                    .font(.system(size: 14, weight: .semibold))
            }
            .foregroundColor(isSelected ? .accentColor : .gray)
            .frame(width: 70)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color.accentColor.opacity(0.2) : Color.clear)
            )
        }
    }
    
    private var dayOfWeek: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    private var dayAndMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        return formatter.string(from: date)
    }
}

struct GameCard: View {
    let game: Game
    let onGameSelected: ((String) -> Void)?
    @State private var selectedBookmaker: Bookmaker? = nil
    
    func getTeamLogoName(_ teamName: String) -> String {
        switch teamName {
        // NBA Teams
        case "Los Angeles Lakers": return "lakers"
        case "Boston Celtics": return "celtics"
        case "Golden State Warriors": return "warriors"
        case "Brooklyn Nets": return "nets"
        case "Los Angeles Clippers": return "clippers"
        case "Miami Heat": return "heat"
        case "Milwaukee Bucks": return "bucks"
        case "Phoenix Suns": return "suns"
        case "Dallas Mavericks": return "mavericks"
        case "Denver Nuggets": return "nuggets"
        case "Philadelphia 76ers": return "76ers"
        case "Atlanta Hawks": return "hawks"
        case "Chicago Bulls": return "bulls"
        case "Houston Rockets": return "rockets"
        case "Indiana Pacers": return "pacers"
        case "Memphis Grizzlies": return "grizzlies"
        case "Minnesota Timberwolves": return "timberwolves"
        case "New Orleans Pelicans": return "pelicans"
        case "New York Knicks": return "knicks"
        case "Oklahoma City Thunder": return "thunder"
        case "Orlando Magic": return "magic"
        case "Portland Trail Blazers": return "trailblazers"
        case "Sacramento Kings": return "kings"
        case "San Antonio Spurs": return "spurs"
        case "Toronto Raptors": return "raptors"
        case "Utah Jazz": return "jazz"
        case "Washington Wizards": return "wizards"
        case "Detroit Pistons": return "pistons"
        case "Cleveland Cavaliers": return "cavaliers"
        case "Charlotte Hornets": return "hornets"
            
        // NFL Teams
        case "Arizona Cardinals": return "cardinals"
        case "Atlanta Falcons": return "falcons"
        case "Baltimore Ravens": return "ravens"
        case "Buffalo Bills": return "bills"
        case "Carolina Panthers": return "panthers"
        case "Chicago Bears": return "bears"
        case "Cincinnati Bengals": return "bengals"
        case "Cleveland Browns": return "browns"
        case "Dallas Cowboys": return "cowboys"
        case "Denver Broncos": return "broncos"
        case "Detroit Lions": return "lions"
        case "Green Bay Packers": return "packers"
        case "Houston Texans": return "texans"
        case "Indianapolis Colts": return "colts"
        case "Jacksonville Jaguars": return "jaguars"
        case "Kansas City Chiefs": return "chiefs"
        case "Las Vegas Raiders": return "raiders"
        case "Los Angeles Chargers": return "chargers"
        case "Los Angeles Rams": return "rams"
        case "Miami Dolphins": return "dolphins"
        case "Minnesota Vikings": return "vikings"
        case "New England Patriots": return "patriots"
        case "New Orleans Saints": return "saints"
        case "New York Giants": return "giants"
        case "New York Jets": return "jets"
        case "Philadelphia Eagles": return "eagles"
        case "Pittsburgh Steelers": return "steelers"
        case "San Francisco 49ers": return "49ers"
        case "Seattle Seahawks": return "seahawks"
        case "Tampa Bay Buccaneers": return "buccaneers"
        case "Tennessee Titans": return "titans"
        case "Washington Commanders": return "washington-commanders-logo-png_seeklogo-430443"
            
        // NCAAF and NCAAB Teams
        case "Air Force Falcons": return "airForce"
        case "BYU Cougars": return "byu"
        case "Brown Bears": return "brown"
        case "Bucknell Bison": return "bucknell"
        case "Cal Poly Mustangs": return "calPoly"
        case "Campbell Fighting Camels": return "campbell"
        case "Charleston Southern Buccaneers": return "charlestonSouthern"
        case "Dartmouth Big Green": return "dartmouth"
        case "Delaware State Hornets": return "delawareState"
        case "East Tennessee State Buccaneers": return "eastTennessee"
        case "Florida Atlantic Owls": return "floridaAtlantic"
        case "Fordham Rams": return "fordham"
        case "Fresno State Bulldogs": return "fresnoState"
        case "Gardner-Webb Runnin' Bulldogs": return "gardnerWebb"
        case "Georgia Bulldogs": return "georgia"
        case "Georgia Southern Eagles": return "georgiaSouthern"
        case "Harvard Crimson": return "harvard"
        case "Hawaii Rainbow Warriors": return "hawaii"
        case "Holy Cross Crusaders": return "holyCross"
        case "Illinois Fighting Illini": return "illinois"
        case "Illinois State Redbirds": return "illinoisState"
        case "Incarnate Word Cardinals": return "incarnateWord"
        case "Iowa State Cyclones": return "iowaState"
        case "James Madison Dukes": return "jamesMadison"
        case "Kansas Jayhawks": return "kansas"
        case "Kansas State Wildcats": return "kansasState"
        case "Kent State Golden Flashes": return "kentState"
        case "Louisiana Monroe Warhawks": return "louisianaMonroe"
        case "Louisiana Ragin' Cajuns": return "louisianaLafayette"
        case "Massachusetts Minutemen": return "massachusetts"
        case "Memphis Tigers": return "memphis"
        case "Mississippi State Bulldogs": return "mississippiState"
        case "Nebraska Cornhuskers": return "nebraska"
        case "New Mexico Lobos": return "newMexico"
        case "New Mexico State Aggies": return "newMexicoState"
        case "North Carolina Tar Heels": return "northCarolina"
        case "North Dakota Fighting Hawks": return "northDakota"
        case "Northern Illinois Huskies": return "northernIllinois"
        case "Pittsburgh Panthers": return "pittsburgh"
        case "Rice Owls": return "rice"
        case "Sacred Heart Pioneers": return "sacredHeart"
        case "Samford Bulldogs": return "samford"
        case "San Jose State Spartans": return "sanJoseState"
        case "South Dakota Coyotes": return "southDakota"
        case "South Dakota State Jackrabbits": return "southDakotaState"
        case "Southern Illinois Salukis": return "southernIllinois"
        case "Stanford Cardinal": return "stanford"
        case "Stephen F. Austin Lumberjacks": return "stephenFAustin"
        case "Stetson Hatters": return "stetson"
        case "Texas A&M Aggies": return "texasAM"
        case "Texas Tech Red Raiders": return "texasTech"
        case "Towson Tigers": return "towson"
        case "Utah State Aggies": return "utahState"
        case "VMI Keydets": return "vmi"
        case "Washington Huskies": return "washington"
        case "Western Carolina Catamounts": return "westernCarolina"
        case "Western Kentucky Hilltoppers": return "westernKentucky"
            
        // MLB Teams
        case "Arizona Diamondbacks": return "diamondbacks"
        case "Atlanta Braves": return "braves"
        case "Baltimore Orioles": return "orioles"
        case "Boston Red Sox": return "redSox"
        case "Chicago Cubs": return "cubs"
        case "Chicago White Sox": return "whiteSox"
        case "Cincinnati Reds": return "reds"
        case "Cleveland Guardians": return "guardians"
        case "Colorado Rockies": return "rockies"
        case "Detroit Tigers": return "tigers"
        case "Houston Astros": return "astros"
        case "Kansas City Royals": return "royals"
        case "Los Angeles Angels": return "angels"
        case "Los Angeles Dodgers": return "dodgers"
        case "Miami Marlins": return "marlins"
        case "Milwaukee Brewers": return "brewers"
        case "Minnesota Twins": return "twins"
        case "New York Mets": return "mets"
        case "New York Yankees": return "yankees"
        case "Oakland Athletics": return "athletics"
        case "Philadelphia Phillies": return "phillies"
        case "Pittsburgh Pirates": return "pirates"
        case "San Diego Padres": return "padres"
        case "San Francisco Giants": return "giants"
        case "Seattle Mariners": return "mariners"
        case "St. Louis Cardinals": return "cardinals"
        case "Tampa Bay Rays": return "rays"
        case "Texas Rangers": return "rangers"
        case "Toronto Blue Jays": return "blueJays"
        case "Washington Nationals": return "nationals"
            
        // NHL Teams
        case "Anaheim Ducks": return "anaheim-ducks-logo"
        case "Arizona Coyotes": return "arizona-coyotes-logo"
        case "Boston Bruins": return "boston-bruins-logo"
        case "Buffalo Sabres": return "buffalo-sabres-logo"
        case "Calgary Flames": return "calgary-flames-logo"
        case "Carolina Hurricanes": return "carolina-hurricanes-logo"
        case "Chicago Blackhawks": return "chicago-blackhawks-logo"
        case "Colorado Avalanche": return "colorado-avalanche-logo"
        case "Columbus Blue Jackets": return "columbus-blue-jackets-logo"
        case "Dallas Stars": return "dallas-stars-logo"
        case "Detroit Red Wings": return "detroit-red-wings-logo"
        case "Edmonton Oilers": return "edmonton-oilers-logo"
        case "Florida Panthers": return "florida-panthers-logo"
        case "Los Angeles Kings": return "los-angeles-kings-logo"
        case "Minnesota Wild": return "minnesota-wild-logo"
        case "Montreal Canadiens": return "montreal-canadiens-logo"
        case "Nashville Predators": return "nashville-predators-logo"
        case "New Jersey Devils": return "new-jersey-devils-logo"
        case "New York Islanders": return "new-york-islanders-logo"
        case "New York Rangers": return "new-york-rangers-logo"
        case "Ottawa Senators": return "ottawa-senators-logo"
        case "Philadelphia Flyers": return "philadelphia-flyers-logo"
        case "Pittsburgh Penguins": return "pittsburgh-penguins-logo"
        case "San Jose Sharks": return "san-jose-sharks-logo"
        case "Seattle Kraken": return "seattle-kraken-logo"
        case "St. Louis Blues": return "st-louis-blues-logo"
        case "Tampa Bay Lightning": return "tampa-bay-lightning-logo"
        case "Toronto Maple Leafs": return "toronto-maple-leafs-logo"
        case "Vancouver Canucks": return "vancouver-canucks-logo"
        case "Vegas Golden Knights": return "vegas-golden-knights-logo"
        case "Washington Capitals": return "washington-capitals-logo"
        case "Winnipeg Jets": return "winnipeg-jets-logo"
            
        default: return ""
        }
    }
    
    func getSportsBookLogoName(_ key: String) -> String {
        switch key {
        case "fanduel": return "fanduel"
        case "draftkings": return "draftkings"
        case "betmgm": return "betmgm"
        case "caesars": return "caesars"
        default: return ""
        }
    }
    
    func formatTeamName(_ fullName: String) -> String {
        let components = fullName.components(separatedBy: " ")
        return components.last ?? fullName
    }
    
    var body: some View {
        VStack(spacing: 16) {
            if let onGameSelected = onGameSelected {
                // View Props Button
                HStack {
                    Spacer()
                    Button(action: {
                        onGameSelected(game.id)
                    }) {
                        Text("View Props")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.accentColor)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(white: 0.15))
                            .cornerRadius(6)
                    }
                }
            }
            
            // Teams
            HStack(spacing: 0) {
                // Away Team
                VStack(spacing: 8) {
                    Image(getTeamLogoName(game.awayTeam))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    Text(formatTeamName(game.awayTeam))
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity)
                
                VStack(spacing: 8) {
                    // Game Time and Date
                    VStack(alignment: .center, spacing: 4) {
                        Text(game.formattedDate)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                        Text(game.formattedTime)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    
                    Text("@")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.gray)
                }
                .frame(width: 100)
                
                // Home Team
                VStack(spacing: 8) {
                    Image(getTeamLogoName(game.homeTeam))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    Text(formatTeamName(game.homeTeam))
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 8)
            
            // Bookmakers
            if !game.usBookmakers.isEmpty {
                VStack(spacing: 12) {
                    // Bookmaker Selection
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(game.usBookmakers) { bookmaker in
                                Button {
                                    withAnimation {
                                        selectedBookmaker = selectedBookmaker?.key == bookmaker.key ? nil : bookmaker
                                    }
                                } label: {
                                    Image(getSportsBookLogoName(bookmaker.key))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: bookmaker.key == "fanduel" ? 32 : 24)
                                        .frame(width: 100)
                                        .frame(height: 48)
                                        .background(Color(white: 0.15))
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(selectedBookmaker?.key == bookmaker.key ? Color.accentColor : Color(white: 0.3), lineWidth: 1)
                                        )
                                }
                            }
                        }
                        .padding(.horizontal, 4)
                    }
                    
                    if let bookmaker = selectedBookmaker ?? game.usBookmakers.first {
                        VStack(spacing: 16) {
                            ForEach(bookmaker.markets, id: \.key) { market in
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(market.formattedKey)
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.gray)
                                        .padding(.bottom, 4)
                                    
                                    HStack(spacing: 0) {
                                        ForEach(market.outcomes, id: \.name) { outcome in
                                            VStack(alignment: .center, spacing: 6) {
                                                Text(formatTeamName(outcome.name))
                                                    .font(.system(size: 14, weight: .medium))
                                                    .foregroundColor(.white)
                                                Text(outcome.formattedPrice)
                                                    .font(.system(size: 16, weight: .bold))
                                                    .foregroundColor(
                                                        outcome.formattedPrice.hasPrefix("+") ? .green : .red
                                                    )
                                            }
                                            .frame(maxWidth: .infinity)
                                            
                                            if outcome.name != market.outcomes.last?.name {
                                                Divider()
                                                    .background(Color(white: 0.3))
                                                    .padding(.horizontal, 8)
                                            }
                                        }
                                    }
                                    .padding(12)
                                    .background(Color(white: 0.08))
                                    .cornerRadius(8)
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(white: 0.1))
        .cornerRadius(12)
        .onAppear {
            selectedBookmaker = game.usBookmakers.first { $0.key == "fanduel" } ?? game.usBookmakers.first
        }
    }
}

#Preview {
    GamesView()
        .preferredColorScheme(.dark)
} 