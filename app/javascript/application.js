// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import Rails from "@rails/ujs" // ここでimportします
import "./controllers"

Rails.start() // Rails UJSを有効化
