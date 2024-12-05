import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  submit() {
    // セットされているTimeoutをクリアする
    clearTimeout(this.timeout)

    // Timeoutをセットする
    // 200ms後にリクエストを実行する
    // 連続で実行されるとTimeoutはクリアされるため、最後の処理だけしか実行されない
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 200)
  }
}