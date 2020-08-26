//
//  XxxVC.swift
//  Drjoy

// <functionname>
class XxxVC: BaseVC, XxxView {

    var presenter: XxxPresenter!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.attachView(self)
    }

    override func viewDidDisappear(_ animated: Bool) {
        presenter.detachView()
        super.viewDidDisappear(animated)
    }


}
