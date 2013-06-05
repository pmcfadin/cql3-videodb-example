cql3-videodb-example
====================

This uses the DataStax Java driver with a full CQL3 application example

Data Model

users
videos

username_video_index
tag_index
comments_by_video
comments_by_user

video_rating
video_event
credit_transaction


getUserByUsernameUsingString
============================


getUserByUsernameUsingPreparedStatement
=======================================


getUserByUsernameUsingQueryBuilder
==================================


getVideoByIdUsingQueryBuilder
=============================
Different retry policy

getVideosByUsernameUsingAsyncRead
=================================
Uses username_video_index to find all videos for a user
Basic AsyncRead


getRatingForVideo
=================
Selects counter values, does the math an returns the average

setRatingForVideo
=================
Adds a rating to a video


getVideosByTagsUsingAsyncReadThreads
====================================
Uses username_video_index to find all videos for a user
Concurrent threads executing an AsyncRead

getVideosByTagUsingAsyncRead
============================


setCommentForVideo
==================
Set a comment. Demonstrate setting both tables with a batch.


getCommentsByUsernameUsingPreparedStatement
===========================================
Grab a list of comments from a username perspective

getCommentsByVideoIdUsingPreparedStatement
===========================================
Grab a list of comments from a Video ID perspective


getLastStopEvent
================
Query the video event table and find the last stop event for a video and user

addCreditForUser
================
Demonstrate how to simulate a transaction for adding a credit to a user account

removeCreditForUser
===================
Now remove a credit using the same type of transaction type semantics