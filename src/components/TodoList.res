type todo = {
  id: int,
  text: string,
  completed: bool,
}

type action =
  | AddTodo(string)
  | RemoveTodo(int)
  | ToggleTodo(int)

type state = {
  todos: array<todo>,
  nextId: int,
}

type status_t =
  | All
  | Completed
  | Incompleted

let initialTodos = [
  {id: 1, text: "Try ReScript & React", completed: false},
  {id: 2, text: "Crypto 101", completed: false},
  {id: 3, text: "Band 101", completed: true},
]

let reducer = (state, action) => {
  switch action {
  | AddTodo(text) =>
    let todos = Js.Array2.concat(state.todos, [{id: state.nextId, text: text, completed: false}])
    {todos: todos, nextId: state.nextId + 1}
  | RemoveTodo(id) =>
    let todos = Js.Array2.filter(state.todos, todo => todo.id !== id)
    {...state, todos: todos}
  | ToggleTodo(id) =>
    let todos = Belt.Array.map(state.todos, todo =>
      if todo.id === id {
        {
          ...todo,
          completed: !todo.completed,
        }
      } else {
        todo
      }
    )
    {...state, todos: todos}
  }
}

@react.component
let make = (~status) => {
  let (state, dispatch) = React.useReducer(reducer, {todos: initialTodos, nextId: 4})

  let todos = Belt.Array.mapWithIndex(state.todos, (ind, todo) => {
    let liClassName = todo.completed ? "todo-item completed" : "todo-item"

    <li className={liClassName} key={Belt.Int.toString(ind)}>
      <div className="todo-inner">
        <span className="todo-txt"> {React.string(todo.text)} </span>
        <div className="actions">
          <button className="btn-complete" onClick={_ => dispatch(ToggleTodo(todo.id))}>
            {todo.completed ? "Incomplete"->React.string : "Complete"->React.string}
          </button>
          <button className="btn-delete" onClick={_ => dispatch(RemoveTodo(todo.id))}>
            {"Delete"->React.string}
          </button>
        </div>
      </div>
    </li>
  })

  <div className="todo-wrapper"> <ul className="todo-list"> {React.array(todos)} </ul> </div>
}
