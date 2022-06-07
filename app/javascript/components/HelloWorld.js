import React, { useCallback, useState } from "react"

const HelloWorld = ({
  props
}) => {
  const [propsState, setProps] = useState(props);
  console.log(props)

  const handleChangeProps = useCallback((str) => {
    setProps(str)
    }, [setProps]
  )

  return (
    <React.Fragment>
      <p>Greeting: {propsState}</p>
    </React.Fragment>
  )
};

export default HelloWorld;