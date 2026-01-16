import { useEffect, useState } from "react";
import reactLogo from "./assets/react.svg";
import viteLogo from "/vite.svg";
import { Form, ListUsers } from "./components";
import { getAllUsers } from "./api";
import "./App.css";

function App() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    const fetchUsers = async () => {
      const response = await getAllUsers();
      setUsers(response.users);
    };

    fetchUsers();
  }, []);

  return (
    <>
      <div>
        <a href="https://vite.dev" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Mini Fullstack App for DevOps Project</h1>

      <div className="grid">
        {/* Form component */}
        <Form setUsers={setUsers} />

        {/*FetchUsers component */}
        <div>
          <ListUsers users={users} />
        </div>
      </div>
    </>
  );
}

export default App;
