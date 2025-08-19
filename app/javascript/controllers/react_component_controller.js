import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="react-component"
export default class extends Controller {
  static targets = ["container"]
  static values = { 
    component: String,
    props: Object
  }

  connect() {
    console.log('React component controller connected')
    this.renderReactComponent()
  }

  disconnect() {
    console.log('React component controller disconnected')
    if (this.reactRoot) {
      this.reactRoot.unmount()
    }
  }

  renderReactComponent() {
    const componentName = this.componentValue
    const props = this.propsValue || {}
    
    // Import the React component dynamically
    import(`../components/${componentName}`)
      .then((module) => {
        const Component = module.default
        
        // Create React root and render component
        this.reactRoot = window.ReactDOM.createRoot(this.containerTarget)
        this.reactRoot.render(window.React.createElement(Component, props))
      })
      .catch((error) => {
        console.error(`Error loading React component ${componentName}:`, error)
      })
  }

  // Method to update props and re-render
  updateProps(newProps) {
    this.propsValue = { ...this.propsValue, ...newProps }
    this.renderReactComponent()
  }
}
