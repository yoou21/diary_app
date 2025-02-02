import { Controller } from "@hotwired/stimulus"
import Chart from "chart.js/auto"

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.fetchData()
  }

  async fetchData() {
    try {
      const response = await fetch(this.urlValue)
      const data = await response.json()
      this.renderChart(data)
    } catch (error) {
      console.error("データ取得エラー:", error)
    }
  }

  renderChart(data) {
    const ctx = this.element.getContext("2d")
    new Chart(ctx, {
      type: 'line',
      data: {
        labels: data.map(entry => entry.date),
        datasets: [{
          label: '感情スコアの推移',
          data: data.map(entry => entry.score),
          borderColor: 'rgba(75, 192, 192, 1)',
          backgroundColor: 'rgba(75, 192, 192, 0.2)',
          tension: 0.4
        }]
      }
    })
  }
}
