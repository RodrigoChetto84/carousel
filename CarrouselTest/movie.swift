import Foundation

struct Movie{
	let title: String
	let url: String
	let video: String?
}

extension Movie {
	init?(json: [String: Any]) {
		guard let title= json["title"] as? String,
			let url= json["url"] as? String
			else {
				return nil
		}
		let video : String? = json["video"]
		
		self.title = title
		self.url = url
		self.video = video
	} 
}