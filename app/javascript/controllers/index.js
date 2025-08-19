// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application"

// Import individual controllers
import ReactComponentController from "./react_component_controller"

// Register controllers manually (safer for our setup)
application.register("react-component", ReactComponentController)

console.log('Stimulus controllers loaded successfully')
