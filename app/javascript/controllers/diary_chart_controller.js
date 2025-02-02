import { Controller } from "@hotwired/stimulus";
import Chart from "chart.js/auto";  // Esbuild でバンドル

export default class extends Controller {
  static targets = ["lineChart", "pieChart"];

  async connect() {
    console.log("📊 DiaryChartController Loaded!");
    window.Chart = Chart; // 追加
    console.log("✅ Chart.js:", Chart);

    await this.renderLineChart();
    await this.renderPieChart.bind(this)();  // `bind(this)` を追加
  }

  async fetchDiaryEntries() {
    try {
      const response = await fetch("/api/diary_entries");
      if (!response.ok) throw new Error(`HTTP error! Status: ${response.status}`);
      const data = await response.json();
      console.log("✅ fetchDiaryEntries データ:", data);
      return data;
    } catch (error) {
      console.error("❌ fetchDiaryEntries エラー:", error);
      return [];
    }
  }

  async fetchEmotionSummary() {
    try {
      const response = await fetch("/api/diary_entries/emotion_summary");
      if (!response.ok) throw new Error(`HTTP error! Status: ${response.status}`);
      const data = await response.json();
      console.log("✅ fetchEmotionSummary データ:", data);
      return data;
    } catch (error) {
      console.error("❌ fetchEmotionSummary エラー:", error);
      return {};
    }
  }

  async renderLineChart() {
    const diaryEntries = await this.fetchDiaryEntries();
    const labels = diaryEntries.map(entry => entry.date);
    const data = diaryEntries.map(entry => entry.emotion_score);

    console.log("📅 ラインチャートのラベル:", labels);
    console.log("🎭 ラインチャートのデータ:", data);

    if (!this.lineChartTarget) {
      console.error("❌ LineChart の `canvas` が見つかりません");
      return;
    }

    try {
      new Chart(this.lineChartTarget, {
        type: "line",
        data: {
          labels: labels,
          datasets: [{
            label: "感情スコアの推移",
            data: data,
            borderColor: "blue",
            backgroundColor: "rgba(0, 0, 255, 0.2)", // 軽い背景色
            fill: false,  // ← カンマを追加
            tension: 0.3  // 線を滑らかにする
          }]
        },
        options: { responsive: true }
      });
    } catch (error) {
      console.error("❌ Chart.js ラインチャート エラー:", error);
    }
  }

  async renderPieChart() {
    const summary = await this.fetchEmotionSummary();
    const labels = Object.keys(summary);
    const data = Object.values(summary);

    console.log("🥧 パイチャートのラベル:", labels);
    console.log("📊 パイチャートのデータ:", data);

    if (!this.pieChartTarget) {
      console.error("❌ PieChart の `canvas` が見つかりません");
      return;
    }

    try {
      new Chart(this.pieChartTarget, {
        type: "pie",
        data: {
          labels: labels,
          datasets: [{
            label: "感情の割合",
            data: data,
            backgroundColor: ["blue", "red", "gray"]
          }]
        },
        options: { responsive: true }
      });
    } catch (error) {
      console.error("❌ Chart.js パイチャート エラー:", error);
    }
  }
}
