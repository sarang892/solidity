// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/**
* @title Decentralized Library Management System
* @notice A simple blockchain-based system for adding, borrowing, and
returning books.
* @dev Works entirely in Remix JS VM — no Ether or MetaMask required.
* @custom:dev-run-script LibrarySystem.sol
*
* Steps to run in Remix:
* 1. Open https://remix.ethereum.org
* 2. Create a file `DecentralizedLibrarySystem.sol`
* 3. Paste this code, compile (Solidity ^0.8.0)
* 4. Deploy in **JavaScript VM** (no constructor inputs needed)
* 5. Call `addBook("The Great Gatsby")`
* 6. Call `addBook("1984")`
* 7. Call `getBooks()` → shows both books and availability.
* 8. Call `borrowBook(0)` → marks the first book as borrowed.
* 9. Call `getBooks()` → verify book 0 is now unavailable.
* 10. Call `returnBook(0)` → returns the borrowed book.
* 11. Call `getBooks()` again → availability restored.
*/

contract LibrarySystem {
    struct Book {
        string title;
        bool isAvailable;
    }
    Book[] private books;
    /// @notice Add a new book to the library.
    /// @param _title The title of the book.
    function addBook(string memory _title) public {
        books.push(Book(_title, true));
    }
    /// @notice Borrow a book by its index.
    /// @param _index Index of the book to borrow.
    function borrowBook(uint256 _index) public {
        require(_index < books.length, "Invalid book index");
        require(books[_index].isAvailable, "Book not available");
        books[_index].isAvailable = false;
    }
    /// @notice Return a borrowed book.
    /// @param _index Index of the book to return.
    function returnBook(uint256 _index) public {
        require(_index < books.length, "Invalid book index");
        require(!books[_index].isAvailable, "Book is already available");
        books[_index].isAvailable = true;
    }
    /// @notice Get all books in the library.
    /// @return Array of all books with title and availability.
    function getBooks() public view returns (Book[] memory) {
        return books;
    }
    /// @notice Get total number of books in the library.
    function getBookCount() public view returns (uint256) {
        return books.length;
    }
}
