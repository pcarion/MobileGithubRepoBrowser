# MobileGithubRepoBrowser / ios native
sample app to browse a Github repo, in ios Native with Swift

| iPhone        | iPad |
| ------------- |-------- |
| ![Browser App on iPhone](https://github.com/pcarion/MobileGithubRepoBrowser/blob/master/iosNative/MobileGithubRepoBrowser/docs/ios-native-iphone.gif?raw=true) | ![Browser App on iPad](https://github.com/pcarion/MobileGithubRepoBrowser/blob/master/iosNative/MobileGithubRepoBrowser/docs/ios-native-ipad.gif?raw=true) |


# Development notes

## Implementation details

### Scrolling Views
Both the `GithubUserSelection` and `GithubUserInformation` views are scrolling views.

In order for the scroll to _actually_ works, you need to be careful when you setup your auto layout constraints in the storyboard:
* you need to add first your `UIScrollView` , to its *containing view* and set its constraints `Align [leading|trainling|top|bottom]` to `0` with regards to the `Safe Area`
* you need then to add a `UIView` as a child of your scroll view and rename it to something to content view as it is is the view which will actually holds the content of the scrolling view
* you need to also set the constraints of that content view: 
  *  `Align [leading|trainling|top|bottom]` to `0` with regards to the `Super View`
  *  `Equal width` to `Safe Area`
  *  `Equal height` to the *containg view* , with a lower priority of `250`
  
  This last step may be confusing but is required for the height of the view to *adapt* with regards to all the components added in the content view
  
  Finally, when you add components to the content view, ensure that there are no ambiguities in terms of Y positioning:
  * set the constraints with regard to the previous component
  * set the height constraints
  * set a bottom constraints for the last component of the page (important!)
  
  
### TableView , cell class customization
If you want to have the cells allocated by the storyboard, you need to register a class and an identifier, for instance in the  `viewDidLoad` of the VC containing the teble view:

```
tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
```

with that, you will get an instance of UITableViewCell when you ask for a reusable cell:
```
let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
```

You can also, using the `Prototype Cells` property of a TableView in the storyboad, implement your own custom view.
This view must inherit from `UITableViewCell` and you also need to make sure that you the same `Identifier` as the one you will be using in the call to `dequeueReusableCell`

Finally, if you want to have more programmatic control of the cell creations, while still using the reusable queue, you can create the view manually:

```
var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
if cell == nil {
 cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
}

```
I did that in the `GithubRepoList` view in order to set the style `value` to display the `detailText` label.

    
