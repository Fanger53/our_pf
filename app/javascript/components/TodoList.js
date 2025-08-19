import React, { useState } from 'react'

const TodoList = ({ initialTodos = [] }) => {
  const [todos, setTodos] = useState(initialTodos)
  const [newTodo, setNewTodo] = useState('')
  const [filter, setFilter] = useState('all') // all, completed, pending

  const addTodo = () => {
    if (newTodo.trim()) {
      const todo = {
        id: Date.now(),
        text: newTodo.trim(),
        completed: false,
        createdAt: new Date().toLocaleString()
      }
      setTodos([...todos, todo])
      setNewTodo('')
    }
  }

  const toggleTodo = (id) => {
    setTodos(todos.map(todo => 
      todo.id === id ? { ...todo, completed: !todo.completed } : todo
    ))
  }

  const deleteTodo = (id) => {
    setTodos(todos.filter(todo => todo.id !== id))
  }

  const clearCompleted = () => {
    setTodos(todos.filter(todo => !todo.completed))
  }

  const filteredTodos = todos.filter(todo => {
    if (filter === 'completed') return todo.completed
    if (filter === 'pending') return !todo.completed
    return true
  })

  const completedCount = todos.filter(todo => todo.completed).length
  const pendingCount = todos.length - completedCount

  return (
    <div className="max-w-2xl mx-auto bg-white rounded-lg shadow-lg overflow-hidden">
      {/* Header */}
      <div className="bg-gradient-to-r from-indigo-500 to-purple-600 p-6 text-white">
        <h2 className="text-2xl font-bold mb-2">Lista de Tareas Interactiva</h2>
        <p className="text-indigo-100">
          Gestiona tus tareas con este componente React integrado con Stimulus
        </p>
      </div>

      {/* Add Todo Form */}
      <div className="p-6 border-b border-gray-200">
        <div className="flex gap-3">
          <input
            type="text"
            value={newTodo}
            onChange={(e) => setNewTodo(e.target.value)}
            onKeyPress={(e) => e.key === 'Enter' && addTodo()}
            placeholder="¿Qué necesitas hacer?"
            className="flex-1 px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent outline-none"
          />
          <button
            onClick={addTodo}
            className="px-6 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition-colors duration-200 font-medium"
          >
            Agregar
          </button>
        </div>
      </div>

      {/* Stats */}
      <div className="p-4 bg-gray-50 border-b border-gray-200">
        <div className="flex justify-between items-center text-sm">
          <div className="flex gap-6">
            <span className="text-gray-600">
              Total: <span className="font-semibold text-gray-900">{todos.length}</span>
            </span>
            <span className="text-green-600">
              Completadas: <span className="font-semibold">{completedCount}</span>
            </span>
            <span className="text-orange-600">
              Pendientes: <span className="font-semibold">{pendingCount}</span>
            </span>
          </div>
          {completedCount > 0 && (
            <button
              onClick={clearCompleted}
              className="text-red-600 hover:text-red-700 text-sm font-medium"
            >
              Limpiar completadas
            </button>
          )}
        </div>
      </div>

      {/* Filter Buttons */}
      <div className="p-4 border-b border-gray-200">
        <div className="flex gap-2">
          {[
            { key: 'all', label: 'Todas' },
            { key: 'pending', label: 'Pendientes' },
            { key: 'completed', label: 'Completadas' }
          ].map(({ key, label }) => (
            <button
              key={key}
              onClick={() => setFilter(key)}
              className={`px-4 py-2 rounded-md text-sm font-medium transition-colors duration-200 ${ 
                filter === key 
                  ? 'bg-indigo-600 text-white' 
                  : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
              }`}
            >
              {label}
            </button>
          ))}
        </div>
      </div>

      {/* Todo List */}
      <div className="max-h-96 overflow-y-auto">
        {filteredTodos.length === 0 ? (
          <div className="p-8 text-center text-gray-500">
            <i className="fas fa-tasks text-4xl mb-3 text-gray-300"></i>
            <p className="text-lg font-medium">
              {filter === 'all' ? 'No hay tareas aún' : 
               filter === 'completed' ? 'No hay tareas completadas' : 
               'No hay tareas pendientes'}
            </p>
            <p className="text-sm mt-1">
              {filter === 'all' ? '¡Agrega tu primera tarea!' : ''}
            </p>
          </div>
        ) : (
          <div className="divide-y divide-gray-200">
            {filteredTodos.map(todo => (
              <div
                key={todo.id}
                className={`p-4 flex items-center gap-3 hover:bg-gray-50 transition-colors duration-200 ${
                  todo.completed ? 'bg-gray-50' : ''
                }`}
              >
                <button
                  onClick={() => toggleTodo(todo.id)}
                  className={`w-5 h-5 rounded border-2 flex items-center justify-center transition-colors duration-200 ${
                    todo.completed 
                      ? 'bg-green-500 border-green-500 text-white' 
                      : 'border-gray-300 hover:border-green-400'
                  }`}
                >
                  {todo.completed && <i className="fas fa-check text-xs"></i>}
                </button>
                
                <div className="flex-1">
                  <p className={`${todo.completed ? 'line-through text-gray-500' : 'text-gray-900'} font-medium`}>
                    {todo.text}
                  </p>
                  <p className="text-xs text-gray-400 mt-1">
                    Creada: {todo.createdAt}
                  </p>
                </div>
                
                <button
                  onClick={() => deleteTodo(todo.id)}
                  className="text-red-500 hover:text-red-700 p-1 transition-colors duration-200"
                >
                  <i className="fas fa-trash text-sm"></i>
                </button>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}

export default TodoList
