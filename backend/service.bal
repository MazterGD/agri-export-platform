import ballerina/http;
import agri_backend.store;

// Initialize the database client
store:Client dbClient = check new ();

service / on new http:Listener(9090) {
    // Your existing greeting resource
    resource function get greeting(string? name) returns string|error {
        if name is () {
            return error("name should not be empty!");
        }
        return string `Hello, ${name}`;
    }
    
    // Add a simple endpoint that uses the database
    resource function get users() returns store:User[]|error {
        stream<store:User, error?> userStream = dbClient->/users;
        return from store:User user in userStream select user;
    }
}