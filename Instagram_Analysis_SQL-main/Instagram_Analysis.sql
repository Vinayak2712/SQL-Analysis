-- Q1)  Rewarding Most Loyal Users -  Your Task: Find the 5 oldest users of the Instagram from the database provided
SELECT id, username FROM users ORDER BY created_at ASC LIMIT 5;

-- Q2) Remind Inactive Users to Start Posting -> Your Task: Find the users who have never posted a single photo on Instagram 
SELECT id,username FROM users WHERE id NOT IN (SELECT user_id FROM photos);

-- Q3) Declaring Contest Winner - Your Task: Identify the winner of the contest and provide their details to the team
 SELECT users.username, photos.id, photos.image_url, total_likes.numb_Likes FROM photos JOIN 
(SELECT likes.photo_id, COUNT(*) AS numb_Likes FROM likes GROUP BY likes.photo_id) AS total_likes 
ON total_likes.photo_id = photos.id
JOIN users ON users.id = photos.user_id ORDER BY total_likes.numb_Likes DESC LIMIT 1;

-- Q4) Hashtag Researching -> Your Task: Identify and suggest the top 5 most commonly used hashtags on the platform
SELECT tags.id, tags.tag_name,COUNT(*) AS num_hastag FROM tags JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY  tags.id, tags.tag_name ORDER BY num_hastag DESC LIMIT 5;

-- Q5) Launch AD Campaign -> Your Task: What day of the week do most users register on? Provide insights on when to schedule an ad campaign
SELECT DAYNAME(created_at) AS day_of_week, COUNT(*) AS num_of_registration FROM users group by day_of_week
ORDER BY num_of_registration DESC LIMIT 2;    



-- CAN SCHEDULE AN CAMPAIGN ON (THURSDAY OR SUNDAY) as both the days has highest and equal traffic .!


-- B) Investor Metrics: Our investors want to know if Instagram is performing 
-- well and is not becoming redundant like Facebook, they want to assess the app on the following grounds

-- Q1) User Engagement: our Task: Provide how many times does average user posts on Instagram. 
--                      Also, provide the total number of photos on Instagram/total number of users

-- AVERAGE USER POSTS ON INSTAGRAM
SELECT user_id,COUNT(*) AS numb_of_posts FROM photos GROUP BY user_id ORDER BY numb_of_posts DESC;

-- AND .. 
SELECT ROUND(COUNT(image_url)/ COUNT(DISTINCT user_id),0) AS avg_posts FROM photos;


-- Q2) Bots & Fake Accounts : Your Task: Provide data on users (bots) who have liked every single photo on the site 
--                                       (since any normal user would not be able to do this).

SELECT user_id, COUNT(DISTINCT photo_id) AS num_liked_photos FROM likes
GROUP BY user_id 
HAVING  num_liked_photos = (SELECT COUNT(DISTINCT user_id) FROM photos);






