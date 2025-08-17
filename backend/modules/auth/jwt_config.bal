import ballerina/http;
import ballerina/cache;

configurable string asgardeoOrgName = "codecrewuom";
configurable string asgardeoClientId = ?;

// Build URLs using string concatenation instead of template literals
string issuerUrl = "https://api.asgardeo.io/t/" + asgardeoOrgName + "/oauth2/token";
string jwksUrl = "https://api.asgardeo.io/t/" + asgardeoOrgName + "/oauth2/jwks";

public final http:JwtValidatorConfig jwtConfig = {
    issuer: issuerUrl,
    audience: [asgardeoClientId],
    signatureConfig: {
        jwksConfig: {
            url: jwksUrl,
            clientConfig: {}
        }
    },
    clockSkew: 300
};

// Cache for user roles to avoid repeated database calls
public final cache:Cache roleCache = new({
    capacity: 1000,
    evictionFactor: 0.25,
    defaultMaxAge: 900
});