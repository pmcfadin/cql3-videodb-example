//Users
INSERT INTO users (username, firstname, lastname, email, password, created_date) 
VALUES ('tcodd','Ted','Codd', 'tcodd@relational.com','5f4dcc3b5aa765d61d8327deb882cf99','2011-06-01 08:00:00');

INSERT INTO users (username, firstname, lastname, email, password, created_date)
VALUES ('cdate','Chris','Date', 'cdate@relational.com','6cb75f652a9b52798eb6cf2201057c73','2011-06-20 13:50:00');

//Videos
INSERT INTO videos (videoid, videoname, username, description, tags, upload_date) 
VALUES (99051fe9-6a9c-46c2-b949-38ef78858dd0,'My funny cat','tcodd', 'My cat likes to play the piano! So funny.',['cats','piano','lol'],'2012-06-01 08:00:00');

INSERT INTO videos (videoid, videoname, username, description, tags, upload_date) 
VALUES (b3a76c6b-7c7f-4af6-964f-803a9283c401,'Now my dog plays piano!','tcodd', 'My dog learned to play the piano because of the cat.',['dogs','piano','lol'],'2012-08-30 16:50:00');

// username_video_index
INSERT INTO username_video_index (username, videoid, upload_date, videoname) 
VALUES ('tcodd',99051fe9-6a9c-46c2-b949-38ef78858dd0,'2012-06-01 08:00:00','My funny cat');

INSERT INTO username_video_index (username, videoid, upload_date, videoname) 
VALUES ('tcodd',b3a76c6b-7c7f-4af6-964f-803a9283c401,'2012-08-30 16:50:00','Now my dog plays piano!');

INSERT INTO username_video_index (username, videoid, upload_date, videoname) 
VALUES ('tcodd',06049cbb-dfed-421f-b889-5f649a0de1ed,'2012-08-30 18:50:00','Now my dog plays piano too!');

INSERT INTO tag_index (tag, videoid, timestamp) VALUES ('cats',99051fe9-6a9c-46c2-b949-38ef78858dd0, '2012-05-25 08:30:29');
INSERT INTO tag_index (tag, videoid, timestamp) VALUES ('piano',99051fe9-6a9c-46c2-b949-38ef78858dd0, '2012-05-25 08:30:29');
INSERT INTO tag_index (tag, videoid, timestamp) VALUES ('lol',99051fe9-6a9c-46c2-b949-38ef78858dd0, '2012-05-25 08:30:29');
INSERT INTO tag_index (tag, videoid, timestamp) VALUES ('dogs',b3a76c6b-7c7f-4af6-964f-803a9283c401, '2012-05-25 08:30:29');
INSERT INTO tag_index (tag, videoid, timestamp) VALUES ('piano',b3a76c6b-7c7f-4af6-964f-803a9283c401, '2012-05-25 08:30:29');
INSERT INTO tag_index (tag, videoid, timestamp) VALUES ('lol',b3a76c6b-7c7f-4af6-964f-803a9283c401, '2012-05-25 08:30:29');

// Video Rating counters
UPDATE video_rating SET rating_counter = rating_counter + 3, rating_total = rating_total + 1 
WHERE videoid = 99051fe9-6a9c-46c2-b949-38ef78858dd0;

UPDATE video_rating SET rating_counter = rating_counter + 5, rating_total = rating_total + 1 
WHERE videoid = 99051fe9-6a9c-46c2-b949-38ef78858dd0;

UPDATE video_rating SET rating_counter = rating_counter + 4, rating_total = rating_total + 1 
WHERE videoid = 99051fe9-6a9c-46c2-b949-38ef78858dd0;

// Insert in pairs
// This is done using the batch command to group our operations.
BEGIN BATCH
   INSERT INTO comments_by_video (videoid,username,comment_ts, comment) 
   VALUES (99051fe9-6a9c-46c2-b949-38ef78858dd0,'tcodd','2012-05-25 10:30:10', 'Worst. Video. Ever.')
   INSERT INTO comments_by_user (videoid,username,comment_ts, comment) 
   VALUES (99051fe9-6a9c-46c2-b949-38ef78858dd0,'tcodd','2012-05-25 10:30:10', 'Worst. Video. Ever.')
APPLY BATCH;

BEGIN BATCH
   INSERT INTO comments_by_video (videoid,username,comment_ts, comment) 
   VALUES (99051fe9-6a9c-46c2-b949-38ef78858dd0,'cdate','2012-05-25 08:30:29', 'It is amazing')
   INSERT INTO comments_by_user (videoid,username,comment_ts, comment) 
   VALUES (99051fe9-6a9c-46c2-b949-38ef78858dd0,'cdate','2012-05-25 08:30:29', 'It is amazing')
APPLY BATCH;

// Video events
INSERT INTO video_event (videoid, username, event, event_timestamp, video_timestamp) 
VALUES (99051fe9-6a9c-46c2-b949-38ef78858dd0,'tcodd','start',now(),0);
INSERT INTO video_event (videoid, username, event, event_timestamp, video_timestamp) 
VALUES (99051fe9-6a9c-46c2-b949-38ef78858dd0,'tcodd','stop',now(),30000);
INSERT INTO video_event (videoid, username, event, event_timestamp, video_timestamp) 
VALUES (99051fe9-6a9c-46c2-b949-38ef78858dd0,'tcodd','start',now(),3000);
INSERT INTO video_event (videoid, username, event, event_timestamp, video_timestamp) 
VALUES (99051fe9-6a9c-46c2-b949-38ef78858dd0,'tcodd','stop',now(),230000);

// User purchases credits.
//   - credit_transaction record created at LOCAL_QUORUM with type=ADD and timestamp of transaction.
//   - If successful: Read User record with total_credits and credit_date. 
//        If user.credit_change_date < credit_transaction.datetime
//          add credits. set back into User with new credit_change_date
          
INSERT INTO credit_transaction (username,type,datetime,credits) 
VALUES ('tcodd','ADD','2013-04-25 21:10:32.745',10);

SELECT total_credits,credit_change_date
FROM users
WHERE username='tcodd';

// Insert logic here

UPDATE users 
SET credit_change_date='2012-09-02 18:05:00',total_credits=10
WHERE username='tcodd';


// User purchases view with 1 credit
//   - credit_transaction record created at LOCAL_QUORUM with type=REMOVE and timestamp of transaction
//   - If successful: Read User record with total_credits and credit_date.
//        If user.credit_change_date < credit_transaction.datetime
//           subtract credits. set back into User with new credit_change_date  

INSERT INTO credit_transaction (username,type,datetime,credits) 
VALUES ('tcodd','REMOVE','2012-09-02 18:10:00',1);

SELECT total_credits,credit_change_date
FROM users
WHERE username='tcodd';

UPDATE users 
SET credit_change_date='2012-09-02 18:10:00',total_credits=9
WHERE username='tcodd';

SELECT * from credit_transaction;


