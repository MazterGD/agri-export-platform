import ballerina/http;
import agri_backend.store;
import agri_backend.auth;
import agri_backend.services;
import ballerina/time;

// Initialize the database client
store:Client dbClient = check new ();

// Initialize auth service
auth:AuthService authService = new(dbClient);

// Initialize business services
services:UserService userService = new(dbClient);
services:CropService cropService = new(dbClient);

@http:ServiceConfig {
    auth: [
        {
            jwtValidatorConfig: auth:jwtConfig,
            scopes: ["admin", "farmer", "buyer_agent"]
        }
    ],
    cors: {
        allowOrigins: ["http://localhost:3000", "https://yourapp.com"],
        allowCredentials: false,
        allowHeaders: ["Authorization", "Content-Type"],
        allowMethods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    }
}
service /api/v1 on new http:Listener(9090) {
    resource function get health() returns json {
        return {
            "status": "UP", 
            "timestamp": time:utcNow().toString(),
            "service": "Agricultural Export Platform API"
        };
    }

    resource function get profile(http:RequestContext ctx) returns json|error {
        auth:AuthContext authContext = check authService.getAuthContext(ctx);
        return userService.getUserProfile(authContext);
    }

    resource function get admin/users(http:RequestContext ctx) returns json[]|error {
        auth:AuthContext authContext = check authService.getAuthContext(ctx);
        
        if !authService.hasRole(authContext, "admin") {
            return error("Insufficient permissions");
        }
        
        return userService.getAllUsers();
    }

    resource function get crops(http:RequestContext ctx) returns json[]|error {
        auth:AuthContext authContext = check authService.getAuthContext(ctx);
        
        if !authService.hasAnyRole(authContext, ["admin", "farmer", "buyer_agent"]) {
            return error("Insufficient permissions");
        }
        
        return cropService.getCrops(authContext);
    }

    resource function post crops(@http:Payload services:CropCreateRequest request,
                               http:RequestContext ctx) returns json|error {
        auth:AuthContext authContext = check authService.getAuthContext(ctx);
        
        if !authService.hasAnyRole(authContext, ["admin", "farmer"]) {
            return error("Insufficient permissions");
        }
        
        return cropService.createCrop(request, authContext);
    }
}
