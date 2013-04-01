# [ZouReview](http://www.zoureview.com/courses)

This is a Ruby on Rails application that I've been working on alongside [BerkeleyX CS169x: Software as a Service](https://www.edx.org/courses/BerkeleyX/CS169.2x/2013_Spring/about).  The class has been amazing, and I've learned a lot.  Rails is also a ton of fun.  So far, I haven't had as much time as I would like in order to work on this, but I hope to work on it more soon.

The vision for this website is for it to be a hub for Mizzou (University of Missouri - Columbia) grade distribution data.  Eventually I'd like for it to host reviews of the courses as well.  


## What I've done

The current site lives at [ZouReview.com](http://www.zoureview.com/courses) and is currently lacking in design and functionality.  I have written a crawler that allows me to import all of Mizzou's grade distribution info from [here](https://musis1.missouri.edu/gradedist/mu_grade_dist_intro.cfm#CGI.script.name#) with an admin backend.  It uses a [DelayedJob](https://github.com/collectiveidea/delayed_job) on a Heroku worker with [Workless](https://github.com/lostboy/workless) to manage the import in the background.  As of now, the site only simply paginates courses ordered by average GPA.  I'd like to add a lot more functionality.  The experience has been great though, and I love TDD thus far.  Red, green, refactor!


## Todo
There's a lot left to do.  Including:
* Come up with a semidecent design..  I'd appreciate any help here.
* Caching.  Cache alllll the things!  Because (at least until I add review capabilities), pretty much everything can be cached.
* Search capabilities
* Course review capabilities
* Ability to view instructors/sections individually.  

If you'd like to help, feel free to submit a pull request :)  I also greatly appreciate any feedback or criticism -- I'd love to see how things could be better!
