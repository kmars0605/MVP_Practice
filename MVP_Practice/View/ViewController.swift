import UIKit

class ViewController: UIViewController {
    var presenter: Presenter!

    var leftValueTextField: UITextField!
    var rightValueTextField: UITextField!
    var resultButton: UIButton!
    var resultLabel: UILabel!

    func inject(presenter: Presenter) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let width = view.frame.width
        leftValueTextField = UITextField()
        leftValueTextField.accessibilityIdentifier = "leftValueTextField"
        leftValueTextField.frame = CGRect(x: width * 0.05, y: 200, width: width * 0.4, height: 60)
        leftValueTextField.layer.borderWidth = 1
        leftValueTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        leftValueTextField.textAlignment = .center
        leftValueTextField.keyboardType = .numberPad
        view.addSubview(leftValueTextField)

        rightValueTextField = UITextField()
        rightValueTextField.accessibilityIdentifier = "rightValueTextField"
        rightValueTextField.frame = CGRect(x: width * 0.55, y: 200, width: width * 0.4, height: 60)
        rightValueTextField.layer.borderWidth = 1
        rightValueTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        rightValueTextField.textAlignment = .center
        rightValueTextField.keyboardType = .numberPad
        view.addSubview(rightValueTextField)

        resultButton = UIButton()
        resultButton.accessibilityIdentifier = "resultButton"
        resultButton.frame = CGRect(x: width * 0.2, y: 300, width: width * 0.6, height: 60)
        resultButton.setTitle("=", for: .normal)
        resultButton.setTitleColor(.black, for: .normal)
        resultButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 38)
        resultButton.isEnabled = false
        resultButton.layer.borderWidth = 1
        resultButton.addTarget(self, action: #selector(resultButtonOnTap), for: .touchDown)
        view.addSubview(resultButton)

        resultLabel = UILabel()
        resultLabel.accessibilityIdentifier = "resultLabel"
        resultLabel.frame = CGRect(x: width * 0.2, y: 400, width: width * 0.6, height: 60)
        resultLabel.textAlignment = .center
        view.addSubview(resultLabel)
    }
}

extension ViewController {
    //入力があったら呼ばれる
    @objc func textFieldDidChange() {
        guard let leftText = leftValueTextField.text, let rightText = rightValueTextField.text else { return }
        presenter.textDidChange(leftText: leftText, rightText: rightText)
    }
    @objc func resultButtonOnTap() {
        guard let leftText = leftValueTextField.text, let rightText = rightValueTextField.text else { return }
        presenter.resultButtonOnTap(leftText: leftText, rightText: rightText)
    }
}

extension ViewController: PresentOutput {
    func changeResultButtonEnable(isEnable: Bool) {
        resultButton.isEnabled = isEnable
    }

    func setResultLabel(text: String) {
        resultLabel.text = text
    }

    func showErrorAlert(title: String, message: String) {
        let actionAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "閉じる", style: UIAlertAction.Style.cancel, handler: nil)
        actionAlert.addAction(cancelAction)
        self.present(actionAlert, animated: true, completion: nil)
    }
}

