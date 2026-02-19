-- NBA STATISTICS DATABASE PROJECT
-- Author: Batmunkh Enkhbold

-- Create Database
CREATE DATABASE NBA_Stats;
GO

USE NBA_Stats;
GO

-- Teams Table
CREATE TABLE Teams (
    TeamID INT PRIMARY KEY IDENTITY(1,1),
    TeamName VARCHAR(100) NOT NULL,
    City VARCHAR(100)
);

-- Players Table
CREATE TABLE Players (
    PlayerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Position VARCHAR(50),
    TeamID INT,
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
);

-- Games Table
CREATE TABLE Games (
    GameID INT PRIMARY KEY IDENTITY(1,1),
    GameDate DATE,
    HomeTeamID INT,
    AwayTeamID INT,
    FOREIGN KEY (HomeTeamID) REFERENCES Teams(TeamID),
    FOREIGN KEY (AwayTeamID) REFERENCES Teams(TeamID)
);

-- Player Game Statistics Table
CREATE TABLE PlayerGameStats (
    StatID INT PRIMARY KEY IDENTITY(1,1),
    PlayerID INT,
    GameID INT,
    Points INT,
    Assists INT,
    Rebounds INT,
    Steals INT,
    Blocks INT,
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID),
    FOREIGN KEY (GameID) REFERENCES Games(GameID)
);


-- Teams
INSERT INTO Teams (TeamName, City) VALUES 
('Lakers', 'Los Angeles'),
('Warriors', 'Golden State');

-- Players
INSERT INTO Players (FirstName, LastName, Position, TeamID) VALUES
('LeBron', 'James', 'SF', 1),
('Anthony', 'Davis', 'PF', 1),
('Stephen', 'Curry', 'PG', 2),
('Klay', 'Thompson', 'SG', 2);

-- Game
INSERT INTO Games (GameDate, HomeTeamID, AwayTeamID) VALUES
('2025-01-10', 1, 2);

-- Player Stats
INSERT INTO PlayerGameStats (PlayerID, GameID, Points, Assists, Rebounds, Steals, Blocks) VALUES
(1, 1, 30, 8, 7, 2, 1),
(2, 1, 22, 3, 10, 1, 3),
(3, 1, 35, 6, 5, 2, 0),
(4, 1, 18, 4, 4, 1, 1);


-- Total Points Per Player
SELECT 
    P.FirstName + ' ' + P.LastName AS PlayerName,
    SUM(S.Points) AS TotalPoints
FROM Players P
JOIN PlayerGameStats S ON P.PlayerID = S.PlayerID
GROUP BY P.FirstName, P.LastName
ORDER BY TotalPoints DESC;

-- Average Points Per Game
SELECT 
    P.FirstName + ' ' + P.LastName AS PlayerName,
    AVG(S.Points) AS AvgPoints
FROM Players P
JOIN PlayerGameStats S ON P.PlayerID = S.PlayerID
GROUP BY P.FirstName, P.LastName;

-- Team Total Points
SELECT 
    T.TeamName,
    SUM(S.Points) AS TeamPoints
FROM Teams T
JOIN Players P ON T.TeamID = P.TeamID
JOIN PlayerGameStats S ON P.PlayerID = S.PlayerID
GROUP BY T.TeamName;

-- Top Scorer
SELECT TOP 1
    P.FirstName + ' ' + P.LastName AS PlayerName,
    SUM(S.Points) AS TotalPoints
FROM Players P
JOIN PlayerGameStats S ON P.PlayerID = S.PlayerID
GROUP BY P.FirstName, P.LastName
ORDER BY TotalPoints DESC;
