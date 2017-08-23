global with sharing class ContactControllerExtension {

    public ContactControllerExtension(ContactController contactCtrl) {
        /* this.mysObject = (sObject)stdController.getRecord(); */
    }

    @RemoteAction
    global static ID createContact (String username, String token, String firstName, String lastName){
        ID contactId = null;

        if (ContactControllerExtension.validateToken(username, token)) {
            contactId = ContactController.createContact(firstName, lastName);
        }

        return contactId;
    }

    @RemoteAction
    global static Boolean editContact (
        String username, 
        String token, 
        Id contactId, 
        String firstName, 
        String lastName){

        Boolean editOK = false;

        if (ContactControllerExtension.validateToken(username, token)) {
            editOK = ContactController.editContact(contactId, firstName, lastName);
        }

        return editOK;
    }

    @RemoteAction
    global static Boolean deleteContact(String username, String token, String contactId){
        Boolean deleteOK = false;

        if (ContactControllerExtension.validateToken(username, token)) {
            deleteOK = ContactController.deleteContact(contactId);
        }

        return deleteOK;
    }

    @RemoteAction
    global static List<Contact> listUsers(String username, String token){
        List<Contact> contacts = null;

        if (ContactControllerExtension.validateToken(username, token)) {
            contacts = ContactController.listUsers();
        }

        return contacts;
    }

    private static Boolean validateToken(String username, String token){
        return Authentication.validateToken(username, token);
    }
}