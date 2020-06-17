//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    private lazy var firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Some text"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)

        return label
    }()

    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Some text"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var longLabel: UILabel = {
        let label = UILabel()
        label.text = Array(repeating: "Some text", count: 50).joined(separator: "-")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.firstView)
        self.view.addSubview(self.secondView)

         self.firstView.addSubview(self.firstLabel)
         self.secondView.addSubview(self.secondLabel)

        self.view.addSubview(self.longLabel)

        self.setupConstraints()
        self.setupConstraintsWithAnchors()
    }

    // first step
    private func setupConstraints() {
        self.view.addConstraints([
            NSLayoutConstraint(
                item: self.firstView,
                attribute: .top,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .top,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(
                item: self.firstView,
                attribute: .left,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .left,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(
                item: self.firstView,
                attribute: .right,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .right,
                multiplier: 1,
                constant: 0),
//            NSLayoutConstraint(
//                item: self.firstView,
//                attribute: .height,
//                relatedBy: .equal,
//                toItem: nil,
//                attribute: .notAnAttribute,
//                multiplier: 1,
//                constant: 200)
        ])
    }

    // second step
    private func setupConstraintsWithAnchors() {
        NSLayoutConstraint.activate([
            self.secondView.topAnchor.constraint(equalTo: self.firstView.bottomAnchor),
            self.secondView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.secondView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            // self.secondView.heightAnchor.constraint(equalToConstant: 500)
            // self.secondView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        // first label
        NSLayoutConstraint.activate([
            self.firstLabel.topAnchor.constraint(equalTo: self.firstView.topAnchor, constant: 20),
            self.firstLabel.leftAnchor.constraint(equalTo: self.firstView.leftAnchor, constant: 20),
            self.firstLabel.rightAnchor.constraint(equalTo: self.firstView.rightAnchor, constant: -20),
            self.firstLabel.bottomAnchor.constraint(equalTo: self.firstView.bottomAnchor, constant: -20)
        ])

        // second label
        NSLayoutConstraint.activate([
            self.secondLabel.topAnchor.constraint(equalTo: self.secondView.topAnchor, constant: 20),
            self.secondLabel.leftAnchor.constraint(equalTo: self.secondView.leftAnchor, constant: 20),
            self.secondLabel.rightAnchor.constraint(equalTo: self.secondView.rightAnchor, constant: -20),
            self.secondLabel.bottomAnchor.constraint(equalTo: self.secondView.bottomAnchor, constant: -20)
        ])

        // long label
        self.longLabel.topAnchor.constraint(equalTo: self.secondView.bottomAnchor).isActive = true
        self.longLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.longLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.longLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
