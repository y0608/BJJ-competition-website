-- Create Users table
DROP DATABASE IF EXISTS AWARDBJJ;
CREATE DATABASE AWARDBJJ;
USE AWARDBJJ;

-- Create Users table
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL
    -- Add other user fields as needed
);

-- Create Tournaments table
CREATE TABLE Tournaments (
    TournamentID INT PRIMARY KEY AUTO_INCREMENT,
    TournamentName VARCHAR(255) NOT NULL,
    Date DATE NOT NULL,
    Location VARCHAR(255) NOT NULL,
    OrganizerID INT,
    FOREIGN KEY (OrganizerID) REFERENCES Users(UserID)
);

-- Create Competitors table
CREATE TABLE Competitors (
    CompetitorID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    TournamentID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (TournamentID) REFERENCES Tournaments(TournamentID)
    -- Add other competitor fields as needed
);

-- Create Brackets table
CREATE TABLE Brackets (
    BracketID INT PRIMARY KEY AUTO_INCREMENT,
    TournamentID INT,
    BracketType VARCHAR(50) NOT NULL,
    CurrentRound INT DEFAULT 1,
    Placement1ID INT,
    Placement2ID INT,
    Placement3ID INT,
    Age ENUM('Adult', 'Juvenile', 'Master 1', 'Master 2', 'Master 3') NOT NULL,
    Belt ENUM('White', 'Blue', 'Purple', 'Brown', 'Black') NOT NULL,
    Weight ENUM('66kg', '77kg', '88kg') NOT NULL,
    FOREIGN KEY (TournamentID) REFERENCES Tournaments(TournamentID),
    FOREIGN KEY (Placement1ID) REFERENCES Competitors(CompetitorID),
    FOREIGN KEY (Placement2ID) REFERENCES Competitors(CompetitorID),
    FOREIGN KEY (Placement3ID) REFERENCES Competitors(CompetitorID)
    -- Add other bracket fields as needed
);


-- Create Matches table
CREATE TABLE Matches (
    MatchID INT PRIMARY KEY AUTO_INCREMENT,
    RoundNumber INT NOT NULL,
    WinType VARCHAR(50),
    SubmissionTime DATETIME,
    PointsPlayer1 INT,
    PointsPlayer2 INT,
    BracketID INT,
    Participant1ID INT,
    Participant2ID INT,
    WinnerID INT,
    FOREIGN KEY (BracketID) REFERENCES Brackets(BracketID),
    FOREIGN KEY (Participant1ID) REFERENCES Competitors(CompetitorID),
    FOREIGN KEY (Participant2ID) REFERENCES Competitors(CompetitorID),
    FOREIGN KEY (WinnerID) REFERENCES Competitors(CompetitorID)
    -- Add other match fields as needed
);



-- Insert sample data into Users table
INSERT INTO Users (Username, Email, Password)
VALUES
    ('JohnDoe', 'john.doe@example.com', 'password123'),
    ('JaneSmith', 'jane.smith@example.com', 'securepass'),
    ('AliceBrown', 'alice.brown@example.com', 'pass123'),
    ('BobJohnson', 'bob.johnson@example.com', 'securepw'),
    ('CharlieGreen', 'charlie.green@example.com', 'pass456'),
    ('DavidWhite', 'david.white@example.com', 'securepass'),
    ('EveJones', 'eve.jones@example.com', 'password789'),
    ('FrankWilliams', 'frank.williams@example.com', 'securepass'),
    ('GraceDavis', 'grace.davis@example.com', 'pass789'),
    ('HenryTaylor', 'henry.taylor@example.com', 'securepw'),
    ('IvyMiller', 'ivy.miller@example.com', 'pass123'),
    ('JackAnderson', 'jack.anderson@example.com', 'securepass'),
    ('KellyWard', 'kelly.ward@example.com', 'pass456'),
    ('LeoYoung', 'leo.young@example.com', 'securepw'),
    ('MiaClark', 'mia.clark@example.com', 'password789'),
    ('NoahMoore', 'noah.moore@example.com', 'securepass')
;

-- Insert sample data into Tournaments table
INSERT INTO Tournaments (TournamentName, Date, Location, OrganizerID)
VALUES
    ('Summer Open', '2023-07-15', 'City Arena', 1),
    ('Winter Classic', '2023-12-05', 'Sports Hall', 2)
;

-- Insert sample data into Competitors table for the first tournament (Summer Open)
INSERT INTO Competitors (UserID, TournamentID)
VALUES
    (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1)
