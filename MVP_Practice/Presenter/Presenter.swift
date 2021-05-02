import Foundation

protocol PresentInput {
    func textDidChange(leftText: String, rightText: String)
    func resultButtonOnTap(leftText: String, rightText: String)
}

protocol PresentOutput {
    func changeResultButtonEnable(isEnable: Bool)
    func setResultLabel(text: String)
    func showErrorAlert(title: String, message: String) 
}

class Presenter: PresentInput {
    let view: PresentOutput
    let model: ModelInput

    init(view: PresentOutput, model: ModelInput) {
        self.view  = view
        self.model = model
    }
    //Viewからのinputを受けてtextDidChangeというinterfaceを通じてchangeResultButtonEnableというoutputをしている
    func textDidChange(leftText: String, rightText: String) {
        if leftText.isEmpty || rightText.isEmpty {
            //未入力あり
            //outputの処理
            view.changeResultButtonEnable(isEnable: false)
        } else {
            //入力完了
            //outputの処理
            view.changeResultButtonEnable(isEnable: true)
        }
    }
    //Viewからのinputを受けてresultButtonOnTapというinterfaceを通じてoutputをしている
    func resultButtonOnTap(leftText: String, rightText: String) {
        guard let leftNumber = Float(leftText), let rightNumber = Float(rightText) else {
            view.showErrorAlert(title: "エラー", message: "数字を入れてください")
            return
        }
        view.setResultLabel(text: String(format: "%.1f", model.multiply(leftNumber, rightNumber)))
    }
}
