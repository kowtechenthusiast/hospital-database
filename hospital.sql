-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 23, 2025 at 05:59 PM
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
-- Database: `hospital`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `did` int(11) NOT NULL,
  `dFname` varchar(50) NOT NULL,
  `dLname` varchar(50) NOT NULL,
  `dept` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `docPhno` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`did`, `dFname`, `dLname`, `dept`, `salary`, `docPhno`) VALUES
(24, 'Rajesh', 'Kumar', 'Dental', 100000, '918457389786'),
(25, 'Ramdas', 'achar', 'Dermatology', 80000, '918457389786'),
(26, 'Mahesh', 'S', 'Maternity', 75000, '917436654212'),
(27, 'Prakash', 'raj', 'Internal', 50000, '919353549423'),
(28, 'Mahesh', 'Babu', 'Psychiatry', 60000, '9353549423');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `pid` int(11) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `age` int(11) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `blood` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phno` varchar(20) NOT NULL,
  `disease` varchar(50) NOT NULL,
  `dept` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`pid`, `firstName`, `lastName`, `age`, `gender`, `blood`, `email`, `phno`, `disease`, `dept`, `status`, `date`, `time`) VALUES
(0, 'Kowshikk', 'Kanchann', 197, 'malee', 'B-', 'kowshikk606@gmail.co', '91-93535494239', 'feveri', 'internals', 'outpatienti', '2024-07-23', '17:30:01'),
(4, 'Kowshik', 'Kanchan', 19, 'male', 'A+', 'kowshikk606@gmail.com', '919353549423', 'fever', 'dental', 'inpatient', '2024-07-27', '17:15:00'),
(6, 'Mahendra', 'Singh', 40, 'male', 'O-', 'kowshikk606@gmail.com', '919353549427', 'cold', 'internal', 'inpatient', '2024-07-31', '00:25:00'),
(8, 'Karthik', 'Kanchan KS', 25, 'male', 'AB+', 'kowshikk606@gmail.com', '919353549423', 'fever', 'dental', 'inpatient', '2024-07-11', '16:19:00'),
(17, 'Ramdas', 'achar', 30, 'male', 'A+', 'motagipavan36@gmail.com', '+918457389786', 'cold', '', 'outpatient', '2024-08-08', '00:11:00'),
(21, 'Kowshik', 'S', 20, 'male', 'O+', 'kowshikk606@gmail.com', '+917436654212', 'heart disease', 'psychiatry', 'inpatient', '2024-07-22', '10:30:00'),
(22, 'Kowshik', 'S', 20, 'male', 'O+', 'kowshikk606@gmail.com', '+917436654212', 'heart disease', 'psychiatry', 'inpatient', '2024-07-22', '10:30:00'),
(24, 'Mahesh', 'S', 25, 'male', 'AB-', 'nikhilkumar13595@gmail.com', '+917436654212', 'cold', '', 'inpatient', '2024-08-23', '11:40:00'),
(26, 'Mahesh', 'S', -1, 'male', 'AB-', 'kowshikk606@gmail.com', '917436654212', 'caugh', 'dental', 'inpatient', '2024-08-10', '13:54:00'),
(27, 'Ramdas', 'achar', 31, 'male', 'B-', 'kowshikk666@gmail.com', '918457389786', 'fever', 'neurology', 'outpatient', '2024-09-18', '09:28:00'),
(28, 'Ramesh', 'Raj', 18, 'male', 'A-', 'kowshikk606@gmail.com', '1234567890', 'cold', 'Dermatology', 'outpatient', '2024-11-06', '10:44:00'),
(30, 'Karthik', 'Kanchan K S', 25, 'male', 'B+', 'karthikkanchan@gmail.com', '8150921348', 'cold', 'Internal', 'outpatient', '2024-11-06', '13:49:00'),
(31, 'Kowshik', 'K S', 30, 'male', 'A+', '123@gmail.com', '9353549423', 'cold', 'Dermatology', 'outpatient', '2025-01-16', '22:13:00');

--
-- Triggers `patient`
--
DELIMITER $$
CREATE TRIGGER `patientdelete` BEFORE DELETE ON `patient` FOR EACH ROW INSERT INTO trigr VALUES(null,OLD.pid,OLD.firstName,OLD.lastName,OLD.email,'Patient Deleted',NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patientinsertion` AFTER INSERT ON `patient` FOR EACH ROW INSERT INTO trigr VALUES(null,NEW.pid,NEW.firstName,NEW.lastName,NEW.email,'Patient Inserted',NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patientupdate` AFTER UPDATE ON `patient` FOR EACH ROW INSERT INTO trigr VALUES(null,NEW.pid,NEW.firstName,NEW.lastName,NEW.email,'Patient Updated',NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pharmacy`
--

CREATE TABLE `pharmacy` (
  `tabid` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `dept` varchar(50) NOT NULL,
  `specification` varchar(200) NOT NULL,
  `prize` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pharmacy`
--

INSERT INTO `pharmacy` (`tabid`, `name`, `dept`, `specification`, `prize`) VALUES
(1, 'Ibuprofen', 'dental', 'Pain relief, anti-inflammatory', 300),
(2, 'Amoxicillin', 'dental', 'Antibiotic for infections', 250),
(3, 'Folic Acid', 'maternity', 'Prevention of neural tube defects', 400),
(4, 'Prenatal Vitamins', 'maternity', 'Nutritional support during pregnancy', 360),
(5, 'Doxycycline', 'dermatology', 'Treatment of acne, rosacea, and various bacterial ', 600),
(6, 'Isotretinoin', 'dermatology', 'Severe nodular acne unresponsive to other treatmen', 550),
(7, 'Lidocaine', 'dental', 'Local anesthetic for dental procedures', 180),
(8, 'Clindamycin', 'dental', 'Antibiotic for severe dental infections', 270),
(9, 'Calcium Carbonate', 'maternity', 'Calcium supplement for pregnancy', 150),
(10, 'Hydroquinone', 'dermatology', 'Treatment of hyperpigmentation and dark spots', 320),
(11, 'Tretinoin', 'dermatology', 'Topical treatment for acne and skin rejuvenation', 410),
(12, 'Glucosamine', 'orthopedics', 'Supplement for joint health and osteoarthritis', 280),
(13, 'Diclofenac', 'orthopedics', 'Pain relief and anti-inflammatory for arthritis', 240),
(14, 'Sertraline', 'psychiatry', 'Treatment of depression, anxiety, and OCD', 350),
(15, 'Alprazolam', 'psychiatry', 'Management of anxiety disorders and panic attacks', 300),
(16, 'Gabapentin', 'neurology', 'Management of neuropathic pain and seizures', 370),
(17, 'Levetiracetam', 'neurology', 'Anticonvulsant for epilepsy treatment', 430),
(18, 'Metronidazole', 'dental', 'Antibiotic for anaerobic infections in dental care', 260),
(19, 'Chlorhexidine', 'dental', 'Antiseptic for oral hygiene and gum disease', 220),
(20, 'Ferrous Sulfate', 'maternity', 'Iron supplement to prevent anemia during pregnancy', 180),
(21, 'Miconazole', 'dermatology', 'Antifungal for skin infections like athlete’s foot', 190),
(22, 'Adapalene', 'dermatology', 'Topical retinoid for acne treatment', 350),
(23, 'Calcium Citrate', 'orthopedics', 'Calcium supplement for bone health', 210),
(24, 'Methocarbamol', 'orthopedics', 'Muscle relaxant for musculoskeletal pain', 300),
(25, 'Fluoxetine', 'psychiatry', 'Treatment for depression and anxiety disorders', 340),
(26, 'Risperidone', 'psychiatry', 'Antipsychotic for schizophrenia and bipolar disorder', 390),
(27, 'Topiramate', 'neurology', 'Treatment for epilepsy and migraine prevention', 420),
(28, 'Amitriptyline', 'neurology', 'Tricyclic antidepressant also used for chronic pain', 310);

-- --------------------------------------------------------

--
-- Table structure for table `trigr`
--

CREATE TABLE `trigr` (
  `tid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trigr`
--

INSERT INTO `trigr` (`tid`, `pid`, `firstName`, `lastName`, `email`, `action`, `timestamp`) VALUES
(2, 6, 'Mahendra', 'Singh', 'kowshikk606@gmail.com', 'Patient Updated', '2024-07-15 20:25:20'),
(3, 9, 'Karthik', 'Kanchan KS', 'kowshikk606@gmail.com', 'Patient Deleted', '2024-07-15 20:27:53'),
(7, 14, 'Ramdas', 'achar', 'kowshikk606@gmail.com', 'Patient Inserted', '2024-07-16 16:04:52'),
(9, 16, 'Ramdas', 'achar', 'kowshikk606@gmail.com', 'Patient Inserted', '2024-07-16 16:09:25'),
(11, 8, 'Karthik', 'Kanchan KS', 'kowshikk606@gmail.com', 'Patient Updated', '2024-07-16 16:13:30'),
(12, 10, 'Mahesh', 'S', 'kowshikk606@gmail.com', 'Patient Updated', '2024-07-16 16:15:14'),
(13, 8, 'Karthik', 'Kanchan KS', 'kowshikk606@gmail.com', 'Patient Updated', '2024-07-16 16:19:31'),
(14, 14, 'Ramdas', 'achar', 'kowshikk606@gmail.com', 'Patient Deleted', '2024-07-16 16:22:12'),
(16, 12, 'Ramdas', 'achar', 'kowshikk606@gmail.com', 'Patient Deleted', '2024-07-16 16:26:51'),
(17, 15, 'Ramdas', 'achar', 'kowshikk606@gmail.com', 'Patient Deleted', '2024-07-16 16:27:37'),
(18, 16, 'Ramdas', 'achar', 'kowshikk606@gmail.com', 'Patient Deleted', '2024-07-16 16:29:45'),
(19, 11, 'Ramdas', 'achar', 'kowshikk606@gmail.com', 'Patient Deleted', '2024-07-16 16:31:04'),
(20, 10, 'Mahesh', 'S', 'kowshikk606@gmail.com', 'Patient Deleted', '2024-07-16 16:31:52'),
(21, 13, 'Ramdas', 'achar', 'kowshikk606@gmail.com', 'Patient Deleted', '2024-07-16 16:32:37'),
(23, 18, 'Ramdas', 'achar', 'kowshikk606@gmail.com', 'Patient Inserted', '2024-07-17 12:36:34'),
(24, 18, 'Ramdas', 'achar', 'kowshikk606@gmail.com', 'Patient Updated', '2024-07-17 12:37:10'),
(25, 18, 'Ramdas', 'achar', 'kowshikk606@gmail.com', 'Patient Deleted', '2024-07-17 12:37:21'),
(26, 19, 'Ramdas', 'achar', 'kowshikk606@gmail.com', 'Patient Inserted', '2024-07-17 14:48:27'),
(27, 19, 'Ramdas', 'achar', 'kowshikk606@gmail.com', 'Patient Updated', '2024-07-17 14:49:06'),
(29, 20, 'Madan', 'KS', 'kowshikk606@gmail.com', 'Patient Inserted', '2024-07-19 17:05:58'),
(30, 20, 'Madan', 'KS', 'kowshikk606@gmail.com', 'Patient Updated', '2024-07-19 17:07:01'),
(32, 21, 'Kowshik', 'S', 'kowshikk606@gmail.com', 'Patient Inserted', '2024-07-22 11:24:13'),
(33, 22, 'Kowshik', 'S', 'kowshikk606@gmail.com', 'Patient Inserted', '2024-07-22 11:25:09'),
(34, 23, 'Kowshik', 'S', 'kowshikk606@gmail.com', 'Patient Inserted', '2024-07-22 17:48:43'),
(35, 23, 'Kowshik', 'S', 'kowshikk606@gmail.com', 'Patient Updated', '2024-07-22 17:50:04'),
(37, 24, 'Mahesh', 'S', 'nikhilkumar13595@gmail.com', 'Patient Inserted', '2024-08-26 11:39:00'),
(38, 25, 'Mahesh', 'S', 'nikhilkumar13595@gmail.com', 'Patient Inserted', '2024-08-26 11:40:02'),
(39, 25, 'Mahesh', 'S', 'nikhilkumar13595@gmail.com', 'Patient Deleted', '2024-08-26 11:40:25'),
(40, 26, 'Mahesh', 'S', 'kowshikk606@gmail.com', 'Patient Inserted', '2024-08-26 11:54:36'),
(41, 27, 'Ramdas', 'achar', 'kowshikk666@gmail.com', 'Patient Inserted', '2024-09-08 09:25:32'),
(42, 28, 'Ramesh', 'Raj', 'kowshikk606@gmail.com', 'Patient Inserted', '2024-11-02 10:40:33'),
(44, 29, 'Kowshik', 'Kanchan K S', 'kowshikk606@gmail.com', 'Patient Deleted', '2024-11-02 10:42:53'),
(45, 30, 'Karthik', 'Kanchan K S', 'karthikkanchan@gmail.com', 'Patient Inserted', '2024-11-02 10:46:29'),
(46, 31, 'Kowshik', 'K S', '123@gmail.com', 'Patient Inserted', '2025-01-23 22:09:16');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`) VALUES
(1, 'Kowshik KS', 'kowshikk606@gmail.com', 'scrypt:32768:8:1$AMwaDwOeLs2bdx7v$c3dc30268449b20c3b77463e1281bbe916bbcf061e069cbc2252d9c1769c84a4d9fc946f7c2d81e20abeb7ca9f8e5c252052ece7b68c48169aefd2bb5ed01e4f'),
(3, 'codeninja', 'motagipavan36@gmail.com', 'scrypt:32768:8:1$4bhbxUxfyyJp63e5$44d5d7c81745ed224c3ac45e2f659ac8362dfdb34842af1fc1dd4f5e64262bdc32b380e3c3db7ef6825bdcf068eb3d05c44a13fd9da41f4b5bcec18d0816b227'),
(4, 'Nikhil Achar', 'nikhilkumar13595@gmail.com', 'scrypt:32768:8:1$hlavL8ViDA5moy77$e8008513a6c2ac5969c8ad6dd74f0b999d54ac9d6a589fea34cfd89bd702261a482501046bdc352ab9b7021a6fe4548d66b7671192fdd60e5af46f4e6684eae6'),
(5, 'Kowshik KS', 'kowshikk666@gmail.com', 'scrypt:32768:8:1$IpsxRrPyY8P7H7W7$c923f7738888fd119bbfc89ce4d7fb1520007c38da14e89c26055f11f8ebeccd509acb45a1295bc20bab1ba62a94d813b2e1f9613105402b24babec720cd06f6'),
(6, 'codeninja', 'javoxil737@tiervio.com', 'scrypt:32768:8:1$pwa5o1eV0dOeElhY$644d4f0b820416e7136a2a532c5bc32c6a5c97a0b62e0db2333e8f55550b91bc720a5e961e5587153be4b2742b33e495da936bb9dd148a1b38df882afd148625'),
(7, 'Karthik', 'karthikkanchan@gmail.com', 'scrypt:32768:8:1$m1W96oJIWxkSoCwP$0f2a635dd4bd262a1890d4596abf0cea1c6ba3ffa2a1299786ed84509d5a16e65ed23d04d8c06b252eaadfe162a9e4a14be71705938c2e33396d105e8fd02658'),
(8, 'Karthik', '123@gmail.com', 'scrypt:32768:8:1$1YVOpo3WDq0il8ID$f3461706979c208e7a7dd522f0cb88ef91cea439d7df322feef6095ff7d9265ab337f36ea5779a6767d3a355b1f2d9808bd29180f577256acbc18bad2d2be61f');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`did`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `pharmacy`
--
ALTER TABLE `pharmacy`
  ADD PRIMARY KEY (`tabid`),
  ADD UNIQUE KEY `tab_name` (`name`);

--
-- Indexes for table `trigr`
--
ALTER TABLE `trigr`
  ADD PRIMARY KEY (`tid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `did` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `pharmacy`
--
ALTER TABLE `pharmacy`
  MODIFY `tabid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `trigr`
--
ALTER TABLE `trigr`
  MODIFY `tid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
