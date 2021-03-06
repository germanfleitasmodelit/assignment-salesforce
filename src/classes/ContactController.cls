global class ContactController {
	global ContactController() {}

	global static ID createContact (String firstName, String lastName) {
        Id contactId = null;
		Contact c = new Contact(FirstName = firstName, LastName = lastName);

		try{
			insert c;
			contactId = c.Id;
		}
		catch (DmlException e) {
			ContactController.ExceptionMessage(e.getMessage());
		}
		
		return contactId;
    }

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
			ContactController.ExceptionMessage(e.getMessage());
		}
        
        return editOK;
    }

	global static Boolean deleteContact(String contactId){
		Boolean deleteOK = false;

		try{
			Contact c = [SELECT Id FROM Contact WHERE Id = :contactId];
        	delete c;
			deleteOK = true;
		}
		catch (DmlException e) {
			ContactController.ExceptionMessage(e.getMessage());
		}
        
		return deleteOK;
	}

	global static List<Contact> listUsers(){
		List<Contact> contacts = null;

		try{
			contacts = [SELECT Id, gerdev__Username__c, gerdev__Auth_Token__c, FirstName, LastName FROM Contact];
		}
		catch (DmlException e) {
			ContactController.ExceptionMessage(e.getMessage());
		}

		return contacts;
	}

	global static Contact getUserByUsername(String username){
		Contact c = null;
		
		try{
			/* List<Contact> contacts = ContactController.listUsers();
			Integer i = 0;
			Integer length = contacts.size(); */
            c = [SELECT Id, gerdev__Username__c, gerdev__Auth_Token__c, FirstName, LastName FROM Contact WHERE gerdev__Username__c = :username];
		}
		catch(DmlException e){
			ContactController.ExceptionMessage(e.getMessage());
		}

		return c;
	}

	global static Contact getUserWithPassword(String username, String password){
		Contact c = null;
		
		try{
            c = [SELECT Id, gerdev__Username__c, gerdev__Password__c  
				FROM Contact WHERE gerdev__Username__c = :username AND gerdev__Password__c = :password];
		}
		catch(DmlException e){
			ContactController.ExceptionMessage(e.getMessage());
		}

		return c;
	}

	global static Contact saveGeneratedToken(Contact c, String token){
		try{
            c.gerdev__Auth_Token__c = token;
			update c;
		}
		catch(DmlException e){
			ContactController.ExceptionMessage(e.getMessage());
		}

		return c;
	}

	private static void ExceptionMessage(String message){
		System.debug('The following exception has occurred: ' + message);
	}
}