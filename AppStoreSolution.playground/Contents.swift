import UIKit
//: ### App Store - Sample Solution
/*:
## Create a Swift playground with a model that simulates how AppStore works.
 ###Requirements:
Model should consists of three classes
1. Developers
2. Apps
3. AppStore

App store will have following rules:
1. Developers have following properties and capabalities:
2. they have unique id (Int)
3. they can create apps
4. they can transfer apps to other developer, which means that they can receive apps from other developers as well
5. they can submit apps to the AppStore
6. they own a bank account that is presented as profit (Double)

Apps have following properties:
1. developer (owner of the application)
2. name (name of the app)
3. price (price of the app)

AppStore have following properties
1. apps (collection ofthe apps submitted and approved to the app store)
2. profit variable that stores profit of the store
3. submission process (developers can submit apps to the store but they are not always accepted. Use an arc4random_uniform function to randomize the submission process
4. every day customers buy apps from the App Store. Use an arc4random_uniform function to choose randomly which apps will be sold on the store and how many apps are sold. When the apps are sold app store receives 30% of the revenue and 70 percent of the revenue goes to the developer.
5. every day it will computes number of sold copies and send information to developer

6. when developer submits the app to the store, and submission is successful AppStore should update its app listings represented as array of apps


### Scoring:

- Valid structure of classes (50%)
- Submission process (10%)
- Randomized process of selling apps(10%)
- Transferring apps between developers (10%)
- Testing behavior of the store (20%)

*/

/*:
#### App Store class
    Responsible for storing information about developers, profits, apps available on the store
*/
class AppStore
{
    var apps:[App] = [App]()
    var developers:[Developer] = [Developer]()
    var profit:Double = 0.0
    var profit_store:Double = 0.3
    var profit_dev:Double = 0.7
    
    func submit(app: App) -> Bool
    {
        let accepted_probability:Int = 75
        
        if(Int(arc4random_uniform(100)) <= accepted_probability)
        {
            // Accept app
            
            apps.append(app)
            return true
        }
        
        // Denied
        
        return false
    }
    
    /**Create a new instance of developer*/
    func new_dev() -> Developer
    {
        let new_dev_ID:Int = developers.count + 1
        
        let dev:Developer = Developer(dev_ID: new_dev_ID, dev_store: self)
        
        developers.append(dev)
        
        return dev
    }
    
    
    
    //sell apps function
    
    func sell_apps()
    {
        let sold_probability:Int = 56
        
        for app in apps
        {
            // Do we sell the app today?
            
            if(Int(arc4random_uniform(100)) <= sold_probability)
            {
                // Yes, sell it!
                
                let number_of_copies_sold = Int(arc4random_uniform(1000000))
                let app_profit = Double(number_of_copies_sold) * app.price
                let dev_profit = profit_dev * app_profit
                
                profit += profit_store * app_profit
                app.developer.profit += dev_profit
                app.developer.profit
                
                app.copies_sold += number_of_copies_sold
                app.income = dev_profit
            }
        }
    }
    
    func get_store_stats()
    {
        var copies_sold:Int = 0
        
        // Add copies sold for each app to the total
        
        for app in apps
        {
            copies_sold += app.copies_sold
        }
        
        print("------------------------------------")
        print("")
        print("Stats for store")
        print("")
        print("Store Profit: $ \(profit)")
        print("Total Copies Sold: \(copies_sold)")
        print("")
    }
    
    func get_dev_stats(dev:Developer)
    {
        print("------------------------------------")
        print("")
        print("Stats for developer with ID: \(dev.ID)")
        print("")
        print("Balance: $ \(dev.profit)")
        print("")
        
        var num_apps:Int = 0
        
        // Print stats for each app
        
        for app in apps
        {
            if(app.developer.ID == dev.ID)
            {
                num_apps++
                
                print("Stats for app: \(app.name)")
                print("")
                print("Price: $\(app.price)")
                print("Copies Sold: \(app.copies_sold)")
                print("Profit Earned: $\(app.income)")
                print("")
            }
        }
        
        // Or print this message if the dev has no apps in the store
        
        if(num_apps == 0)
        {
            print("Developer has no apps in the store.")
            print("")
        }
    }
}

/*:
#### App class
Data structure for the App's class
*/
class App{
    
    var developer:Developer
    var name:String = ""
    var price:Double = 1.25
    var copies_sold:Int = 0
    var income:Double = 0.0
    
    init(init_name:String, init_price:Double, init_dev:Developer)
    {
        name = init_name
        price = init_price
        developer = init_dev
    }
}

/*:
#### Developer class
Data structure for the Developer's class
*/
class Developer{
    
    var store:AppStore
    var ID:Int = -1
    var profit:Double = 0.0
    var apps = [App]()
    
    init(dev_ID: Int, dev_store: AppStore)
    {
        ID = dev_ID
        store = dev_store
    }
    
    func create_app(app_name:String, app_price:Double) -> App
    {
        var app = App(init_name: app_name, init_price: app_price, init_dev: self)
        apps.append(app)
        return app
    }
    
    func submit_app(app:App) -> String
    {
        var result = store.submit(app)
        
        if(result == true)
        {
            return "Approved!"
        }
        else
        {
            return "Denied."
        }
    }
    
    func transfer_app(app:App, dev:Developer)
    {
        app.developer = dev
    }
}



//: Create new app store

var store:AppStore = AppStore()



// Create developers

var dev1:Developer = store.new_dev()
var dev2:Developer = store.new_dev()
var dev3:Developer = store.new_dev()
var dev4:Developer = store.new_dev()



//: Create apps for each developer

dev1.create_app("My First App", app_price: 1.50)
dev2.create_app("My Cool App", app_price: 1.75)
dev2.create_app("My Even Cooler App", app_price: 1.99)
dev3.create_app("My Great App", app_price: 2.00)
dev3.create_app("My Even Greater App", app_price: 2.50)
dev3.create_app("My Greatest App", app_price: 2.75)
dev4.create_app("My Awesome App", app_price: 0.00)



//: Submit apps to app store

dev1.submit_app(dev1.apps[0])
dev2.submit_app(dev2.apps[0])
dev2.submit_app(dev2.apps[1])
dev3.submit_app(dev3.apps[0])
dev3.submit_app(dev3.apps[1])
dev3.submit_app(dev3.apps[2])
dev4.submit_app(dev4.apps[0])



//: Transfer some apps

dev1.transfer_app(dev1.apps[0], dev: dev2)
dev2.transfer_app(dev2.apps[0], dev: dev1)



//: Sell some apps

store.sell_apps()



// Get app store stats

store.get_store_stats()



//: Get developer profit and app copies sold

store.get_dev_stats(dev1)
store.get_dev_stats(dev2)
store.get_dev_stats(dev3)
store.get_dev_stats(dev4)


