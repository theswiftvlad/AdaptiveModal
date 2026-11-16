# AdaptiveModal-Demo

<div align="center">
  <img src="https://img.shields.io/badge/iOS-15.0%2B-blue" alt="iOS 15.0+"/>
  <img src="https://img.shields.io/badge/Swift-5.9%2B-orange" alt="Swift 5.9+"/>
  <img src="https://img.shields.io/badge/Dependencies-None-green" alt="No Dependencies"/>
  <img src="https://img.shields.io/badge/License-MIT-lightgrey" alt="MIT License"/>
  <br><br>

  <img src="AdaptiveModal-Demo/Assets/demo.gif"
       width="500"
       style="border-radius: 10px"
       alt="Modal Demo Animation"/>

  <p>An adaptive modal sheet for UIKit that sizes itself to its content and animates smoothly between screens — built on <code>UIPresentationController</code>.</p>
</div>

## Features

- **Sizes to content.** The modal measures its content with Auto Layout and resizes as you push and pop screens.
- **Navigation inside the modal.** Push and pop within a `UINavigationController` with scale-and-fade transitions.
- **Bottom or center placement**, configurable corner radius and background color.
- **Dismiss your way:** tap outside the modal, or show an optional close button.
- **No dependencies.** One file, plain UIKit.

## Installation

Copy [`AdaptiveModalPresentationController.swift`](AdaptiveModal-Demo/AdaptiveModalPresentationController.swift) into your project.

## Usage

### Present a modal

```swift
// Keep a strong reference: transitioningDelegate is weak
let transitionDelegate = AdaptiveModalTransitioningDelegate(configuration: .default)

func presentModal() {
    let navigationController = UINavigationController(rootViewController: YourViewController())
    navigationController.modalPresentationStyle = .custom
    navigationController.transitioningDelegate = transitionDelegate
    present(navigationController, animated: true)
}
```

### Customize appearance

```swift
let configuration = AdaptiveModalConfiguration(
    showDismissButton: true,
    cornerRadius: 36,
    backgroundColor: .systemBackground,
    dismissWhenTouchOutside: true,
    placement: .bottom // or .center
)

let transitionDelegate = AdaptiveModalTransitioningDelegate(configuration: configuration)
```

### Animate push and pop inside the modal

Set your object as the navigation controller's delegate and return `TransitionAnimator`:

```swift
navigationController.delegate = self

extension ViewController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push: return TransitionAnimator(type: .present)
        default: return TransitionAnimator(type: .dismiss)
        }
    }
}
```

## How it works

- `AdaptiveModalPresentationController` (a `UIPresentationController` subclass) adds the dimming view and computes the modal frame from the content's `systemLayoutSizeFitting`.
- `AdaptiveModalTransitioningDelegate` hands that presentation controller to UIKit.
- `TransitionAnimator` (`UIViewControllerAnimatedTransitioning`) cross-fades snapshots of both screens while the container animates to the new height.

## Requirements

- iOS 15.0+ for the component (the demo app targets iOS 18.2)
- Swift 5.9+
- Xcode 16+ to open the demo project

## Author

Vlad Tretiak, [LinkedIn](https://www.linkedin.com/in/theswiftvlad) · [GitHub](https://github.com/theswiftvlad)

## License

MIT. See [LICENSE](LICENSE).
