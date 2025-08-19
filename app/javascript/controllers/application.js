import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = process.env.NODE_ENV === 'development'
window.Stimulus = application

// Handle Stimulus registration errors gracefully
application.handleError = (error, message, detail) => {
  console.warn(`Stimulus error: ${message}`, error, detail)
}

export { application }
