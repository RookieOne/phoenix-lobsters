# Discover of Features for Phoenix Lobster

## Ideas / Overview

The purpose of Lobster is a user driven content aggregator based on the site https://lobste.rs/

**Story** - Submissions by users with links to other websites and optional discussions
Users can comment on the stories and comment on other comments
Users can also vote on stories and comments

**Thread** - A thread is a series of related comments

**Subthread** - A subset of that thread

**Story Score** - Based on votes, comments, time of submission

## Models

#### Story
```
title: string
url: string
text: markdown
html: html
is_author: boolean
has_many tags
submission_date: datetime
submission_creator: user
slug: string
vote: integer
score: float
status: string
```

#### Comment
```
slug: string
text: markdown
html: html
belongs_to: story
belongs_to: comment
vote: integer
status: string
edited_by: user
edited_at: datetime
```

#### Tag
```
name: string
description: string
```

#### Story Title Suggestion
```
title: string
status: string
suggested_by: user
```

#### Story Tag Suggestion
```
status: string
has_many tags
suggested_by: user
```

#### User
```
email
password
description_text: markdown
description_html: html
```

#### Vote
```
belongs_to story
belongs_to comment
vote_type: string
upvote, none, downvote
vote_submitted_at: datetime
vote_by: user
```

#### Action Log
```
moderation_date: datetime
belongs_to story
belongs_to user
belongs_to comment
action: string
reason: string
```

## Users

Going to try to make these users identifiable by the permissions they have.

```
Users
Admins
Moderators
Visitors
```

## Permissions / Actions

* Create User
	* creates a user given an email and a password

* Create Story
	* creates a story with the passed in information: url, title, description, whether user is the author
	* story score changes

* Create Comment on Story
	* creates a comment on a story
	* story score changes

* Create Comment on Comment
	* creates a comment on a comment
	* story score changes

* Create Suggestion
	* create a story suggestion with title and tags

* Remove Story
	* changes story status to 'removed'
	* no longer visible on story discussion page
	* no longer visible on any page or url

* Remove Suggestion
	* changes suggestion status to 'removed'
	* no longer visible

* Remove User
	* removes all their story submissions
	* removes all their comments

* Apply Title Suggestion
	* changes story's title to suggested title

* Apply Tag Suggestion
	* changes story's tag to suggested tags

* Upvote Story
	* creates a Vote record for user and story
	* vote_type: upvote
	* increments story's vote count by one
	* story score changes

* Upvote Comment
	* creates a Vote record for user and comment
	* vote_type: upvote
	* increments comment's vote count by one
	* story score changes

* Remove Upvote from Story
	* changes Vote record for user to vote_type: none
	* decrements story's vote count by one
	* story score changes

* Remove Upvote from Comment
	* changes Vote record for user to vote_type: none
	* decrements story's vote count by one
	* story score changes

* Create Tag
	* creates tag with title and description

* Edit Tag
	* updates tag with new title and/or description

* Edit Story
	* updates story with new details

* Edit Comment
	* updates comment with new details
	* updates comment UI to show who edited comment and when it was edited

* Edit User Profile
	* updates profile for user

* Remove Comment
	* changes comments status to 'removed'
	* does not delete comment
	* does not delete thread
	* comment no longer displays normally but shows that comment was "Removed"

* Spoiler Comment
	* changes comments status to 'spoiler'
	* does not delete comment
	* does not delete thread
	* comment no longer displays normally but shows that comment was "Spoiler"
	* users can click 'Show spoiler' to see comment

* Score Story
	* calculates score for story based on yet undecided algorithm


## Pages

* Front Page
	* See all the stories ordered by their score
	* For each story we should see
		* name of the story
		* who submitted it
		* this changes whether they are the author or not
		* not authored by
		* authored by
		* image for user / gravatar
		* tags
		* current votes
		* domain for the story
		* shows current number of comments
		* if a story has text associated with it, we should show a text icon
	* Actions on each story
		* Title link
			* if the url exists, then it takes you to the url
			* if the url doesnt exist then it takes you to the Story Discussion page
		* Suggest link
			* takes you to the Suggest Story Changes page
			* lets you suggest change of title
		* Cache link
			* takes you to the url using archive.is
			* example https://archive.is/http://blog.carlosgaldino.com/2016/04/28/defusing-a-binary-bomb-with-gdb-part-5.html
			* we can use web.archive.org
example https://web.archive.org/web/*/http://www.xkcd.com
		* Hide link
			* Hides the story for you
		* Upvote
			* You can upvote a story
			* You can remove your upvote
		* Comments link
			* Goes to the comments on story on the Story Discussion page

* Story Discussion
	* url: https://lobste.rs/s/etb1t9/linux_infosec_outfit_does_a_torvalds_rageblocks_innocent_vuln_spotter
	* Shows comment threads
	* Each comment can be linked
		* url: https://lobste.rs/s/etb1t9/linux_infosec_outfit_does_a_torvalds_rageblocks_innocent_vuln_spotter#c_9obppf
	* Comments have their own votes
	* Comments have their own comments onto infinity
	* link to a comment
	* anchor to page and highlight comment
	* we can reply to a comment

* Suggest Story Changes
	* url: https://lobste.rs/stories/etb1t9/suggest
	* A user can suggestion a new title
	* A user can suggest new tags
	* Upon suggestion submission
	* the author gets notified
	* the author can accept the changes and it updates the story's title and tags

* Submit a Story
	* url: https://lobste.rs/stories/new
	* Form fields
		* URL
			* Fetch title will try to figure out the title of the story
			* optional
		* Title
			* required
		* Tags
			* required
			* set defined list of tags
			* can select many tags
		* Text
			* optional if you have a url but otherwise required
			* markdown
		* Whether you are the author or not
		* Story submission guidelines (just text giving the rules for the site)
	* Actions
		* Submit
			* Submits / creates story
		* Preview
			* Shows on the same page: title, tags, and text that has markdown converted

* Suggest a Tag
	* Users can suggest a tag

* Stories by Tag
	* url: https://lobste.rs/t/security

* Recent
	* The newest stories with a random sampling of recently submitted stories that have not yet reached the front page.

* Newest
	* Shows newest stores based on submission

* Comments
	* Shows latest comments for site
	* Can page through comments

* Your Threads
	* Show your comments
	* And any thread your comment is involved in

* Filters
	* Lets you set tags you do not want to see stories about on the homepage

* Moderation Log
	* url: https://lobste.rs/moderations
	* shows logs in reverse chronological order (most recent up top)
	* action logs filtered by X to be identified as a moderation log entry
	* most recent 50 action log entries
	* can page through logs
