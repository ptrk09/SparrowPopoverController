import UIKit

final class PopupController: UIViewController {
    private let closeButton: UIButton = Views.makeButton()
    private let segmentedControl: UISegmentedControl = Views.makeSegmentedControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension PopupController {
    private enum Views {
        static func makeButton() -> UIButton {
            UIButton(type: .close)
        }

        static func makeSegmentedControl() -> UISegmentedControl {
            let segmentedControl = UISegmentedControl(items: ["280pt", "150pt"])
            segmentedControl.selectedSegmentIndex = 0
            return segmentedControl
        }
    }
}

extension PopupController {
    private func setupUI() {
        view.backgroundColor = .white
        setupButton()
        setupSegmentedCotrol()
        calculateAndApplyHeight()
    }

    private func setupButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addAction(UIAction { [weak self] _ in self?.didTapCloseButton() }, for: .touchUpInside)
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }

    private func setupSegmentedCotrol() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addAction(UIAction { [weak self] _ in self?.didChangeSegment() }, for: .allEvents)
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
        ])
    }
}

extension PopupController {
    private func didTapCloseButton() {
        dismiss(animated: true)
    }

    private func didChangeSegment() {
        calculateAndApplyHeight()
    }

    private func calculateAndApplyHeight() {
        let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        let newHeight = selectedSegmentIndex == 0 ? 280 : 150
        preferredContentSize = CGSize(width: 300, height: newHeight)
    }
}

