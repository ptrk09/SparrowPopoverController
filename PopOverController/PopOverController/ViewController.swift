import UIKit

class ViewController: UIViewController {
    private let button: UIButton = Views.makeButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension ViewController {
    private enum Views {
        static func makeButton() -> UIButton {
            var configuration = UIButton.Configuration.plain()
            configuration.title = "Present"

            let button = UIButton(type: .system)
            button.configuration = configuration

            return button
        }
    }
}

extension ViewController {
    private func setupUI() {
        view.backgroundColor = .white
        setupButton()
    }

    private func setupButton() {
        button.addAction(UIAction { [weak self] _ in self?.didTapPresentButton() }, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

extension ViewController {
    private func didTapPresentButton() {
        let viewController = PopupController()
        viewController.modalPresentationStyle = .popover
        viewController.popoverPresentationController?.sourceView = button
        viewController.popoverPresentationController?.permittedArrowDirections = .up
        viewController.popoverPresentationController?.delegate = self
        present(viewController, animated: true, completion: nil)
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle {
        .none
    }
}
