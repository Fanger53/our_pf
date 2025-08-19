import React, { useState } from 'react'

const Counter = ({ initialValue = 0, title = "Contador React" }) => {
  const [count, setCount] = useState(initialValue)

  const increment = () => setCount(count + 1)
  const decrement = () => setCount(count - 1)
  const reset = () => setCount(initialValue)

  return (
    <div className="bg-white rounded-lg shadow-lg p-6 max-w-md mx-auto">
      <h3 className="text-xl font-bold text-gray-800 mb-4 text-center">
        {title}
      </h3>
      
      <div className="text-center mb-6">
        <span className="text-4xl font-bold text-blue-600">
          {count}
        </span>
      </div>
      
      <div className="flex gap-3 justify-center">
        <button
          onClick={decrement}
          className="bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-4 rounded-lg transition-colors duration-200"
        >
          -
        </button>
        
        <button
          onClick={reset}
          className="bg-gray-500 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded-lg transition-colors duration-200"
        >
          Reset
        </button>
        
        <button
          onClick={increment}
          className="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded-lg transition-colors duration-200"
        >
          +
        </button>
      </div>
      
      <div className="mt-4 text-center text-sm text-gray-600">
        <p>Componente React renderizado con Stimulus</p>
      </div>
    </div>
  )
}

export default Counter
