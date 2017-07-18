import Foundation

struct Carousel{
	enum CarouselType: String {
		case thumb, poster
	}

	let title: String
	let type: CarouselType
	let items: [Movie]
}

extension Carousel {
	init?(json: [String: Any]) {
		guard let title= json["title"] as? String,
			let type = json["type"] as? CarouselType,
			let itemsJson = json["items"] as? [[String: Any]]
			else {
				return nil
		}

		var items: Set<Movie> =[]
		for movie in itemsJson {
			guard let item = Movie(rawValue: movie) else {
				return nil
			}
			items.insert(item)
		}
		self.title = title
		self.type = type
		self.item = items
	} 
}