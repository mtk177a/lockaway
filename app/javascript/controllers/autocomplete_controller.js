import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "results"];

  connect() {
    this.inputTarget.addEventListener("input", this.updateHabitList.bind(this));
  }

  async updateHabitList() {
    const query = this.inputTarget.value;
    if (query.length === 0) {
      return; // 入力が空の場合、何もしない
    }

    try {
      const response = await fetch(`${this.data.get("autocompleteUrlValue")}?q=${encodeURIComponent(query)}`, {
        headers: { Accept: "text/vnd.turbo-stream.html" },
      });

      if (response.ok) {
        const turboStream = await response.text();
        document.body.insertAdjacentHTML("beforeend", turboStream); // Turbo Stream を適用
      }
    } catch (error) {
      console.error("Habit list update failed:", error);
    }
  }
}
