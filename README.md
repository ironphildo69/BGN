# BGN
Scripts for Hosting a Game Community in an autonomous function.

While i'm often a fan of NOT reinventing the wheel I couldn't help but notice the solutions in the game server community in terms of automation and updating are ether bad, overpriced or often over engineered. After spending months investigating solutions for our community I came to the conclusion something had to be written from scratch. Unlike most communities that horde their internal design and scripts BGN is committed to making most of it open source for others to create their own communities. Software is designed to be invisible to the users and simply work, doing it's function without anyone knowing it is there. That is why I wrote this rather simple script. Combine it with crontab and systemD unit files and you have an automatic update feature that is fairly reliable, simple, doesn't cost and is using the UNIX philosophy of simple, small tools over a single monolithic one.

A Little Explaination:

Interestingly enough Steam DOES have a webapi but it is unreliable for a few games such as ARK. The solution around this was to get the SteamCMD client to check for and print the latest udpate info and grep it then compare it to the stored value. For some reason some developers dont seem to update the webAPI value but thankfully the branch ID has "buildID's" which makes this meathod rather reliable.