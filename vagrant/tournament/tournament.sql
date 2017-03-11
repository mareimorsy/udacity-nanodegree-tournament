-- Table definitions for the tournament project.

-- Drop all Tables and Views if they exist
DROP TABLE IF EXISTS players CASCADE;
DROP TABLE IF EXISTS matches CASCADE;
DROP VIEW IF EXISTS match_count CASCADE;
DROP VIEW IF EXISTS win_count CASCADE;
DROP VIEW IF EXISTS standings CASCADE;

-- players Table

-- +----+------+
-- | id | name |
-- +----+------+
CREATE TABLE players (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255)
);

-- matches Table

-- +----+-----------+----------+
-- | id | winner_id | loser_id |
-- +----+-----------+----------+
CREATE TABLE matches (
	id SERIAL PRIMARY KEY,
	winner_id INT REFERENCES players(id) NOT NULL,
	loser_id INT REFERENCES players(id) NOT NULL
);

-- match_count View

-- +-----------+-------------+
-- | player_id | matches_num |
-- +-----------+-------------+
CREATE VIEW match_count AS
	SELECT players.id AS player_id, COUNT(*) AS matches_num
	FROM players
	JOIN matches ON matches.winner_id = players.id OR matches.loser_id = players.id
	GROUP BY players.id;

-- win_count View

-- +-----------+-----------+
-- | player_id | win_count |
-- +-----------+-----------+
CREATE VIEW win_count AS
	SELECT players.id AS player_id, COUNT(*) AS win_count
	FROM players
	JOIN matches ON players.id = matches.winner_id
	GROUP BY players.id;

-- standings View

-- +-----------+------+------+---------+
-- | player_id | name | wins | matches |
-- +-----------+------+------+---------+
CREATE VIEW standings AS
	SELECT players.id,
		players.name,
	    COALESCE(win_count.win_count, 0 ) AS wins,
		COALESCE(match_count.matches_num, 0) AS matches
	FROM players
	LEFT JOIN win_count on players.id = win_count.player_id
	LEFT JOIN match_count ON players.id = match_count.player_id
	ORDER BY wins DESC, matches DESC;