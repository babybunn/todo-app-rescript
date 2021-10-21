@react.component
let make = () => {
  let (status, setStatus) = React.useState(_ => Form.All)
  <div> <Form setStatus /> <TodoList status /> </div>
}
