public class Authentication {

    public String authenticateUser (String username, String password){
        String authToken = null;

        if(username.length() > 0 && password.length() > 0){
            String enteredPassHash = this.encryptPassword(password);

            if(this.validateToken(username, enteredPassHash)){
                authToken = enteredPassHash;
            }
        }

        return authToken;
    }

    private Boolean validateToken (String username, String token){
        Boolean tokenOK = false;
        Contact c = ContactController.getUserByUsername(username);

        if(c != null){
            tokenOK = c.Username__c.equals(username) && c.Auth_Token__c.equals(token);
        }

        return tokenOK;
    }

    private String encryptPassword (String password){
        String authToken = null;

        if(password.length() > 0){
            Blob targetBlob = Blob.valueOf(password);
            Blob hash = Crypto.generateDigest('MD5', targetBlob);
            authToken = EncodingUtil.base64Encode(hash);
        }

        return authToken;
    }
}