public class Authentication {

    public static String authenticateUser (String username, String password){
        String authToken = null;

        if(username != null && password != null){
            String enteredPassHash = Authentication.encryptPassword(password);

            if(Authentication.validateToken(username, enteredPassHash)){
                authToken = enteredPassHash;
            }
        }

        return authToken;
    }

    public static Boolean validateToken (String username, String token){
        Boolean tokenOK = false;
        Contact c = ContactController.getUserByUsername(username);
		System.debug(c.gerdev__Username__c);
        if(c != null){
            tokenOK = c.gerdev__Username__c.equals(username) && c.gerdev__Auth_Token__c.equals(token);
        }
        System.debug(tokenOK);

        return tokenOK;
    }

    private static String encryptPassword (String password){
        String authToken = null;

        if(password.length() > 0){
            Blob targetBlob = Blob.valueOf(password);
            Blob hash = Crypto.generateDigest('MD5', targetBlob);
            authToken = EncodingUtil.base64Encode(hash);
        }

        return authToken;
    }
}