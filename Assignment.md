You are building an online learning platform. You’ve got many different courses, each with a title and description, and each course has multiple lessons. Lesson content consists of a title and body text.
```ruby
Courses
-------

title: string [unique, 10-80 chars, present]
description: string [ 50-300, present]
id:integer
created_at:datetime
updated_at:datetime


has_many: lessons


Lessons
-------

title: string [unique, 10-80 chars, present]
description: string [ 50-800 chars, present]
id:integer
created_at:datetime
updated_at:datetime

belongs_to: course

```

You are building the profile tab for a new user on your site. You are already storing your user’s username and email, but now you want to collect demographic information like city, state, country, age and gender. Think – how many profiles should a user have? How would you relate this to the User model?

```ruby

Users
-----

username: string [unique, 4-24 chars, present]
email: string [unique, 10-30 chars, present]
id:integer
created_at:datetime
updated_at:datetime

has_one: demographic

Demographics
------------

city: string
state:string
country:string
age:integer
gender:boolean
id:integer
created_at:datetime
updated_at:datetime

has_one: user
```

You want to build a virtual pinboard, so you’ll have users on your platform who can create “pins”. Each pin will contain the URL to an image on the web. Users can comment on pins (but can’t comment on comments).
```ruby
Users
-----

username: string [unique, 4-24 chars, present]
email: string [unique, 10-30 chars, present]
id:integer
created_at:datetime
updated_at:datetime

has_many: pins
has_many: comments

Pins
----

url: string[unique, format, present]
id:integer
created_at:datetime
updated_at:datetime

has_many: comments
belongs_to: user

Comments
--------
body: string[>3 chars, present]
id:integer
created_at:datetime
updated_at:datetime

belongs_to: pin
belongs_to: user
```