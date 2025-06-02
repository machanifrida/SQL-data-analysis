-- !preview conn=DBI::dbConnect(RPostgres::Postgres(...))

-- Returns first 100 rows from tutorial.yammer_events
  SELECT * FROM tutorial.yammer_events LIMIT 100;

--Company with the most users
SELECT DISTINCT
    company_id,
    COUNT(DISTINCT user_id) AS user
  FROM tutorial.yammer_users
  GROUP BY 1
  ORDER BY 2 DESC;

--company with the most logins
 SELECT 
    COUNT(users.user_id) AS user_id,
	  users.company_id,
		events.event_name
  FROM tutorial.yammer_users AS users
  LEFT JOIN tutorial.yammer_events AS events
    ON users.user_id = events.user_id
  WHERE events.event_name = 'login'
  GROUP BY 2, 3
  ORDER BY 1 DESC;
  
  --company with the most logins
 SELECT 
    COUNT(users.user_id) AS user_id,
	  users.company_id,
		events.event_name,
		COUNT(events.event_name) AS number_events
  FROM tutorial.yammer_users AS users
  LEFT JOIN tutorial.yammer_events AS events
    ON users.user_id = events.user_id
  GROUP BY 2, 3
  ORDER BY 1 DESC;


--company with the most logins
 SELECT 
    COUNT(users.user_id) AS user_id,
	  users.company_id,
		events.event_name,
		COUNT(events.event_name) AS number_events
  FROM tutorial.yammer_users AS users
  LEFT JOIN tutorial.yammer_events AS events
    ON users.user_id = events.user_id
  GROUP BY 2, 3
  ORDER BY 1 DESC;

-- Number of users, distinct events & companies, languages, 
-- when account was created and when it was activated 
  SELECT 
    COUNT(DISTINCT user_id) AS user,
    COUNT(DISTINCT created_at) AS created_when,
    COUNT(DISTINCT company_id) AS no_companies,
    language,
    COUNT(DISTINCT activated_at) AS activated_when,
    state
  FROM tutorial.yammer_users 
  GROUP BY 4, 6;

--How many companies are in the database? 
  SELECT COUNT(DISTINCT company_id) AS no_companies
  FROM tutorial.yammer_users
  
  --Which company has the most users?
  SELECT 
    company_id,
    COUNT(DISTINCT user_id) AS user
  FROM tutorial.yammer_users
  GROUP BY 1
  ORDER BY 2 DESC;

 --languages used by yammer users 
  SELECT 
    language,
    COUNT(DISTINCT user_id) AS user
  FROM tutorial.yammer_users
  GROUP BY 1
  ORDER BY 2 DESC;
 
 --number of logins per company 
  SELECT 
    COUNT(users.user_id) AS user_id,
	  users.company_id,
		events.event_name
  FROM tutorial.yammer_users AS users
  LEFT JOIN tutorial.yammer_events AS events
    ON users.user_id = events.user_id
  WHERE events.event_name = 'login'
  GROUP BY 2, 3
  ORDER BY 1 DESC;

--Daily/weekly events: signups, logins, visiting the website etc, location and device used
--SELECT COUNT(DISTINCT month) AS unique_months
SELECT 
    DATE_TRUNC('day', occurred_at) AS day_of_week,
    COUNT(users.user_id) AS number_events,
		events.event_name,
		events.location,
		events.device
  FROM tutorial.yammer_users AS users
  LEFT JOIN tutorial.yammer_events AS events
    ON users.user_id = events.user_id
  WHERE events.event_type IS NOT NULL AND events.event_name IS NOT NULL
  GROUP BY 1, 3, 4, 5
  ORDER BY 1 DESC;
  
--Daily/weekly events: signups, logins, visiting the website etc, location and device used
--SELECT COUNT(DISTINCT month) AS unique_months
SELECT 
    DATE_TRUNC('day', occurred_at) AS day_of_week,
    COUNT(users.user_id) AS number_events,
		events.event_name,
		events.location,
		events.device
  FROM tutorial.yammer_users AS users
  LEFT JOIN tutorial.yammer_events AS events
    ON users.user_id = events.user_id
  WHERE events.event_type IS NOT NULL AND events.event_name IS NOT NULL
  GROUP BY 1, 3, 4, 5
  ORDER BY 1 DESC;
  
--count events per day by extracting the day number from timestamp
 SELECT
    EXTRACT('DOW' FROM occurred_at) AS day, 
    user_id
 FROM tutorial.yammer_events
 
 --timestamp extracting daily events grouped by devices used
 SELECT 
    COUNT(event_name) AS number_events,
    device,
    EXTRACT('DOW' FROM occurred_at) AS day_of_week
  FROM tutorial.yammer_events
  GROUP BY 2, 3;
  
  --average events per day
SELECT 
  AVG(daily_events) AS avg_daily_events
FROM (
  SELECT 
    DATE_TRUNC('day', occurred_at) AS day,
    COUNT(user_id) AS daily_events
  FROM tutorial.yammer_events
  GROUP BY 1
) sub;

  
--daily/weekly events per location & grouped device when event type in not null
  SELECT 
    DATE_TRUNC('day', occurred_at) AS day_of_week,
    COUNT(users.user_id) AS number_events,
		events.event_name,
		events.location,
		events.device,
		CASE WHEN events.device LIKE '%iphone%' THEN 'iphones'
		     WHEN events.device LIKE '%nexus%' THEN 'nexus'
		     WHEN events.device LIKE '%ipad%' THEN 'ipads'
		     WHEN events.device LIKE '%samsung%' THEN 'samsung'
		     WHEN events.device LIKE 'htc%' THEN 'htc'
		     WHEN events.device LIKE '%nokia%' THEN 'nokia'
		     WHEN events.device LIKE '%kindle%' THEN 'kindle fire'
		     ELSE 'other devices' END AS user_device
  FROM tutorial.yammer_users AS users
  LEFT JOIN tutorial.yammer_events AS events
    ON users.user_id = events.user_id
  WHERE events.event_type IS NOT NULL AND events.event_name IS NOT NULL
  GROUP BY 1, 3, 4, 5
  ORDER BY 1 DESC;
 
--summary of event status where both event name and type are not null ordered by location   
  SELECT 
    COUNT(DISTINCT users.user_id) AS users,
	  users.state,
		users.language,
		events.event_type,
		events.event_name,
		events.location,
		events.device
  FROM tutorial.yammer_users AS users
  LEFT JOIN tutorial.yammer_events AS events
    ON users.user_id = events.user_id
  WHERE events.event_type IS NOT NULL AND events.event_name IS NOT NULL
  GROUP BY 2, 3, 4, 5, 6, 7
  ORDER BY 1 DESC;
  ORDER BY 1 DESC;
  
  --active events ordered by location
  SELECT 
    COUNT(DISTINCT users.user_id) AS users,
	  users.state,
		users.language,
		events.event_type,
		events.event_name,
		events.location,
		events.device
  FROM tutorial.yammer_users AS users
  LEFT JOIN tutorial.yammer_events AS events
    ON users.user_id = events.user_id
  WHERE events.event_type IS NOT NULL AND events.event_name IS NOT NULL
  GROUP BY 2, 3, 4, 5, 6, 7
  ORDER BY 1 DESC;