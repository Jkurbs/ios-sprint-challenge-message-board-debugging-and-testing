
# BUGS 

## Bugs found while testing 

### Thread creation 

* Url session resuming not called
Calling *.resume* at the end of the urlSession should fix the problem 

* Expected to decode Array<Any> but found a dictionary instead.
Turning *[MessageThread].self* to *MessageThread.self* should fix the problem 


### Thread fetching 

* Expected to decode Array<Any> but found a dictionary instead.
Turning *[MessageThread].self* to *[String:MessageThread].self* should fix the problem


### Message creation 

* Messages not being created 
* MessageThreadDetailTableViewController not dismissing



### Message fetching 

1. Url session resuming not working 
// Resuming url session should fix the problem 

2. "Expected to decode Array<Any> but found a dictionary instead.
// Decoding an dictionary

2. Create message viewcontroller not dismissing 
// Calling pop view controller should fix the problem

3. Fetch message threads not working 
// Creating urlsession from request should fix it 

