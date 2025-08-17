import ballerina/http;
import ballerina/jwt;
import ballerina/log;
import ballerina/time;
import agri_backend.store;

public type AuthContext record {
    string userId;
    string email;
    string[] roles;
    string asgardeoUserId;
};

public class AuthService {
    private final store:Client dbClient;

    public function init(store:Client dbClient) {
        self.dbClient = dbClient;
    }

    public function getAuthContext(http:RequestContext ctx) returns AuthContext|error {
        [jwt:Header, jwt:Payload] jwtInfo = check ctx.getWithType(http:JWT_INFORMATION);
        jwt:Payload payload = jwtInfo[1];

        string asgardeoUserId = <string>payload.sub;
        string email = <string>payload["email"];
        string[]? groups = <string[]?>payload["groups"];

        string localUserId = check self.getOrCreateLocalUser(asgardeoUserId, email);
        string[] roles = groups ?: [];

        return {
            userId: localUserId,
            email: email,
            roles: roles,
            asgardeoUserId: asgardeoUserId
        };
    }

    public function getOrCreateLocalUser(string asgardeoUserId, string email) returns string|error {
    string cacheKey = string `user:${asgardeoUserId}`;
    any|error cachedResult = roleCache.get(cacheKey);
    
    if cachedResult is string {
        return cachedResult;
    }

    stream<record {}, error?> userStream = self.dbClient->/users(targetType = store:User, 
        whereClause = `WHERE email = ${email}`);
    
    record {}[] users = check from record {} user in userStream select user;
    
    if users.length() > 0 {
        store:User existingUser = <store:User>users[0];
        error? cacheError = roleCache.put(cacheKey, existingUser.id);
        if cacheError is error {
            log:printError("Failed to cache user ID", cacheError);
        }
        return existingUser.id;
    }

    string newUserId = self.generateUserId();
    time:Civil currentTime = time:utcToCivil(time:utcNow());
    
    store:UserInsert newUser = {
        id: newUserId,
        email: email,
        passwordHash: (), // null for Asgardeo users
        role: store:FARM_USER,
        status: store:ACTIVE,
        createdAt: currentTime,
        updatedAt: currentTime,
        asgardeoUserId: asgardeoUserId,
        lastLogin: (), // null since user hasn't logged in yet
        loginCount: 0  // initialize to 0
    };

    string[] createdIds = check self.dbClient->/users.post([newUser]);
    string createdUserId = createdIds[0];

    error? cacheError = roleCache.put(cacheKey, createdUserId);
    if cacheError is error {
        log:printError("Failed to cache new user ID", cacheError);
    }
    
    return createdUserId;
}

    public function hasRole(AuthContext authContext, string requiredRole) returns boolean {
        return authContext.roles.indexOf(requiredRole) != ();
    }

    public function hasAnyRole(AuthContext authContext, string[] requiredRoles) returns boolean {
        foreach string role in requiredRoles {
            if self.hasRole(authContext, role) {
                return true;
            }
        }
        return false;
    }

    private function generateUserId() returns string {
        return "user_" + time:utcNow()[0].toString();
    }
}
