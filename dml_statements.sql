-- Add a row of data into the blog_user table
-- Syntax: INSERT INTO table_name(col_1, col_2, etc.) VALUES (val_1, val_2, etc.)



INSERT INTO blog_user(
	username,
	password_hash,
	email,
	first_name,
	last_name,
	birthday,
	password_hint
) VALUES (
	'brians',
	'jdfhjkafhkjlshkjdhf',
	'brians@ct.com',
	'Brian',
	'Stanton',
	'1979-03-13',
	'good luck!'
);



INSERT INTO blog_user(
	email,
	username,
	birthday,
	last_name,
	first_name,
	middle_name,
	password_hash,
	password_hint
) VALUES (
	'jumpman23@goat.com',
	'airjordan',
	'1961-02-17',
	'Jordan',
	'Michael',
	'Jeffrey',
	'sdkfhdskfhdsjfdsf',
	'bulls'
);


SELECT *
FROM blog_user;

-- Insert without column names
-- Syntax: INSERT INTO table_name VALUES (val_1, val_2, etc.)
INSERT INTO category VALUES (
	1,
	'Health & Wellness',
	'Articles about bettering your mental and physical well-being',
	'#4147e8'
);

SELECT *
FROM category;


-- Because we manually set the category_id to 1, the SERIAL did not call the next val
-- So if we try to create another category using the default category_id, we will initially run into an error
INSERT INTO category(
	category_name,
	description,
	color
) VALUES (
	'Technology',
	'Articles about the technology that shapes and changes our world',
	'#c73920'
);

SELECT *
FROM category;


-- Insert Multiple rows of data in one command
-- Syntax: INSERT INTO table_name(col_1, col_2, etc.) VALUES (val_a_1, val_a_2, etc. ), (val_b_1, val_b_2, etc.)

INSERT INTO post(
	title,
	body,
	copyright,
	user_id
) VALUES (
	'ChatGPT',
	'It is going to take over the world. Or will it?',
	TRUE,
	1
), (
	'Chicago Bulls',
	'Ever since I left this franchise has been a joke',
	FALSE,
	2
), (
	'Python',
	'I love Python. It is a great language and I am excited to keep learning!',
	'no',
	1
);

SELECT *
FROM post;


-- Try to add another post with a user id of a user that does not exist
--INSERT INTO post(
--	title,
--	body,
--	copyright,
--	user_id
--) VALUES (
--	'Spring',
--	'The weather is becoming much nicer and I love it!',
--	'off',
--	3 -- USER WITH ID 3 DOES NOT EXIST!
--);

INSERT INTO post_category 
VALUES (1, 2), 
(2, 1), 
(2, 2), 
(3, 2);

SELECT *
FROM post_category;

INSERT INTO post_comment (
	body,
	post_id,
	user_id
) VALUES (
	'I agree. Jerry needs to sell the team',
	2,
	1
);

SELECT *
FROM post_comment;

INSERT INTO post_comment (
	body,
	post_id,
	user_id
) VALUES (
	'Do you like it better than SQL or JavaScript? I do but I know some do not.',
	3,
	2
);


SELECT *
FROM post;

-- UPDATE DATA 
-- Syntax: UPDATE table_name SET col_name = value WHERE condition 
UPDATE post
SET title = 'Python Rules!'
WHERE post_id = 3;

SELECT *
FROM post;

-- an UPDATE/SET without a WHERE condition, all rows will update
UPDATE post
SET copyright = TRUE;

SELECT *
FROM post;

SELECT *
FROM blog_user;

INSERT INTO blog_user(
	username,
	password_hash,
	email,
	first_name,
	last_name,
	birthday,
	password_hint
) VALUES (
	'kevinb',
	'dfjhjdskfhdsf',
	'kevinb@ct.com',
	'Kevin',
	'Beier',
	'1977-05-26',
	'bad luck!'
),(
	'greatone',
	'kdsfjdskf',
	'wayneg@nhl.com',
	'Wayne',
	'Gretzky',
	'1962-09-06',
	'hockey!'
);

SELECT *
FROM blog_user;


-- UPDATE multiple rows based on a condition
UPDATE blog_user 
SET middle_name = 'Coding'
WHERE email LIKE '%@ct.com';

SELECT *
FROM blog_user;


-- Update multiple columns at a time
-- Syntax: UPDATE table_name SET col_1 = val_1, col_2 = val_2, etc. WHERE condition
UPDATE post
SET body = 'I won 6 rings here.', last_edited = current_timestamp
WHERE post_id = 2;

SELECT *
FROM post;


-- Constraints still apply to updates as well
--UPDATE post 
--SET user_id = 10 -- WILL NOT WORK SINCE USER ID 10 DOES NOT EXIST!
--WHERE post_id = 1;

INSERT INTO category(category_name, description, color)
VALUES ('abc', 'abc123', 'dfddf'), ('cba', 'cba', 'cba'), ('test123', '1234 test', '1234');

SELECT *
FROM category;


-- DELETE a row/record from a table
-- Syntax: DELETE FROM table_name WHERE condition 

DELETE FROM category
WHERE category_id = 4;

SELECT *
FROM category;


-- Delete multiple rows if they meet the condition
DELETE FROM category
WHERE color NOT LIKE '#%';

SELECT *
FROM category;


-- A DELETE FROM without a WHERE clause will delete ALL ROWS
SELECT *
FROM post_comment;


DELETE FROM post_comment;

SELECT *
FROM post_comment;

