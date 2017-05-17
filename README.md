# Miva
A Swift Download Library
=====

Miva is a networking image library that fetches, caches, and displays images, JSON, files via HTTP in Swift.

## Features

- In-memory caching.
- Nonblocking IO. All HTTP and disk IO happen in the background.
- Completely Generic.
- Simple one method UIImageView to load a remote image.
- Robust, fast, and customizable.
- Simple concise codebase.
- handles redundant image requests, so only one request is sent for multiple queries

Full article here: [Vluxe](http://vluxe.io/skeets.html)

## Example

First thing is to import the framework.

```swift
import Miva
```

Once imported, you can start requesting images.

```swift
//you can simply call the URL string on your UIImageView
let imageUrl = "https://assets-cdn.github.com/images/modules/logos_page/GitHub-Mark.png"
let imageView = UIImageView(frame: CGRectMake(0, 60, 200, 200))
self.imageView.setImage(url: imageUrl)

//fetch the image using the image manager
MivaImageManager.shared.fetch(url: url,
  progress: { (part) in
    //update your progress bars
  }, success: { (image) in
    //use your image
  }, failure: { (error) in
    //handle the error
  })
```

## Downloading JSON using Miva
Take advantage of the Generic nature of the library
```swift
MivaRequest<JSON>(path: "https://pastebin.com/raw/wgkJgazE",
    progress: { (part) in
        //update your progress bars
    }, success: { (json) in
        //use your json
    }, failure: { (error) in
        //handle the error
})
```

## Cancel Request
Fetch requests can be cancelled when needed. This simply causes the closures not to be called.
```swift
request.cancel()
```

## Requirements

Skeets requires at least iOS 8 or above.

## License

Miva is licensed under MIT Open source license.

## Contact

### Furqan Muhammad Khan
* https://github.com/furqanmk
* http://twitter.com/furqanmk9
* http://facebook.com/furqanmk9
* http://behance.net/furqanmk

