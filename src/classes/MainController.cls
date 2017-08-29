global with sharing class MainController {
	public MainController() {}
    
    @RemoteAction
    global static String userLogin(String username, String password) {
        return Authentication.authenticateUser(username, password);
    }

    @RemoteAction
    global static Boolean validateToken(String username, String token) {
        return Authentication.validateToken(username, token);
    }
}