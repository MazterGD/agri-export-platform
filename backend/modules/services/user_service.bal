import agri_backend.store;
import agri_backend.auth;

public class UserService {
    private final store:Client dbClient;

    public function init(store:Client dbClient) {
        self.dbClient = dbClient;
    }

    public function getUserProfile(auth:AuthContext authContext) returns json|error {
        return {
            "userId": authContext.userId,
            "email": authContext.email,
            "roles": authContext.roles,
            "asgardeoUserId": authContext.asgardeoUserId
        };
    }

    public function getAllUsers() returns json[]|error {
        stream<store:User, error?> userStream = self.dbClient->/users;
        return from store:User user in userStream
               select {
                   "id": user.id,
                   "email": user.email,
                   "role": user.role,
                   "status": user.status,
                   "createdAt": user.createdAt.toString()
               };
    }
}
