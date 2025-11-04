// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/**
* @title Decentralized To-Do List
* @notice A blockchain-based task manager that lets users add, complete, and
delete tasks.
* @dev No Ether or wallet required — runs 100% inside Remix’s JavaScript VM.
* @custom:dev-run-script ToDoList.sol
*
* Steps to run in Remix:
* 1. Open https://remix.ethereum.org
* 2. Create a new file named `DecentralizedToDoList.sol`
* 3. Paste this code and compile with Solidity 0.8.0 or newer.
* 4. Deploy using **JavaScript VM** (no constructor inputs required).
* 5. Call `addTask("Buy groceries")`
* 6. Call `addTask("Complete blockchain project")`
* 7. Call `getTasks()` → shows both tasks and completion status.
* 8. Call `toggleTask(0)` → marks first task as complete/incomplete.
* 9. Call `deleteTask(1)` → removes second task.
* 10. Call `getTasks()` again → verify task list updated correctly.
*/

contract ToDoList {
    struct Task {
        string description;
        bool completed;
    }
    Task[] private tasks;
    /// @notice Add a new task to the list.
    /// @param _description The text description of the task.
    function addTask(string memory _description) public {
        tasks.push(Task(_description, false));
    }
    /// @notice Toggle completion status of a task.
    /// @param _index Index of the task to toggle.
    function toggleTask(uint256 _index) public {
        require(_index < tasks.length, "Invalid task index");
        tasks[_index].completed = !tasks[_index].completed;
    }
    /// @notice Delete a task by its index.
    /// @param _index Index of the task to delete.
    function deleteTask(uint256 _index) public {
        require(_index < tasks.length, "Invalid task index");
        tasks[_index] = tasks[tasks.length - 1];
        tasks.pop();
    }
    /// @notice Get the full list of tasks.
    /// @return Array of all tasks with their descriptions and status.
    function getTasks() public view returns (Task[] memory) {
        return tasks;
    }
    /// @notice Get the total number of tasks.
    /// @return The count of tasks currently stored.
    function getTaskCount() public view returns (uint256) {
        return tasks.length;
    }
}
