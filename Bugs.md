
# BUGS 

## Unit Testing Bugs

### Thread creation 

* Url session resuming not called

Calling *.resume* at the end of the urlSession should fix the problem 

* Expected to decode Array<Any> but found a dictionary instead.

Turning *[MessageThread].self* to *MessageThread.self* should fix the problem 


### Thread fetching 

* Data is being duplicated 

Making network call from viewDidLoad should fix the error 

* Expected to decode Array<Any> but found a dictionary instead.

Turning *[MessageThread].self* to *[String:MessageThread].self* should fix the problem
Looping through the dictionnary and appending the value to the messageThread array should populate the tableview.

* Thread with message are not being returned.

Decoding messages as a *[String: Message].self* should solve the problem 

### Message creation 

* Messages not being created 
* MessageThreadDetailTableViewController not dismissing


### Message fetching 

1. Url session resuming not working 
// Resuming url session should fix the problem 

2. "Expected to decode Array<Any> but found a dictionary instead.
// Decoding an dictionary

3. Fetch message threads not working 
// Creating urlsession from request should fix it 



## UI Testing Bugs

### MessageThreadsTableViewController

*  keyNotFound(CodingKeys(stringValue: "messageText"))

Change messageText to message should fix the error

### MessageThreadDetailTableViewController

* messageThread <uninitialized>
Changing the segue.identifier from *"AddMesage"* to *"AddMessage"* should fixed it 


* Create message viewcontroller not dismissing 
 Calling pop view controller should fix the problem
