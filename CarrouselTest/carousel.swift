import Foundation

enum CarouselType : String{
    
    case thumb,poster
    
    func getHeight() -> CGFloat{
        switch self{
        case .thumb: return 480
        case .poster: return 480
        }
    }
    
    func getWidth() -> CGFloat{
        switch self{
        case .thumb: return 640
        case .poster: return 320
        }
    }
    func getImageString() -> String{
        return "https://placeimg.com/\(self.getWidth())/\(self.getHeight())/any"
    }
}




struct Carousel{

	let title: String
	let type: CarouselType
	let items: [Movie]
}

extension Carousel {
	init?(json: [String: Any]) {
		guard let title = json["title"] as? String,
            let type = json["type"] as? String,
			let itemsJson = json["items"] as? [[String: Any]]
			else {
				return nil
		}

        guard let carrouseltype = CarouselType(rawValue: type) else {
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
		self.type = carrouseltype
		self.items = items
	}
}
