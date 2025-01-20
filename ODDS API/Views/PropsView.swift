import SwiftUI

// Remove problematic import and use proper module structure
extension String {
    var sportsBookImageName: String {
        switch self {
        case "FanDuel": return "fanduel"
        case "DraftKings": return "draftkings"
        case "Bovada": return "bovada"
        case "BetOnline.ag": return "betonline"
        case "Caesars": return "caesars"
        case "BetMGM": return "betmgm"
        case "Bet365": return "bet365"
        case "ESPNBet": return "espnbet"
        default: return ""
        }
    }
}

struct GameHeader: View {
    let homeTeam: String
    let awayTeam: String
    
    var homeTeamImageName: String {
        switch homeTeam {
        case "Hornets": return "hornets"
        case "Rockets": return "rockets"
        case "Timberwolves": return "timberwolves"
        case "Hawks": return "hawks"
        case "Suns": return "suns"
        case "Celtics": return "celtics"
        case "Jazz": return "jazz"
        case "Bulls": return "bulls"
        default: return ""
        }
    }
    
    var awayTeamImageName: String {
        switch awayTeam {
        case "Mavericks": return "mavericks"
        case "Pistons": return "pistons"
        case "Grizzlies": return "grizzlies"
        case "Knicks": return "knicks"
        case "Cavaliers": return "cavaliers"
        case "Warriors": return "warriors"
        case "Pelicans": return "pelicans"
        case "Clippers": return "clippers"
        default: return ""
        }
    }
    
    var body: some View {
        HStack {
            Spacer()
            HStack(spacing: 12) {
                Image(awayTeamImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                
                Text("\(awayTeam) vs \(homeTeam)")
                    .font(.headline)
                
                Image(homeTeamImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            Spacer()
        }
        .padding(.top)
    }
}

struct PlayerPropRow: View {
    let playerName: String
    let line: Double
    let overPrice: Int
    let underPrice: Int
    let bookmaker: String
    
    // NBA Player IDs
    var playerId: String {
        switch playerName {
        // Hornets vs Mavericks
        case "LaMelo Ball": return "1630163"
        case "Kyrie Irving": return "202681"
        case "Miles Bridges": return "1628970"
        case "Mark Williams": return "1631109"
        case "Spencer Dinwiddie": return "203915"
        case "Dereck Lively II": return "1641706"
        case "P.J. Washington": return "1629023"
        case "Naji Marshall": return "1630230"
        case "Josh Green": return "1630182"
        case "Klay Thompson": return "202691"
        
        // Pistons vs Rockets
        case "Cade Cunningham": return "1630595"
        case "Jalen Green": return "1630224"
        case "Alperen Sengun": return "1630578"
        case "Fred VanVleet": return "1627832"
        case "Dillon Brooks": return "1628415"
        case "Jalen Duren": return "1631105"
        case "Ausar Thompson": return "1641710"
        case "Amen Thompson": return "1641709"
        case "Isaiah Stewart II": return "1630191"
        case "Malik Beasley": return "1627736"
        case "Tobias Harris": return "202699"
        case "Tim Hardaway Jr": return "203501"
        
        // Clippers vs Bulls
        case "Zach LaVine": return "203897"
        case "James Harden": return "201935"
        case "Nikola Vucevic": return "202696"
        case "Coby White": return "1629632"
        case "Ivica Zubac": return "1627826"
        case "Josh Giddey": return "1630581"
        case "Derrick Jones": return "1627884"
        case "Patrick Williams": return "1630172"
        case "Norman Powell": return "1626181"
        
        // Grizzlies vs Timberwolves
        case "Anthony Edwards": return "1630162"
        case "Jaren Jackson Jr": return "1628991"
        case "Desmond Bane": return "1630217"
        case "Jaden McDaniels": return "1630183"
        case "Rudy Gobert": return "203497"
        case "Mike Conley": return "201144"
        case "Nickeil Alexander-Walker": return "1629638"
        
        // Knicks vs Hawks
        case "Jalen Brunson": return "1630195"
        case "Karl-Anthony Towns": return "1626157"
        case "Trae Young": return "1629027"
        case "Mikal Bridges": return "1628969"
        case "Jalen Johnson": return "1630552"
        case "De'Andre Hunter": return "1629631"
        case "OG Anunoby": return "1628384"
        case "Josh Hart": return "1628404"
        case "Dyson Daniels": return "1631096"
        case "Onyeka Okongwu": return "1630168"
        case "Clint Capela": return "203991"
        
        // Cavaliers vs Suns
        case "Devin Booker": return "1626164"
        case "Kevin Durant": return "201142"
        case "Donovan Mitchell": return "1628378"
        case "Darius Garland": return "1629636"
        case "Jarrett Allen": return "1628386"
        case "Caris LeVert": return "1627747"
        case "Nick Richards": return "1630208"
        case "Tyus Jones": return "1626145"
        
        // Warriors vs Celtics
        case "Jayson Tatum": return "1628369"
        case "Stephen Curry": return "201939"
        case "Jaylen Brown": return "1627759"
        case "Kristaps Porzingis": return "1626163"
        
        // Pelicans vs Jazz
        case "Zion Williamson": return "1629627"
        case "Keyonte George": return "1641718"
        case "C.J. McCollum": return "203468"
        case "Trey Murphy III": return "1630530"
        case "Dejounte Murray": return "1627749"
        case "Walker Kessler": return "1631107"
        case "Isaiah Collier": return "1641711"
        
        default: return ""
        }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            // Player Headshot
            AsyncImage(url: URL(string: "https://cdn.nba.com/headshots/nba/latest/1040x760/\(playerId).png")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .fill(Color(white: 0.2))
                    .frame(width: 50, height: 50)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(playerName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Image(bookmaker.sportsBookImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                }
                
                HStack(spacing: 16) {
                    PriceButton(price: overPrice, type: "Over", line: line)
                    PriceButton(price: underPrice, type: "Under", line: line)
                }
            }
        }
        .padding()
        .background(Color(white: 0.1))
        .cornerRadius(12)
    }
}

struct PriceButton: View {
    let price: Int
    let type: String
    let line: Double
    
    var formattedPrice: String {
        price > 0 ? "+\(price)" : "\(price)"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(type)
                .font(.system(size: 12))
                .foregroundColor(.gray)
            HStack(spacing: 4) {
                Text(String(format: "%.1f", line))
                    .font(.system(size: 16, weight: .medium))
                Text(formattedPrice)
                    .font(.system(size: 16, weight: .medium))
            }
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color(white: 0.15))
        .cornerRadius(8)
    }
}

struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(isSelected ? .white : .gray)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.accentColor : Color(white: 0.15))
                .cornerRadius(20)
        }
    }
}

