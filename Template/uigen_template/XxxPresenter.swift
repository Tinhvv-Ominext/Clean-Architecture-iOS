//
//  XxxPresenter.swift
//  Drjoy

// <functionname>
class XxxPresenter: Presenter {
    typealias T = XxxView

    var view: XxxView?

    func attachView(_ view: XxxView) {
        self.view = view
    }

    func detachView() {
        self.view = nil
    }

}
