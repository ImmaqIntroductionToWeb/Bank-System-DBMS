-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 09, 2024 at 11:59 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `banksystem`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Deposit` (IN `Account_Id` INT, IN `amount` DECIMAL(10,2))   BEGIN
    DECLARE current_balance DECIMAL(10,2);

    SELECT Balance INTO current_balance
    FROM accounts
    WHERE Account_Id = 101 LIMIT 1;

    IF current_balance IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Account not found';
    ELSE
        UPDATE accounts
        SET Balance = current_balance + amount
        WHERE Account_Id = 101;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Withdrawal` (IN `Account_Id` INT, IN `amount` DECIMAL(10,2))   BEGIN
    DECLARE current_balance DECIMAL(10,2);

    SELECT Balance INTO current_balance
    FROM accounts
    WHERE Account_Id = 101 LIMIT 1;

    IF current_balance IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Account not found';
    ELSE
        UPDATE accounts
        SET Balance = current_balance - amount
        WHERE Account_Id = 101;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `Account_Id` int(5) NOT NULL,
  `Account_number` int(15) DEFAULT NULL,
  `Client_Id` varchar(10) DEFAULT NULL,
  `Branch_Id` varchar(10) DEFAULT NULL,
  `Balance` decimal(10,0) DEFAULT NULL,
  `Account_type` varchar(20) DEFAULT NULL,
  `Created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`Account_Id`, `Account_number`, `Client_Id`, `Branch_Id`, `Balance`, `Account_type`, `Created_at`) VALUES
(101, 2147483, '100D', 'SC33H', 97000, 'Savings', '2018-08-04 10:00:00'),
(102, 9876543, '309H', 'LB26H', 22000, 'Cheque', '2010-05-04 13:45:01'),
(103, 7483647, '199C', 'LB26H', 5500, 'Savings', '2022-09-04 16:00:22');

-- --------------------------------------------------------

--
-- Table structure for table `branch_infromartion`
--

CREATE TABLE `branch_infromartion` (
  `BranchID` varchar(20) NOT NULL,
  `BranchType` varchar(25) NOT NULL,
  `BranchName` varchar(20) DEFAULT NULL,
  `Contact_Number` int(10) DEFAULT NULL,
  `Email` varchar(25) NOT NULL,
  `BranchAddress` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `branch_infromartion`
--

INSERT INTO `branch_infromartion` (`BranchID`, `BranchType`, `BranchName`, `Contact_Number`, `Email`, `BranchAddress`) VALUES
('LB26H', 'Retail', 'Liberty House26', 112572344, 'lhouse26@liberty.com', '102 Loveday Road Par'),
('SC33H', 'Investments', 'SunCity House33', 112769900, 'scity33@libertybank.com', 'Sun City Mall');

-- --------------------------------------------------------

--
-- Table structure for table `client_information`
--

CREATE TABLE `client_information` (
  `clientID` varchar(10) NOT NULL,
  `Name` tinytext DEFAULT NULL,
  `Surname` tinytext DEFAULT NULL,
  `Account Number` int(15) NOT NULL,
  `Address` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client_information`
--

INSERT INTO `client_information` (`clientID`, `Name`, `Surname`, `Account Number`, `Address`) VALUES
('100D', 'Khloe', 'Ncane', 2147483, '276 Main Street Johannesb'),
('199C', 'Garreth', 'Van Der', 7483647, 'Narrow Str Borksburg Joha'),
('309H', 'Lebohang', 'Mathoba', 9876543, 'Marshall Street Durban');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `Employee_id` varchar(11) NOT NULL,
  `Employee_Name` tinytext DEFAULT NULL,
  `Employee_Sname` tinytext DEFAULT NULL,
  `Hire_date` date DEFAULT NULL,
  `Position` tinytext DEFAULT NULL,
  `Branch_Id` varchar(5) DEFAULT NULL,
  `Status` tinytext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`Employee_id`, `Employee_Name`, `Employee_Sname`, `Hire_date`, `Position`, `Branch_Id`, `Status`) VALUES
('2B', 'Leatrice', 'Van Vyk', '2019-09-12', 'Teller', 'LB26H', 'Active'),
('A1', 'John', 'Smith', '1985-03-25', 'Teller', 'LB26H', 'Active'),
('SC6', 'Thandi', 'Mkhungo', '2000-02-26', 'Branch Manager', 'SC33H', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `TransactionID` varchar(5) NOT NULL,
  `Account_Id` int(5) DEFAULT NULL,
  `TransactionDate` datetime DEFAULT NULL,
  `TransactionType` tinytext DEFAULT NULL,
  `Amount` decimal(10,0) DEFAULT NULL,
  `Description` varchar(225) DEFAULT NULL,
  `Branch_Id` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`TransactionID`, `Account_Id`, `TransactionDate`, `TransactionType`, `Amount`, `Description`, `Branch_Id`) VALUES
('AB1', 101, '2024-08-06 10:30:00', 'Deposit', 5000, 'Monthly Deposit', 'SC33H'),
('AB2', 102, '2024-08-01 11:30:00', 'Withdrawal', 200, 'Withdrawal', 'LB26H'),
('AB3', 103, '2024-08-07 15:30:00', 'Transfer', 500, 'Depit Order', 'LB26H');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`Account_Id`),
  ADD UNIQUE KEY `Account_Id` (`Account_Id`);

--
-- Indexes for table `branch_infromartion`
--
ALTER TABLE `branch_infromartion`
  ADD PRIMARY KEY (`BranchID`);

--
-- Indexes for table `client_information`
--
ALTER TABLE `client_information`
  ADD PRIMARY KEY (`clientID`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`Employee_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`TransactionID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
