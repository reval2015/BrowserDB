import Foundation

struct Movie : Codable {
	let posterPath : String?
	let video : Bool?
	let vote_average : Double?
	let overview : String?
	var release_date : String?
    let first_air_date : String?
	let vote_count : Int?
	let adult : Bool?
	let backdrop_path : String?
	var title : String?
    let name : String?
	let genre_ids : [Int]?
	let id : Int?
	let original_language : String?
	let original_title : String?
	let popularity : Double?
	let media_type : String?

	enum CodingKeys: String, CodingKey {

		case posterPath = "poster_path"
		case video = "video"
		case vote_average = "vote_average"
		case overview = "overview"
		case release_date = "release_date"
        case first_air_date = "first_air_date"
		case vote_count = "vote_count"
		case adult = "adult"
		case backdrop_path = "backdrop_path"
		case title = "title"
        case name = "name"
		case genre_ids = "genre_ids"
		case id = "id"
		case original_language = "original_language"
		case original_title = "original_title"
		case popularity = "popularity"
		case media_type = "media_type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
		video = try values.decodeIfPresent(Bool.self, forKey: .video)
		vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		release_date = try values.decodeIfPresent(String.self, forKey: .release_date)
        first_air_date = try values.decodeIfPresent(String.self, forKey: .first_air_date)
        if first_air_date?.count ?? 0 > 0 {release_date = first_air_date}
		vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
		adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
		backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
		title = try values.decodeIfPresent(String.self, forKey: .title)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        if name?.count ?? 0 > 0 {title = name}
		genre_ids = try values.decodeIfPresent([Int].self, forKey: .genre_ids)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
		original_title = try values.decodeIfPresent(String.self, forKey: .original_title)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
		media_type = try values.decodeIfPresent(String.self, forKey: .media_type)
	}

}
