public class ContactController {
	public ContactController() {}

	public static ID createContact (String firstName, String lastName) {
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

	public static Boolean editContact(Id contactId, String firstName, String lastName) {
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

	public static Boolean deleteContact(String contactId){
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

	public static List<Contact> listUsers(){
		List<Contact> contacts = null;

		try{
			contacts = [SELECT Id FROM Contact];
		}
		catch (DmlException e) {
			ContactController.ExceptionMessage(e.getMessage());
		}

		return contacts;
	}

	public static Contact getUserByUsername(String username){
		Contact c = null;
		
		try{
			List<Contact> contacts = ContactController.listUsers();
			Integer i = 0;
			Integer length = contacts.size();

			while(i<length && c == null){

				if(contacts[i].Username__c.equals(username)){
					c = contacts[i];
				}
				
				i++;
			}
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