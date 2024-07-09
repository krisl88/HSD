// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//

import Foundation

// MARK: - TripData
struct TripData: Codable, Hashable {
    let trips: [Trip]
}

// MARK: - Trip
struct Trip: Codable, Hashable {
    let estimatedEarnings: Int
    let slug, timeAnchor: String
    let inSeries: Bool?
    let passengers: [Passenger]
    let plannedRoute: PlannedRoute
    let waypoints: [Waypoint]
    
    enum CodingKeys: String, CodingKey {
        case estimatedEarnings = "estimated_earnings"
        case slug
        case timeAnchor = "time_anchor"
        case inSeries = "in_series"
        case passengers
        case plannedRoute = "planned_route"
        case waypoints
    }
}

// MARK: - Passenger
struct Passenger: Codable, Hashable {
    let uuid: String?
    let boosterSeat: Bool
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case boosterSeat = "booster_seat"
    }
}

// MARK: - PlannedRoute
struct PlannedRoute: Codable, Hashable {
    let totalTime: Double
    let totalDistance: Int
    let startsAt, endsAt: String
    let legs: [Leg]
    
    enum CodingKeys: String, CodingKey {
        case totalTime = "total_time"
        case totalDistance = "total_distance"
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case legs
    }
}

// MARK: - Leg
struct Leg: Codable, Hashable {
    let position, startWaypointID, endWaypointID: Int
    
    enum CodingKeys: String, CodingKey {
        case position
        case startWaypointID = "start_waypoint_id"
        case endWaypointID = "end_waypoint_id"
    }
}

// MARK: - Waypoint
struct Waypoint: Codable, Hashable {
    let id: Int
    let location: Location
    let passengers: [Passenger]
}

// MARK: - Location
struct Location: Codable, Hashable {
    let address: String
    let lat, lng: Double
}
