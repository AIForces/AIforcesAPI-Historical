# API Documentation

## User

### create

Method: POST

URL: users/create

Arguments:

 * username
 * name
 * surname
 * password
 * password_confirmation
 
Create new user with following data.

### destroy

Not implemented

### edit

Not implemented.

## Session

### auth

Method: POST

URL: users/auth

Arguments:

* username
* password

Try to login and create new session.

### logout

Method: GET

URL: users/logout

Destroy current session.

## Challenge

### create

Method: POST

URL: challenge/create

Arguments:

* id
* sub1
* sub2
* level (soon will be deprecated and changed to state_par)

Create new challenge.

### destroy

Method: GET

URL: challenge/destroy

Arguments:

* id

Destroy challenge

### rejudge

Method: GET

URL: challenge/rejudge

Arguments:

* id

Rejudge challenge.

### log

Method: POST

URL: challenge/log

Arguments:

* id
* format (json or none)

Get log of the challenge. Ask for json format if you need it.

### get_info

Method: POST

URL: challenge/get_info

Arguments:

* id

Get some info about challenge in json format.

### get_streams

Method: POST

URL: challenge/get_streams

Arguments:

* id
* streams[]
* players[]

Get stdin/stdout/stderr output of the challenge submissions.

### receive_data

Method: POST

URL: challenge/receive_data

Arguments:
* challenge_id
* player1_verdict 
* player2_verdict 
* winner
* log

Receive log from judge
 
### update_status

Method: POST

URL: challenge/update_status

Arguments:

* challenge_id
* step
* stage

Update judging status.


## Judge

### update_status

Not implemented.

## Submission

### create

Method: POST

URL: submissions/create

Arguments:

* name
* compiler
* code

Create new submission

### destroy

Method: GET

URL: submissions/destroy

Arguments:

* id

Destroy submission.

### make_used_for_tours

Method: GET

URL: submissions/make_used_for_tours

Arguments:
* id

Make submission used for tours.

### make_opened

Method: GET

URL: submissions/make_opened

Arguments:
* id

Make submission opened for others.

## Tournament

### create
Method: POST

URL: tournament/create

Arguments:

* name
* number_of_ch_per_pair (Soon will be deprecated and changed to configuration)
