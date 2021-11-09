# PhotoRoomAPIExample

For the exercise, I choose SwiftUI 😅

## Architecture
MVVM with some Services to remove background

### Storage (not implemented)
The `Cache` class is used as a Cache of any Codable object.
The VM will call ImagesRepository to store and display Cached images

### Network
A network layer is used for `SegmentationService`
Using protocols is better for abstraction and mocking

## How the app works
We choose images from the Library and Blue Button is updated in consequence.

## Not implemented
A `LazyVGrid` for cached processed image
