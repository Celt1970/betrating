//  This file was automatically generated and should not be edited.

import Apollo

public final class MatchesQueryQuery: GraphQLQuery {
  public static let operationString =
    "query MatchesQuery($sport_slug: String!, $this_week: String!, $next_week: String!, $limit: Int!, $offset: Int!) {\n  Match(lang: \"ru\", sport_slug: $sport_slug, type: \"popular\", orderby: [\"match_date\", \"desc\"], datebetween: [$this_week, $next_week], limit: $limit, skip: $offset) {\n    __typename\n    unique_tournament_name\n    league {\n      __typename\n      name\n      country_name\n    }\n    league_slug\n    match_date\n    status {\n      __typename\n      code\n      name\n    }\n    result_score\n    teams {\n      __typename\n      name\n      logo(preset: \"w64-h64\")\n    }\n  }\n}"

  public var sport_slug: String
  public var this_week: String
  public var next_week: String
  public var limit: Int
  public var offset: Int

  public init(sport_slug: String, this_week: String, next_week: String, limit: Int, offset: Int) {
    self.sport_slug = sport_slug
    self.this_week = this_week
    self.next_week = next_week
    self.limit = limit
    self.offset = offset
  }

  public var variables: GraphQLMap? {
    return ["sport_slug": sport_slug, "this_week": this_week, "next_week": next_week, "limit": limit, "offset": offset]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("Match", arguments: ["lang": "ru", "sport_slug": GraphQLVariable("sport_slug"), "type": "popular", "orderby": ["match_date", "desc"], "datebetween": [GraphQLVariable("this_week"), GraphQLVariable("next_week")], "limit": GraphQLVariable("limit"), "skip": GraphQLVariable("offset")], type: .list(.object(Match.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(match: [Match?]? = nil) {
      self.init(snapshot: ["__typename": "Query", "Match": match.flatMap { $0.map { $0.flatMap { $0.snapshot } } }])
    }

    public var match: [Match?]? {
      get {
        return (snapshot["Match"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Match(snapshot: $0) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "Match")
      }
    }

    public struct Match: GraphQLSelectionSet {
      public static let possibleTypes = ["Match"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("unique_tournament_name", type: .scalar(String.self)),
        GraphQLField("league", type: .object(League.selections)),
        GraphQLField("league_slug", type: .scalar(String.self)),
        GraphQLField("match_date", type: .scalar(String.self)),
        GraphQLField("status", type: .object(Status.selections)),
        GraphQLField("result_score", type: .scalar(String.self)),
        GraphQLField("teams", type: .list(.object(Team.selections))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(uniqueTournamentName: String? = nil, league: League? = nil, leagueSlug: String? = nil, matchDate: String? = nil, status: Status? = nil, resultScore: String? = nil, teams: [Team?]? = nil) {
        self.init(snapshot: ["__typename": "Match", "unique_tournament_name": uniqueTournamentName, "league": league.flatMap { $0.snapshot }, "league_slug": leagueSlug, "match_date": matchDate, "status": status.flatMap { $0.snapshot }, "result_score": resultScore, "teams": teams.flatMap { $0.map { $0.flatMap { $0.snapshot } } }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var uniqueTournamentName: String? {
        get {
          return snapshot["unique_tournament_name"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "unique_tournament_name")
        }
      }

      public var league: League? {
        get {
          return (snapshot["league"] as? Snapshot).flatMap { League(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "league")
        }
      }

      public var leagueSlug: String? {
        get {
          return snapshot["league_slug"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "league_slug")
        }
      }

      public var matchDate: String? {
        get {
          return snapshot["match_date"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "match_date")
        }
      }

      public var status: Status? {
        get {
          return (snapshot["status"] as? Snapshot).flatMap { Status(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "status")
        }
      }

      public var resultScore: String? {
        get {
          return snapshot["result_score"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "result_score")
        }
      }

      public var teams: [Team?]? {
        get {
          return (snapshot["teams"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Team(snapshot: $0) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "teams")
        }
      }

      public struct League: GraphQLSelectionSet {
        public static let possibleTypes = ["League"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("country_name", type: .scalar(String.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(name: String? = nil, countryName: String? = nil) {
          self.init(snapshot: ["__typename": "League", "name": name, "country_name": countryName])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String? {
          get {
            return snapshot["name"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }

        public var countryName: String? {
          get {
            return snapshot["country_name"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "country_name")
          }
        }
      }

      public struct Status: GraphQLSelectionSet {
        public static let possibleTypes = ["Status"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("code", type: .scalar(String.self)),
          GraphQLField("name", type: .scalar(String.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(code: String? = nil, name: String? = nil) {
          self.init(snapshot: ["__typename": "Status", "code": code, "name": name])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var code: String? {
          get {
            return snapshot["code"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "code")
          }
        }

        public var name: String? {
          get {
            return snapshot["name"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }
      }

      public struct Team: GraphQLSelectionSet {
        public static let possibleTypes = ["Team"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("logo", arguments: ["preset": "w64-h64"], type: .scalar(String.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(name: String? = nil, logo: String? = nil) {
          self.init(snapshot: ["__typename": "Team", "name": name, "logo": logo])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String? {
          get {
            return snapshot["name"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }

        /// A logo
        public var logo: String? {
          get {
            return snapshot["logo"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "logo")
          }
        }
      }
    }
  }
}