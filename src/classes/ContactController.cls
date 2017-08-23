@RestResource(urlMapping='/Contacts/*')
global with sharing class ContactController {

	public static Contact contact {get; set;}
	public ContactController() {}

	@HttpPost
    global static ID createContact (String firstName, String lastName) {
        Id contactId = null;
		Contact c = new Contact(FirstName = firstName, LastName = lastName);

		try{
			insert c;
			contactId = c.Id;
		}
		catch (DmlException e) {
			ExceptionMessage(e.getMessage());
		}
		
		return contactId;
    }

	@HttpPatch
    global static Boolean editContact(Id contactId, String firstName, String lastName) {
		Boolean editOK = false;

		try{
			Contact c = [SELECT FirstName, LastName FROM Contact WHERE Id = :contactId];
			c.FirstName = firstName;
			c.LastName = lastName;

			update c;
			editOK = true;
		}
		catch (DmlException e) {
			ExceptionMessage(e.getMessage());
		}
        
        return editOK;
    }

	global static Boolean deleteContact(String contactId){
		return deleteUser();
	}

	@HttpDelete
    global static Boolean deleteUser() {
		Boolean deleteOK = false;

		try{
			contact = [SELECT Id FROM Contact WHERE Id = :contact.Id];
        	delete contact;
			deleteOK = true;
		}
		catch (DmlException e) {
			ExceptionMessage(e.getMessage());
		}
        
		return deleteOK;
    }

	@HttpGet
	global static List<Contact> listUsers(){
		List<Contact> contacts = null;

		try{
			contacts = [SELECT Id FROM Contact];
		}
		catch (DmlException e) {
			ExceptionMessage(e.getMessage());
		}

		return contacts;
	}

	/* public static Contact getUserByUsername(String username){
		Contact c = null;

		try{
			c = [select Username__c, Auth_Token__c from Contact where Username__c = :username];
		}
		catch(DmlException e){
			ExceptionMessage(e.getMessage());
		}

		return c;
	} */

	/* @HttpGet
	global static Contact getUserById(){
		Contact c = null;

		RestRequest request = RestContext.request;
        String contactId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);

        c =  [SELECT Username__c,Auth_Token__c,Id FROM Contact WHERE Id = :contactId];

		return c;
	} */

	private static void ExceptionMessage(String message){
		System.debug('The following exception has occurred: ' + message);
	}
}