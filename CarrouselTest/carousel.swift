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
		guard let title = json["title"] as? String,
			let type = json["type"] as? CarouselType,
			let itemsJson = json["items"] as? [[String: Any]]
			else {
				return nil
		}

		var items: [Movie] = []
		for movie in itemsJson {
			guard let item = Movie(json: movie) else {
				return nil
			}
			items.append(item)
		}
		self.title = title
		self.type = type
		self.items = items
	}
}
