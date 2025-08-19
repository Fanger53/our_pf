// Import and register all your controllers

import { application } from "./application"

// Import individual controllers
import ReactComponentController from "./react_component_controller"

// Register controllers
application.register("react-component", ReactComponentController)

console.log('Stimulus controllers loaded')
