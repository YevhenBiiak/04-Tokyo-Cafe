//
//  Product.swift
//  04 Tokyo Cafe
//
//  Created by Евгений Бияк on 08.06.2022.
//

import UIKit

protocol Product {
    var image: UIImage? { get }
    var name: String { get }
    var description: String { get }
    var price: Float { get }
}

struct MenuItem: Product {
    static let testSet: [Product] = [
        MenuItem(image: UIImage(named: "Sunomono"), name: "Sunomono", description: "Cucumber, Soy Sauce, Vinegar, Nori", price: 100),
        MenuItem(image: UIImage(named: "Yōkan"), name: "Yōkan", description: "Mizu yokan, Neri yokan", price: 90),
        MenuItem(image: UIImage(named: "Tempura udon"), name: "Tempura udon", description: "Udon, Dashi, Shrimps, Narutomaki, Mirin", price: 104),
        MenuItem(image: UIImage(named: "Kitakata ramen"), name: "Kitakata ramen", description: "Ramen Noodles, Stock, Soy Sauce, Sardines, Pork, Scallions", price: 17),
        MenuItem(image: UIImage(named: "Tamago kake gohan"), name: "Tamago kake gohan", description: "Uruchimai, Rice Vinegar, Eggs", price: 34),
        MenuItem(image: UIImage(named: "Kiritanpo"), name: "Kiritanpo", description: "Rice", price: 75),
        MenuItem(image: UIImage(named: "Anpan"), name: "Anpan", description: "Wheat Flour, Butter, Milk, Eggs, Red Bean Paste, Sesame Seeds", price: 154),
        MenuItem(image: UIImage(named: "Chankonabe"), name: "Chankonabe", description: "Chicken, Scallions, Mushrooms, Carrot, Shrimps, Tofu", price: 93),
        MenuItem(image: UIImage(named: "Sūpu karē"), name: "Sūpu karē", description: "Chicken, Curry Powder, Potatoes, Bell Pepper, Carrot, Tomato Sauce", price: 59),
        MenuItem(image: UIImage(named: "Chirashizushi"), name: "Chirashizushi", description: "Uruchimai, Rice Vinegar, Sashimi, Eggs, Surimi", price: 96),
        MenuItem(image: UIImage(named: "Hitsumabushi"), name: "Hitsumabushi", description: "Unagi, Rice, Dashi, Scallions, Nori", price: 49),
        MenuItem(image: UIImage(named: "Tebasaki yakitori"), name: "Tebasaki yakitori", description: "Chicken, Salt, Black Pepper", price: 87),
        MenuItem(image: UIImage(named: "Yatsuhashi"), name: "Yatsuhashi", description: "Rice Flour, Sugar, Cinnamon, Red Bean Paste", price: 113),
        MenuItem(image: UIImage(named: "Hiyashi chūka"), name: "Hiyashi chūka", description: "Ramen Noodles, Eggs, Shrimps, Persian Cucumber, Lettuce, Tomato", price: 190),
        MenuItem(image: UIImage(named: "Kushiage"), name: "Kushiage", description: "Beef, Breadcrumbs, Black Pepper, Worcestershire Sauce, Soy Sauce", price: 89)
    ]
    
    let image: UIImage?
    let name: String
    let description: String
    let price: Float
}
