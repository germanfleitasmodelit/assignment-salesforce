public class Authentication {

    public static String authenticateUser (String username, String password){
        String authToken = null;

        if(username != null && password != null){
            Contact c = ContactController.getUserWithPassword(username, password);

            if(c != null){
                authToken = Authentication.encryptPassword(password);
                ContactController.saveGeneratedToken(c, authToken);
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
            Blob targetBlob = Blob.valueOf('1000' + String.valueOf(Datetime.now().formatGMT('yyyy-MM-dd HH:mm:ss.SSS')) + password);
            Blob hash = Crypto.generateDigest('MD5', targetBlob);
            authToken = EncodingUtil.base64Encode(hash);
        }

        return authToken;
    }
}