import Foundation

enum CarouselType : String{
    
    case thumb,poster
    
    func getHeight() -> CGFloat{
        switch self{
        case .thumb: return 0.6//480
        case .poster: return 1.2//480
        }
    }
    
    func getWidth() -> CGFloat{
        switch self{
        case .thumb: return 0.8//640
        case .poster: return 0.8//320
        }
    }
    func getImageString() -> String{
        switch self{
        case .thumb: return "https://placeimg.com/640/480/any"
        case .poster: return "https://placeimg.com/320/480/any"
        }
    }
    
    func getTitleColor() -> UIColor
    {
        switch self{
        case .thumb: return UIColor.black
        case .poster: return UIColor.white
        }
    }
    func getTitleFont() -> UIFont
    {
        switch self{
        case .thumb: return UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)
        case .poster: return UIFont.boldSystemFont(ofSize: 28.0)
        }
    }
    func getTitleBackgroundColor() -> UIColor?
    {
        switch self{
        case .thumb: return UIColor.gray
        case .poster: return UIColor.clear
        }
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
