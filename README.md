# ReadingList
**ReadingList** is a sample application that shows how to create a Web Service Client and the corresponding model layer using [Mantle Modeling Framework](https://github.com/github/Mantle) and the [Overcoat](https://github.com/gonzalezreal/Overcoat) AFNetworking extension.
Specifically, ReadingList allows you to search for books in the **iBooks Store** and save them in a local database. It won't get an Apple Design Award, but it is a fairly complete real life example.

<img src="https://raw.github.com/gonzalezreal/ReadingList/master/Screenshots/screenshot-1.jpg" alt="Reading list" width="320" height="480" /><img src="https://raw.github.com/gonzalezreal/ReadingList/master/Screenshots/screenshot-2.jpg" alt="Book detail" width="320" height="480" /><img src="https://raw.github.com/gonzalezreal/ReadingList/master/Screenshots/screenshot-3.jpg" alt="Book search" width="320" height="480" />

## Installation
In order to build and run ReadingList, you must install first project dependencies via **CocoaPods**. To do so:
```
$ gem install cocoapods # If necessary
$ cd ReadingList
$ pod install
```
Once CocoaPods has finished the installation, open the generated ReadingList.xcworkspace using Xcode and run the sample.
## The Model
The best place to start understanding this sample is the `TGRBook` class, which models every property the that the application needs to know about a book.
`TGRBook` also implements `MTLJSONSerializing` and `MTLManagedObjectSerializing` to allow **JSON** and **Core Data** entity serialization respectively.
## The Web Service
ReadingList book search functionality is built around the [iTunes Search Web Service](http://www.apple.com/itunes/affiliates/resources/documentation/itunes-store-web-service-search-api.html).
`TGRBookCatalog` is the `OVCClient` subclass that implements this functionality with a few lines of code.
## Other Goodies
ReadingList uses some techniques and patterns that are worth mentioning:
* `TGRBookSearchController` shows how to separate search UI functionality from the View Controller.
* `TGRArrayDataSource` and `TGRFetchedResultsControllerDataSource` are reusable classes that implement `UITableView` data sources using `NSArray` and `NSFetchedResultsController` respectively.
* `TGRFetchedResultsTableViewController` is a reusable `UITableViewController` subclass that processes `NSFetchedResultsController` content changes the right way (based on code seen [here](http://www.fruitstandsoftware.com/blog/2013/02/uitableview-and-nsfetchedresultscontroller-updates-done-right/)).

## Contact
[Guillermo Gonzalez](http://github.com/gonzalezreal)  
[@gonzalezreal](https://twitter.com/gonzalezreal)
## License
ReadingList is available under the MIT license. See [LICENSE.md](https://github.com/gonzalezreal/ReadingList/blob/master/LICENSE).
