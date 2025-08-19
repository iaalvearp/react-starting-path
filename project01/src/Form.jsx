import { useState } from "react";

export const MantainmentForm = () => {
  const [text, setText] = useState(null);

  const changeSpan = (e) => {
    setText(`You have selected an ${e.target.value}`);
  };

  return (
    <>
      <form style={{ color: "white" }}>
        <label>
          Select an option:
          <select
            style={{ marginLeft: "16px", marginBottom: "16px" }}
            onChange={changeSpan}
          >
            <option value="option1">Option 1</option>
            <option value="option2">Option 2</option>
            <option value="option3">Option 3</option>
          </select>
        </label>
        <br />
        <span>{text}</span>
      </form>
    </>
  );
};
