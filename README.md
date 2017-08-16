# Pre-work - TipApp

TipApp is a tip calculator application for iOS.

Submitted by: Charmaine Chammag

Time spent: 4 days spent in total (I'm very much new to the tool, hence the time spent.)

## User Stories

The following **required** functionality is complete:

* [X] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [X] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [X] UI animations
* [X] Remembering the bill amount across app restarts (if <10mins).
* [X] Using locale-specific currency and currency thousands separators.
* [X] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [X] Split bill function
- [X] Auto-layout
- [X] Included an Icon App

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='https://github.com/chammycl/TipApp/blob/master/TipApp.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:**

The first time I launched XCode, I felt overwhelmed. I was a bit lost with all icons and pane-views. The video walkththrough on the TipApp was really helpful and as I was building the app myself, I enjoyed clicking and dragging from the storyboard. :) If I were talking to another developer, I would describe that the outlets and actions are built-in tools where I can build and plug-in my functions to. I came from a top-down background approach in programming, so to be able to program and develop with a drag and drop concept is really cool and convenient. I like the idea of just dragging an event to the code editor and directly code the function for it.

It is really so cool to learn that under the hood, the everything is being built in HTML! So developing an app actually means generating a code in HTML. That's really fun! :)

Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:**

Based on how I understood it, closures are functions you can write or define for a parameter. This means being able to optimize or write shorter codes that can directly be used or applied to a parameter without compromising it's function or definition. The closures defined, can then be used for different parameters/variables within the class or function it was defined.

Furthermore, to be able to get a strong reference cycle for a closure, an instance of the closure - perhaps defined within a class - must be created. The link between the class and the instance will keep the reference to the closure strong, meaning the definitions and data defined within that closure will continue to be retained for that instance.

Hope I got the concept.


## License

    Copyright [2017] [Charmaine Chammag]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