;

-- Insert sample data into Competitors table for the second tournament (Winter Classic)
INSERT INTO Competitors (UserID, TournamentID)
VALUES
    (9, 2), (10, 2), (11, 2), (12, 2), (13, 2), (14, 2), (15, 2), (16, 2)
;

-- Insert sample data into Brackets table for the first tournament (Summer Open)
INSERT INTO Brackets (TournamentID, BracketType, Age, Belt, Weight)
VALUES
    (1, 'Single-Elimination', 'Adult', 'Blue', '77kg'),
    (1, 'Single-Elimination', 'Adult', 'Purple', '88kg')
;

-- Insert sample data into Brackets table for the second tournament (Winter Classic)
INSERT INTO Brackets (TournamentID, BracketType, Age, Belt, Weight)
VALUES
    (2, 'Double-Elimination', 'Master 1', 'Brown', '77kg'),
    (2, 'Double-Elimination', 'Master 1', 'Black', '88kg')
;


-- Insert sample data into Matches table for the first bracket of the first tournament
INSERT INTO Matches (RoundNumber, WinType, SubmissionTime, PointsPlayer1, PointsPlayer2, BracketID, Participant1ID, Participant2ID, WinnerID)
VALUES
    (1, 'Submission', '2023-07-16 10:30:00', NULL, NULL, 1, 1, 2, 1),
    (1, 'Points', NULL, 10, 8, 1, 3, 4, 3)
;

-- Insert sample data into Matches table for the second bracket of the first tournament
INSERT INTO Matches (RoundNumber, WinType, SubmissionTime, PointsPlayer1, PointsPlayer2, BracketID, Participant1ID, Participant2ID, WinnerID)
VALUES
    (1, 'Submission', '2023-07-16 12:30:00', NULL, NULL, 2, 5, 6, 6),
    (1, 'Points', NULL, 12, 15, 2, 7, 8, 8)
;

-- Insert sample data into Matches table for the first bracket of the second tournament
INSERT INTO Matches (RoundNumber, WinType, SubmissionTime, PointsPlayer1, PointsPlayer2, BracketID, Participant1ID, Participant2ID, WinnerID)
VALUES
    (1, 'Submission', '2023-12-06 15:30:00', NULL, NULL, 3, 9, 10, 9),
    (1, 'Points', NULL, 8, 10, 3, 11, 12, 12)
;

-- Insert sample data into Matches table for the second bracket of the second tournament
INSERT INTO Matches (RoundNumber, WinType, SubmissionTime, PointsPlayer1, PointsPlayer2, BracketID, Participant1ID, Participant2ID, WinnerID)
VALUES
    (1, 'Submission', '2023-12-06 17:30:00', NULL, NULL, 4, 13, 14, 14),
    (1, 'Points', NULL, 14, 11, 4, 15, 16, 15)
;

-- Tournaments 
SELECT * FROM Tournaments;


-- Brackets
SELECT
    Tournaments.TournamentName,
    Brackets.BracketID,
    Brackets.BracketType,
    Brackets.Age,
    Brackets.Belt,
    Brackets.Weight
FROM
    Tournaments
JOIN
    Brackets ON Tournaments.TournamentID = Brackets.TournamentID;


-- Matches
SELECT
    Tournaments.TournamentName,
    Tournaments.Date,
    Brackets.BracketID,
    Matches.MatchID,
    Matches.RoundNumber,
    Matches.WinType,
    Matches.SubmissionTime,
    Matches.PointsPlayer1,
    Matches.PointsPlayer2,
    CONCAT_WS(' vs ', P1User.Username, P2User.Username) AS MatchParticipants,
    WinnerUser.Username AS Winner
FROM
    Matches
JOIN
    Brackets ON Matches.BracketID = Brackets.BracketID
JOIN
    Tournaments ON Brackets.TournamentID = Tournaments.TournamentID
LEFT JOIN
    Competitors AS P1 ON Matches.Participant1ID = P1.CompetitorID
LEFT JOIN
    Competitors AS P2 ON Matches.Participant2ID = P2.CompetitorID
LEFT JOIN
    Competitors AS Winner ON Matches.WinnerID = Winner.CompetitorID
LEFT JOIN
    Users AS P1User ON P1.UserID = P1User.UserID
LEFT JOIN
    Users AS P2User ON P2.UserID = P2User.UserID
LEFT JOIN
    Users AS WinnerUser ON Winner.UserID = WinnerUser.UserID;