struct FilterSection: View {
    let title: String
    let options: [String]
    let selectedOption: String?
    let onSelect: (String) -> Void
    let onClear: () -> Void
    @State private var isExpanded = false
    
    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(action: { onSelect(option) }) {
                    HStack {
                        Text(option)
                        if option == selectedOption {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                Text(selectedOption ?? "All")
                    .font(.system(size: 14))
                    .foregroundColor(selectedOption == nil ? .gray : .white)
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                if selectedOption != nil {
                    Button(action: onClear) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(white: 0.15))
            .cornerRadius(8)
        }
    }
}

struct HornetsMavericksProps: View {
    let selectedTab: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            GameHeader(homeTeam: "Hornets", awayTeam: "Mavericks")
            
            switch selectedTab {
            case "Points":
                PlayerPropRow(playerName: "LaMelo Ball", line: 29.5, overPrice: -115, underPrice: -105, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Kyrie Irving", line: 24.5, overPrice: -122, underPrice: -105, bookmaker: "Bovada")
                PlayerPropRow(playerName: "Miles Bridges", line: 19.5, overPrice: -107, underPrice: -117, bookmaker: "BetOnline.ag")
                PlayerPropRow(playerName: "Mark Williams", line: 16.5, overPrice: +102, underPrice: -123, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Spencer Dinwiddie", line: 15.5, overPrice: -107, underPrice: -115, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "P.J. Washington", line: 14.5, overPrice: -113, underPrice: -110, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Klay Thompson", line: 12.5, overPrice: -110, underPrice: -113, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Naji Marshall", line: 11.5, overPrice: -110, underPrice: -115, bookmaker: "BetOnline.ag")
                PlayerPropRow(playerName: "Dereck Lively II", line: 8.5, overPrice: +107, underPrice: -131, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Josh Green", line: 5.5, overPrice: -118, underPrice: -104, bookmaker: "Caesars")
                
            case "Rebounds":
                PlayerPropRow(playerName: "Mark Williams", line: 12.5, overPrice: +104, underPrice: -130, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Dereck Lively II", line: 8.5, overPrice: -112, underPrice: -117, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "P.J. Washington", line: 7.5, overPrice: -130, underPrice: +104, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Miles Bridges", line: 7.5, overPrice: -124, underPrice: -101, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "LaMelo Ball", line: 5.5, overPrice: -108, underPrice: -115, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Kyrie Irving", line: 4.5, overPrice: -115, underPrice: -115, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Naji Marshall", line: 4.5, overPrice: +104, underPrice: -124, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Spencer Dinwiddie", line: 3.5, overPrice: -106, underPrice: -117, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Klay Thompson", line: 3.5, overPrice: +108, underPrice: -128, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Josh Green", line: 3.5, overPrice: +112, underPrice: -140, bookmaker: "Caesars")
                
            case "Assists":
                PlayerPropRow(playerName: "LaMelo Ball", line: 8.5, overPrice: +114, underPrice: -150, bookmaker: "Bovada")
                PlayerPropRow(playerName: "Spencer Dinwiddie", line: 5.5, overPrice: +112, underPrice: -142, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Kyrie Irving", line: 5.5, overPrice: +124, underPrice: -165, bookmaker: "Bovada")
                PlayerPropRow(playerName: "Miles Bridges", line: 3.5, overPrice: -126, underPrice: +105, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Naji Marshall", line: 3.5, overPrice: +124, underPrice: -162, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Dereck Lively II", line: 2.5, overPrice: -120, underPrice: -108, bookmaker: "BetOnline.ag")
                PlayerPropRow(playerName: "P.J. Washington", line: 1.5, overPrice: -146, underPrice: +133, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Mark Williams", line: 1.5, overPrice: -130, underPrice: +104, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Klay Thompson", line: 1.5, overPrice: -138, underPrice: +116, bookmaker: "Caesars")
                
            default:
                Text("Coming Soon: \(selectedTab) Props")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}

struct PistonsRocketsProps: View {
    let selectedTab: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            GameHeader(homeTeam: "Rockets", awayTeam: "Pistons")
            
            switch selectedTab {
            case "Points":
                PlayerPropRow(playerName: "Cade Cunningham", line: 27.5, overPrice: -103, underPrice: -125, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Jalen Green", line: 22.5, overPrice: -132, underPrice: +108, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Alperen Sengun", line: 21.5, overPrice: -109, underPrice: -117, bookmaker: "BetOnline.ag")
                PlayerPropRow(playerName: "Amen Thompson", line: 14.5, overPrice: -120, underPrice: -102, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Malik Beasley", line: 13.5, overPrice: -125, underPrice: -103, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Dillon Brooks", line: 13.5, overPrice: -107, underPrice: -117, bookmaker: "BetOnline.ag")
                PlayerPropRow(playerName: "Fred VanVleet", line: 13.5, overPrice: -106, underPrice: -118, bookmaker: "BetOnline.ag")
                PlayerPropRow(playerName: "Tobias Harris", line: 12.5, overPrice: -125, underPrice: -103, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Tim Hardaway Jr", line: 11.5, overPrice: -125, underPrice: -103, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Jalen Duren", line: 8.5, overPrice: -120, underPrice: -108, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Ausar Thompson", line: 7.5, overPrice: -125, underPrice: -103, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Isaiah Stewart II", line: 5.5, overPrice: -117, underPrice: -112, bookmaker: "Caesars")
                
            case "Rebounds":
                PlayerPropRow(playerName: "Alperen Sengun", line: 10.5, overPrice: -104, underPrice: -125, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Jalen Duren", line: 9.5, overPrice: -103, underPrice: -125, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Amen Thompson", line: 8.5, overPrice: -130, underPrice: +110, bookmaker: "BetOnline.ag")
                PlayerPropRow(playerName: "Tobias Harris", line: 5.5, overPrice: -122, underPrice: -106, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Cade Cunningham", line: 5.5, overPrice: +104, underPrice: -130, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Isaiah Stewart II", line: 5.5, overPrice: +116, underPrice: -138, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Ausar Thompson", line: 4.5, overPrice: -112, underPrice: -112, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Jalen Green", line: 4.5, overPrice: +124, underPrice: -138, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Dillon Brooks", line: 3.5, overPrice: -112, underPrice: -112, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Fred VanVleet", line: 3.5, overPrice: +106, underPrice: -126, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Malik Beasley", line: 2.5, overPrice: +116, underPrice: -138, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Tim Hardaway Jr", line: 2.5, overPrice: +133, underPrice: -146, bookmaker: "Caesars")
                
            case "Assists":
                PlayerPropRow(playerName: "Cade Cunningham", line: 8.5, overPrice: -127, underPrice: +102, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Fred VanVleet", line: 6.5, overPrice: -135, underPrice: +120, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Alperen Sengun", line: 5.5, overPrice: +128, underPrice: -139, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Amen Thompson", line: 3.5, overPrice: +106, underPrice: -126, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Jalen Green", line: 2.5, overPrice: -112, underPrice: -112, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Tobias Harris", line: 2.5, overPrice: +139, underPrice: -152, bookmaker: "BetOnline.ag")
                PlayerPropRow(playerName: "Dillon Brooks", line: 1.5, overPrice: -127, underPrice: +100, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Isaiah Stewart II", line: 1.5, overPrice: -108, underPrice: -120, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Jalen Duren", line: 1.5, overPrice: -143, underPrice: +126, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Tim Hardaway Jr", line: 1.5, overPrice: +139, underPrice: -148, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Ausar Thompson", line: 1.5, overPrice: -138, underPrice: +116, bookmaker: "Caesars")
                
            default:
                Text("Coming Soon: \(selectedTab) Props")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}

struct GrizzliesTimberwolvesProps: View {
    let selectedTab: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            GameHeader(homeTeam: "Timberwolves", awayTeam: "Grizzlies")
            
            switch selectedTab {
            case "Points":
                PlayerPropRow(playerName: "Anthony Edwards", line: 26.5, overPrice: -115, underPrice: -110, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Jaren Jackson Jr", line: 21.5, overPrice: -125, underPrice: -105, bookmaker: "Bovada")
                PlayerPropRow(playerName: "Desmond Bane", line: 19.5, overPrice: -105, underPrice: -120, bookmaker: "BetOnline.ag")
                PlayerPropRow(playerName: "Jaden McDaniels", line: 12.5, overPrice: +100, underPrice: -123, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Rudy Gobert", line: 11.5, overPrice: -105, underPrice: -120, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Mike Conley", line: 9.5, overPrice: -117, underPrice: -109, bookmaker: "BetOnline.ag")
                PlayerPropRow(playerName: "Nickeil Alexander-Walker", line: 7.5, overPrice: -122, underPrice: -104, bookmaker: "Caesars")
                
            case "Rebounds":
                PlayerPropRow(playerName: "Rudy Gobert", line: 11.5, overPrice: +105, underPrice: -130, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Jaren Jackson Jr", line: 7.5, overPrice: -115, underPrice: -110, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Anthony Edwards", line: 5.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Jaden McDaniels", line: 5.5, overPrice: -120, underPrice: -102, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Desmond Bane", line: 5.5, overPrice: +116, underPrice: -138, bookmaker: "Caesars")
                PlayerPropRow(playerName: "Nickeil Alexander-Walker", line: 2.5, overPrice: -132, underPrice: +114, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Mike Conley", line: 2.5, overPrice: +104, underPrice: -124, bookmaker: "FanDuel")
                
            case "Assists":
                PlayerPropRow(playerName: "Mike Conley", line: 6.5, overPrice: -132, underPrice: +114, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Anthony Edwards", line: 5.5, overPrice: +130, underPrice: -141, bookmaker: "Bovada")
                PlayerPropRow(playerName: "Desmond Bane", line: 4.5, overPrice: -115, underPrice: -110, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Nickeil Alexander-Walker", line: 2.5, overPrice: +104, underPrice: -124, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Jaren Jackson Jr", line: 2.5, overPrice: +110, underPrice: -135, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Jaden McDaniels", line: 1.5, overPrice: -125, underPrice: +105, bookmaker: "DraftKings")
                
            default:
                Text("Coming Soon: \(selectedTab) Props")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}

struct KnicksHawksProps: View {
    let selectedTab: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            GameHeader(homeTeam: "Hawks", awayTeam: "Knicks")
            
            switch selectedTab {
            case "Points":
                PlayerPropRow(playerName: "Jalen Brunson", line: 28.5, overPrice: -109, underPrice: -117, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Karl-Anthony Towns", line: 25.5, overPrice: -113, underPrice: -115, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Trae Young", line: 24.5, overPrice: -105, underPrice: -120, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Mikal Bridges", line: 18.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Jalen Johnson", line: 17.5, overPrice: -109, underPrice: -117, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "De'Andre Hunter", line: 15.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "OG Anunoby", line: 15.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Josh Hart", line: 14.5, overPrice: -117, underPrice: -109, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Dyson Daniels", line: 11.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Onyeka Okongwu", line: 10.5, overPrice: -105, underPrice: -120, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Clint Capela", line: 7.5, overPrice: -129, underPrice: +110, bookmaker: "DraftKings")
                
            case "Rebounds":
                PlayerPropRow(playerName: "Clint Capela", line: 10.5, overPrice: -115, underPrice: -110, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Karl-Anthony Towns", line: 8.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Onyeka Okongwu", line: 7.5, overPrice: -115, underPrice: -110, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Josh Hart", line: 7.5, overPrice: -125, underPrice: +105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Jalen Johnson", line: 7.5, overPrice: -115, underPrice: -110, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "OG Anunoby", line: 5.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Mikal Bridges", line: 4.5, overPrice: -115, underPrice: -110, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "De'Andre Hunter", line: 4.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Trae Young", line: 3.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Jalen Brunson", line: 3.5, overPrice: -125, underPrice: +105, bookmaker: "DraftKings")
                
            case "Assists":
                PlayerPropRow(playerName: "Trae Young", line: 10.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Jalen Brunson", line: 6.5, overPrice: -125, underPrice: +105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Jalen Johnson", line: 3.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Josh Hart", line: 3.5, overPrice: -115, underPrice: -110, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Karl-Anthony Towns", line: 3.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Mikal Bridges", line: 2.5, overPrice: -125, underPrice: +105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "De'Andre Hunter", line: 1.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                
            default:
                Text("Coming Soon: \(selectedTab) Props")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}

struct CavaliersSunsProps: View {
    let selectedTab: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            GameHeader(homeTeam: "Suns", awayTeam: "Cavaliers")
            
            switch selectedTab {
            case "Points":
                PlayerPropRow(playerName: "Devin Booker", line: 27.5, overPrice: -113, underPrice: -117, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Kevin Durant", line: 27.5, overPrice: -110, underPrice: -120, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Donovan Mitchell", line: 26.5, overPrice: -102, underPrice: -125, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Darius Garland", line: 21.5, overPrice: -113, underPrice: -117, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Jarrett Allen", line: 15.5, overPrice: -104, underPrice: -126, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Caris LeVert", line: 11.5, overPrice: -102, underPrice: -125, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Nick Richards", line: 9.5, overPrice: -122, underPrice: +102, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Tyus Jones", line: 8.5, overPrice: -102, underPrice: -125, bookmaker: "FanDuel")
                
            case "Rebounds":
                PlayerPropRow(playerName: "Jarrett Allen", line: 11.5, overPrice: -115, underPrice: -110, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Kevin Durant", line: 7.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Nick Richards", line: 7.5, overPrice: -115, underPrice: -110, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Devin Booker", line: 4.5, overPrice: -125, underPrice: +105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Donovan Mitchell", line: 4.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Darius Garland", line: 3.5, overPrice: -115, underPrice: -110, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Caris LeVert", line: 3.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Tyus Jones", line: 2.5, overPrice: -125, underPrice: +105, bookmaker: "DraftKings")
                
            case "Assists":
                PlayerPropRow(playerName: "Darius Garland", line: 8.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Devin Booker", line: 7.5, overPrice: -115, underPrice: -110, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Kevin Durant", line: 5.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Donovan Mitchell", line: 5.5, overPrice: -125, underPrice: +105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Tyus Jones", line: 4.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Caris LeVert", line: 3.5, overPrice: -115, underPrice: -110, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "Jarrett Allen", line: 2.5, overPrice: -120, underPrice: -105, bookmaker: "DraftKings")
                
            default:
                Text("Coming Soon: \(selectedTab) Props")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}

struct WarriorsCelticsProps: View {
    let selectedTab: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            GameHeader(homeTeam: "Celtics", awayTeam: "Warriors")
            
            switch selectedTab {
            case "Points":
                PlayerPropRow(playerName: "Jayson Tatum", line: 26.5, overPrice: -125, underPrice: -102, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Stephen Curry", line: 25.5, overPrice: -125, underPrice: -102, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Jaylen Brown", line: 22.5, overPrice: -128, underPrice: +100, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Kristaps Porzingis", line: 18.5, overPrice: -106, underPrice: -117, bookmaker: "FanDuel")
                
            case "Rebounds":
                PlayerPropRow(playerName: "Kristaps Porzingis", line: 8.5, overPrice: +100, underPrice: -122, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Jayson Tatum", line: 8.5, overPrice: -118, underPrice: -104, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Jaylen Brown", line: 5.5, overPrice: +102, underPrice: -123, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Stephen Curry", line: 4.5, overPrice: -118, underPrice: -104, bookmaker: "FanDuel")
                
            case "Assists":
                PlayerPropRow(playerName: "Stephen Curry", line: 6.5, overPrice: -106, underPrice: -117, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Jayson Tatum", line: 4.5, overPrice: -130, underPrice: +112, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Jaylen Brown", line: 4.5, overPrice: -128, underPrice: +108, bookmaker: "FanDuel")
                
            default:
                Text("Coming Soon: \(selectedTab) Props")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}

struct PelicansJazzProps: View {
    let selectedTab: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            GameHeader(homeTeam: "Jazz", awayTeam: "Pelicans")
            
            switch selectedTab {
            case "Points":
                PlayerPropRow(playerName: "Zion Williamson", line: 23.5, overPrice: -120, underPrice: -108, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Keyonte George", line: 22.5, overPrice: -117, underPrice: -113, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "C.J. McCollum", line: 22.5, overPrice: -112, underPrice: -112, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Trey Murphy III", line: 21.5, overPrice: -117, underPrice: -104, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Dejounte Murray", line: 17.5, overPrice: -117, underPrice: -106, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Walker Kessler", line: 12.5, overPrice: -110, underPrice: -113, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Isaiah Collier", line: 10.5, overPrice: -102, underPrice: -120, bookmaker: "FanDuel")
                
            case "Rebounds":
                PlayerPropRow(playerName: "Walker Kessler", line: 11.5, overPrice: -118, underPrice: -104, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Zion Williamson", line: 7.5, overPrice: +100, underPrice: -122, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Dejounte Murray", line: 6.5, overPrice: -124, underPrice: +104, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Trey Murphy III", line: 5.5, overPrice: -128, underPrice: +108, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Isaiah Collier", line: 3.5, overPrice: -150, underPrice: +130, bookmaker: "DraftKings")
                PlayerPropRow(playerName: "C.J. McCollum", line: 3.5, overPrice: -132, underPrice: +114, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Keyonte George", line: 3.5, overPrice: -124, underPrice: +104, bookmaker: "FanDuel")
                
            case "Assists":
                PlayerPropRow(playerName: "Dejounte Murray", line: 7.5, overPrice: -122, underPrice: +100, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Isaiah Collier", line: 7.5, overPrice: -113, underPrice: -110, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Keyonte George", line: 5.5, overPrice: +110, underPrice: -129, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Zion Williamson", line: 4.5, overPrice: -132, underPrice: +116, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "C.J. McCollum", line: 4.5, overPrice: +124, underPrice: -138, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Trey Murphy III", line: 3.5, overPrice: +118, underPrice: -133, bookmaker: "FanDuel")
                
            default:
                Text("Coming Soon: \(selectedTab) Props")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}

struct ClippersBullsProps: View {
    let selectedTab: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            GameHeader(homeTeam: "Bulls", awayTeam: "Clippers")
            
            switch selectedTab {
            case "Points":
                PlayerPropRow(playerName: "Zach LaVine", line: 23.5, overPrice: -122, underPrice: +100, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "James Harden", line: 20.5, overPrice: -122, underPrice: -104, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Nikola Vucevic", line: 18.5, overPrice: -122, underPrice: -104, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Coby White", line: 17.5, overPrice: -122, underPrice: -104, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Ivica Zubac", line: 14.5, overPrice: -115, underPrice: -107, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Josh Giddey", line: 10.5, overPrice: -122, underPrice: -104, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Derrick Jones", line: 8.5, overPrice: -111, underPrice: -113, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Patrick Williams", line: 7.5, overPrice: -125, underPrice: -102, bookmaker: "FanDuel")
                
            case "Rebounds":
                PlayerPropRow(playerName: "Ivica Zubac", line: 12.5, overPrice: -123, underPrice: +102, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Nikola Vucevic", line: 10.5, overPrice: -122, underPrice: -104, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Josh Giddey", line: 6.5, overPrice: -152, underPrice: +120, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "James Harden", line: 5.5, overPrice: +102, underPrice: -123, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Zach LaVine", line: 4.5, overPrice: -149, underPrice: +116, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Norman Powell", line: 3.5, overPrice: -107, underPrice: -118, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Coby White", line: 2.5, overPrice: -162, underPrice: +124, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Derrick Jones", line: 2.5, overPrice: -149, underPrice: +114, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Patrick Williams", line: 2.5, overPrice: -168, underPrice: +132, bookmaker: "FanDuel")
                
            case "Assists":
                PlayerPropRow(playerName: "James Harden", line: 9.5, overPrice: +112, underPrice: -143, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Josh Giddey", line: 5.5, overPrice: +100, underPrice: -122, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Zach LaVine", line: 4.5, overPrice: +114, underPrice: -149, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Coby White", line: 4.5, overPrice: -113, underPrice: -111, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Ivica Zubac", line: 2.5, overPrice: -115, underPrice: -107, bookmaker: "FanDuel")
                PlayerPropRow(playerName: "Nikola Vucevic", line: 2.5, overPrice: -149, underPrice: +114, bookmaker: "FanDuel")
                
            default:
                Text("Coming Soon: \(selectedTab) Props")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}

struct PropsView: View {
    @StateObject private var viewModel = PropsViewModel()
    @State private var selectedTab = 0
    @State private var selectedLeague = "NBA"
    @State private var selectedGame: String?
    @State private var selectedTeam: String?
    
    let leagues = ["NBA", "NFL", "NHL", "NCAAF", "NCAAB", "MLB"]
    
    var games: [String] {
        ["Hornets vs Mavericks", "Pistons vs Rockets", "Grizzlies vs Timberwolves", 
         "Knicks vs Hawks", "Cavaliers vs Suns", "Warriors vs Celtics", 
         "Pelicans vs Jazz", "Clippers vs Bulls"]
    }
    
    var teams: [String] {
        ["Hornets", "Mavericks", "Pistons", "Rockets", "Grizzlies", "Timberwolves",
         "Knicks", "Hawks", "Cavaliers", "Suns", "Warriors", "Celtics",
         "Pelicans", "Jazz", "Clippers", "Bulls"]
    }
    
    var filteredContent: [String: Bool] {
        var showGame = [String: Bool]()
        for game in games {
            if let selectedTeam = selectedTeam {
                showGame[game] = game.contains(selectedTeam)
            } else if let selectedGame = selectedGame {
                showGame[game] = game == selectedGame
            } else {
                showGame[game] = true
            }
        }
        return showGame
    }
    
    var propTypes: [String] {
        switch selectedLeague {
        case "NCAAB":
            return [
                "Points",
                "Rebounds",
                "Assists",
                "Three Pointers",
                "Blocks",
                "Steals",
                "PRA", // Points + Rebounds + Assists
                "P+R", // Points + Rebounds
                "P+A", // Points + Assists
                "R+A", // Rebounds + Assists
                "FG Made",
                "FT Made"
            ]
        case "NCAAF":
            return [
                "Pass Yards",
                "Rush Yards",
                "Rec Yards",
                "Pass TDs",
                "Rush TDs",
                "Rec TDs",
                "Completions",
                "Pass Attempts",
                "Receptions",
                "Tackles + Assists",
                "Interceptions",
                "Sacks"
            ]
        case "NHL":
            return [
                "Goals",
                "Assists",
                "Points",
                "Shots",
                "Saves",
                "Goals Against",
                "Power Play Points",
                "Blocks",
                "Time on Ice",
                "G+A" // Goals + Assists
            ]
        case "NFL":
            return [
                "Pass Yards",
                "Rush Yards",
                "Rec Yards",
                "Pass TDs",
                "Rush TDs",
                "Rec TDs",
                "Completions",
                "Interceptions",
                "Receptions",
                "Sacks"
            ]
        case "NBA":
            return [
                "Points",
                "Rebounds",
                "Assists",
                "Three Pointers",
                "Blocks",
                "Steals",
                "PRA", // Points + Rebounds + Assists
                "P+R", // Points + Rebounds
                "P+A", // Points + Assists
                "R+A"  // Rebounds + Assists
            ]
        case "MLB":
            return [
                "Strikeouts",
                "Hits Allowed",
                "Earned Runs",
                "Walks Issued",
                "Hits + Runs + RBIs",
                "Total Bases",
                "Hits",
                "RBIs",
                "Runs Scored",
                "Home Runs",
                "Stolen Bases",
                "Pitching Outs"
            ]
        default:
            return []
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // League Selector
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(leagues, id: \.self) { league in
                                LeagueButton(
                                    title: league,
                                    isSelected: selectedLeague == league,
                                    action: {
                                        selectedLeague = league
                                        selectedTab = 0
                                        selectedGame = nil
                                        selectedTeam = nil
                                    }
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 8)
                    
                    if propTypes.count > 1 {
                        // Custom Tab Bar
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(0..<propTypes.count, id: \.self) { index in
                                    VStack(spacing: 8) {
                                        Text(propTypes[index])
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(selectedTab == index ? .accentColor : .gray)
                                        
                                        Rectangle()
                                            .fill(selectedTab == index ? Color.accentColor : Color.clear)
                                            .frame(height: 2)
                                    }
                                    .onTapGesture {
                                        withAnimation {
                                            selectedTab = index
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical, 8)
                        .background(Color.black)
                        
                        // Filters
                        HStack(spacing: 12) {
                            FilterSection(
                                title: "Game:",
                                options: games,
                                selectedOption: selectedGame,
                                onSelect: { game in
                                    selectedGame = game
                                    selectedTeam = nil
                                },
                                onClear: { selectedGame = nil }
                            )
                            
                            FilterSection(
                                title: "Team:",
                                options: teams,
                                selectedOption: selectedTeam,
                                onSelect: { team in
                                    selectedTeam = team
                                    selectedGame = nil
                                },
                                onClear: { selectedTeam = nil }
                            )
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        
                        // Content
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                if selectedLeague == "NBA" {
                                    if filteredContent["Hornets vs Mavericks", default: false] {
                                        HornetsMavericksProps(selectedTab: propTypes[selectedTab])
                                    }
                                    if filteredContent["Pistons vs Rockets", default: false] {
                                        PistonsRocketsProps(selectedTab: propTypes[selectedTab])
                                    }
                                    if filteredContent["Grizzlies vs Timberwolves", default: false] {
                                        GrizzliesTimberwolvesProps(selectedTab: propTypes[selectedTab])
                                    }
                                    if filteredContent["Knicks vs Hawks", default: false] {
                                        KnicksHawksProps(selectedTab: propTypes[selectedTab])
                                    }
                                    if filteredContent["Cavaliers vs Suns", default: false] {
                                        CavaliersSunsProps(selectedTab: propTypes[selectedTab])
                                    }
                                    if filteredContent["Warriors vs Celtics", default: false] {
                                        WarriorsCelticsProps(selectedTab: propTypes[selectedTab])
                                    }
                                    if filteredContent["Pelicans vs Jazz", default: false] {
                                        PelicansJazzProps(selectedTab: propTypes[selectedTab])
                                    }
                                    if filteredContent["Clippers vs Bulls", default: false] {
                                        ClippersBullsProps(selectedTab: propTypes[selectedTab])
                                    }
                                } else {
                                    Text("Coming Soon: \(propTypes[selectedTab]) Props")
                                        .foregroundColor(.gray)
                                        .padding()
                                }
                            }
                            .padding()
                        }
                    } else {
                        Spacer()
                        Text("Player Props Coming Soon")
                            .foregroundColor(.gray)
                            .font(.headline)
                        Spacer()
                    }
                }
            }
            #if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Props")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            #endif
        }
    }
}

#Preview {
    PropsView()
        .preferredColorScheme(.dark)
} 