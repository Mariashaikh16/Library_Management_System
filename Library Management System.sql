create database library;
use library;

-- Create Books table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Publisher VARCHAR(100),
    YearPublished INT,
    Quantity INT
);

-- Create Members table
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    JoinDate DATE
);

-- Create Transactions table
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Insert sample books
INSERT INTO Books VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Scribner', 1925, 3),
(2, '1984', 'George Orwell', 'Secker & Warburg', 1949, 5);

-- Insert sample members
INSERT INTO Members VALUES
(1, 'Alice Johnson', 'alice@example.com', '2024-01-10'),
(2, 'Bob Smith', 'bob@example.com', '2024-03-15');

-- Insert sample transactions
INSERT INTO Transactions VALUES
(1, 1, 1, '2025-04-20', NULL),  -- Book not yet returned
(2, 2, 2, '2025-04-10', '2025-04-17'); -- Book returned

-- List all available books
SELECT * FROM Books WHERE Quantity > 0;

-- Show borrowed books (not returned)
SELECT 
    T.TransactionID, B.Title, M.Name, T.BorrowDate 
FROM 
    Transactions T
    JOIN Books B ON T.BookID = B.BookID
    JOIN Members M ON T.MemberID = M.MemberID
WHERE 
    T.ReturnDate IS NULL;

-- Return a book (update return date and quantity)
UPDATE Transactions 
SET ReturnDate = '2025-04-24' 
WHERE TransactionID = 1;

UPDATE Books 
SET Quantity = Quantity + 1 
WHERE BookID = 1;
