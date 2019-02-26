/*Question1: Returns the first 10 rows of the survey table*/ 
SELECT *
FROM survey
LIMIT 10;



/*Question 2: Returns the number of users who responded to each question*/ 
 SELECT question, 
 COUNT(user_id) as 'responses'
 FROM survey
 GROUP BY 1
 ORDER BY 1;

/*Question 4: Pulls the first 5 rows from the quiz, home_try_on, and purchase tables*/
SELECT * FROM quiz
LIMIT 5;
SELECT * FROM home_try_on
LIMIT 5;
SELECT * FROM purchase
LIMIT 5;


/*Question 5: Combines quiz, home_try_on, and purchase into new table*/
SELECT DISTINCT q.user_id,
h.user_id IS NOT NULL AS 'is_home_try_on',
h.number_of_pairs,
p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h' 
ON q.user_id = h.user_id
LEFT JOIN purchase AS 'P'
ON q.user_id = p.user_id
LIMIT 10;
/*For is_home_try_on and is_purchase 1=True 0=False*/


/*Question 6 Slide 6*/
With funnels AS(
SELECT DISTINCT q.user_id,
h.user_id IS NOT NULL AS 'is_home_try_on',
h.number_of_pairs,
p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h' 
ON q.user_id = h.user_id
LEFT JOIN purchase AS 'P'
ON q.user_id = p.user_id)

SELECT number_of_pairs,
COUNT(*) AS 'num_quiz',
SUM(is_home_try_on) AS 'num_home_try',
SUM(is_purchase) AS 'num_purchase',
ROUND(1.0 * SUM(is_home_try_on) / COUNT(user_id),2) AS 'quiz_to_try_on',
ROUND(1.0 * SUM(is_purchase) / SUM(is_home_try_on),2) AS 'try_on_to_purchase'
FROM funnels
GROUP BY 1
ORDER BY 1;


/*Question 6 Slide 7*/
SELECT style,
COUNT(style) as 'Count'
FROM quiz
GROUP BY 1
ORDER BY 2 DESC;

With funnels AS(
SELECT DISTINCT q.user_id,
h.user_id IS NOT NULL AS 'is_home_try_on',
h.number_of_pairs,
q.style,  
p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h' 
ON q.user_id = h.user_id
LEFT JOIN purchase AS 'P'
ON q.user_id = p.user_id)

SELECT style,
COUNT(*) AS 'num_quiz',
SUM(is_home_try_on) AS 'num_home_try',
SUM(is_purchase) AS 'num_purchase',
ROUND(1.0 * SUM(is_home_try_on) / COUNT(user_id),2) AS 'quiz_to_try_on',
ROUND(1.0 * SUM(is_purchase) / SUM(is_home_try_on),2) AS 'try_on_to_purchase'
FROM funnels
GROUP BY 1
ORDER BY 2 DESC;


/*Question 6 Slide 8*/
SELECT model_name,
COUNT(model_name) AS 'number_of _purchases'
FROM purchase
GROUP BY 1
ORDER BY 2 DESC;

SELECT color,
COUNT(color) AS 'number_of _purchases'
FROM purchase
GROUP BY 1
ORDER BY 2 DESC;



/*Question 6 Slide 9*/
SELECT price,
COUNT(price) AS 'number_of _purchases'
FROM purchase
GROUP BY 1
ORDER BY 2 DESC;
