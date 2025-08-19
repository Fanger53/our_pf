// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers"

// Import React and React DOM
import React from 'react'
import { createRoot } from 'react-dom/client'

// Make React available globally for Stimulus controllers
window.React = React
window.ReactDOM = { createRoot }

console.log('Application JavaScript loaded with React integration')
