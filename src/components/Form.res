type status_t =
  | All
  | Completed
  | Incompleted

let toString = status => {
  switch status {
  | All => "all"
  | Completed => "completed"
  | Incompleted => "incompleted"
  }
}

@react.component
let make = (~setStatus) => {
  let filterOptions = [All, Completed, Incompleted]

  let (inputText, setInputText) = React.useState(_ => "")

  let inputTextHandler = e => {
    let value = ReactEvent.Form.target(e)["value"]
    setInputText(_prev => value)
  }

  let filterHandler = e => {
    let value = ReactEvent.Form.target(e)["value"]
    // Js.log(value)
    setStatus(value)
  }

  let onSubmit = e => {
    ReactEvent.Form.preventDefault(e)
    Js.log("Hello this is a log!")
    // setInputText()
  }

  <div className="form-wrapper">
    <form onSubmit>
      <input type_="text" value={inputText} onChange={inputTextHandler} />
      <button type_="submit"> {React.string("Add")} </button>
    </form>
    <ul className="filters">
      <li className="filter-item"> <strong> {React.string("Selected Filter:")} </strong> </li>
      {Belt.Array.mapWithIndex(filterOptions, (i, filter) =>
        <li className="filter-item" key={Belt.Int.toString(i)}>
          <input
            type_="radio"
            name="filter"
            value={filter->toString}
            id={`input_filter_${filter->toString}`}
            onChange={filterHandler}
          />
          <label htmlFor={`input_filter_${filter->toString}`}>
            {React.string(filter->toString)}
          </label>
        </li>
      )->React.array}
    </ul>
  </div>
}
