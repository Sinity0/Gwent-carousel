![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)

# Gwent-carousel
A simple to use, carousel similar to the carousel in Gwent game.

![Step1](/Screenshots/Carousel.gif)

## Instructions
Initialization:

```swift
var carousel: PMGwentCarousel?
```
Next card:

```swift
carousel?.showNextCard(frameType: getFrameType(named: frameRef), imageURL: url!, cardText: pcs!)
```

Previous card:
```swift
carousel?.showPreviousCard(frameType: getFrameType(named: frameRef), imageURL: url!, cardText: pcs!)
```
