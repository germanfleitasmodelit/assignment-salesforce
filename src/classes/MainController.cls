global with sharing class MainController {
	public MainController() {}
    
    @RemoteAction
    global static String userLogin(String username, String password) {
        return Authentication.authenticateUser(username, password);
    }
}