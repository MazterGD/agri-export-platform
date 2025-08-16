// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/jballerina.java;
import ballerina/persist;
import ballerina/sql;
import ballerinax/persist.sql as psql;
import ballerinax/postgresql;
import ballerinax/postgresql.driver as _;

const USER = "users";
const FARMER = "farmers";
const BUYER_AGENT = "buyeragents";
const CROP = "crops";
const ORDER = "orders";
const ORDER_ITEM = "orderitems";

public isolated client class Client {
    *persist:AbstractPersistClient;

    private final postgresql:Client dbClient;

    private final map<psql:SQLClient> persistClients;

    private final record {|psql:SQLMetadata...;|} metadata = {
        [USER]: {
            entityName: "User",
            tableName: "User",
            fieldMetadata: {
                id: {columnName: "id"},
                email: {columnName: "email"},
                passwordHash: {columnName: "password_hash"},
                role: {columnName: "role"},
                status: {columnName: "status"},
                createdAt: {columnName: "created_at"},
                updatedAt: {columnName: "updated_at"},
                "farmer.id": {relation: {entityName: "farmer", refField: "id"}},
                "farmer.firstName": {relation: {entityName: "farmer", refField: "firstName", refColumn: "first_name"}},
                "farmer.lastName": {relation: {entityName: "farmer", refField: "lastName", refColumn: "last_name"}},
                "farmer.phone": {relation: {entityName: "farmer", refField: "phone"}},
                "farmer.address": {relation: {entityName: "farmer", refField: "address"}},
                "farmer.farmLocation": {relation: {entityName: "farmer", refField: "farmLocation", refColumn: "farm_location"}},
                "farmer.farmSize": {relation: {entityName: "farmer", refField: "farmSize", refColumn: "farm_size"}},
                "farmer.verificationStatus": {relation: {entityName: "farmer", refField: "verificationStatus", refColumn: "verification_status"}},
                "farmer.createdAt": {relation: {entityName: "farmer", refField: "createdAt", refColumn: "created_at"}},
                "farmer.userId": {relation: {entityName: "farmer", refField: "userId"}},
                "buyerAgent.id": {relation: {entityName: "buyerAgent", refField: "id"}},
                "buyerAgent.companyName": {relation: {entityName: "buyerAgent", refField: "companyName", refColumn: "company_name"}},
                "buyerAgent.contactPerson": {relation: {entityName: "buyerAgent", refField: "contactPerson", refColumn: "contact_person"}},
                "buyerAgent.phone": {relation: {entityName: "buyerAgent", refField: "phone"}},
                "buyerAgent.businessLicense": {relation: {entityName: "buyerAgent", refField: "businessLicense", refColumn: "business_license"}},
                "buyerAgent.verificationStatus": {relation: {entityName: "buyerAgent", refField: "verificationStatus", refColumn: "verification_status"}},
                "buyerAgent.createdAt": {relation: {entityName: "buyerAgent", refField: "createdAt", refColumn: "created_at"}},
                "buyerAgent.userId": {relation: {entityName: "buyerAgent", refField: "userId"}}
            },
            keyFields: ["id"],
            joinMetadata: {
                farmer: {entity: Farmer, fieldName: "farmer", refTable: "Farmer", refColumns: ["userId"], joinColumns: ["id"], 'type: psql:ONE_TO_ONE},
                buyerAgent: {entity: BuyerAgent, fieldName: "buyerAgent", refTable: "BuyerAgent", refColumns: ["userId"], joinColumns: ["id"], 'type: psql:ONE_TO_ONE}
            }
        },
        [FARMER]: {
            entityName: "Farmer",
            tableName: "Farmer",
            fieldMetadata: {
                id: {columnName: "id"},
                firstName: {columnName: "first_name"},
                lastName: {columnName: "last_name"},
                phone: {columnName: "phone"},
                address: {columnName: "address"},
                farmLocation: {columnName: "farm_location"},
                farmSize: {columnName: "farm_size"},
                verificationStatus: {columnName: "verification_status"},
                createdAt: {columnName: "created_at"},
                userId: {columnName: "userId"},
                "user.id": {relation: {entityName: "user", refField: "id"}},
                "user.email": {relation: {entityName: "user", refField: "email"}},
                "user.passwordHash": {relation: {entityName: "user", refField: "passwordHash", refColumn: "password_hash"}},
                "user.role": {relation: {entityName: "user", refField: "role"}},
                "user.status": {relation: {entityName: "user", refField: "status"}},
                "user.createdAt": {relation: {entityName: "user", refField: "createdAt", refColumn: "created_at"}},
                "user.updatedAt": {relation: {entityName: "user", refField: "updatedAt", refColumn: "updated_at"}},
                "crops[].id": {relation: {entityName: "crops", refField: "id"}},
                "crops[].cropType": {relation: {entityName: "crops", refField: "cropType", refColumn: "crop_type"}},
                "crops[].variety": {relation: {entityName: "crops", refField: "variety"}},
                "crops[].grade": {relation: {entityName: "crops", refField: "grade"}},
                "crops[].quantity": {relation: {entityName: "crops", refField: "quantity"}},
                "crops[].unit": {relation: {entityName: "crops", refField: "unit"}},
                "crops[].pricePerUnit": {relation: {entityName: "crops", refField: "pricePerUnit", refColumn: "price_per_unit"}},
                "crops[].harvestDate": {relation: {entityName: "crops", refField: "harvestDate", refColumn: "harvest_date"}},
                "crops[].expiryDate": {relation: {entityName: "crops", refField: "expiryDate", refColumn: "expiry_date"}},
                "crops[].description": {relation: {entityName: "crops", refField: "description"}},
                "crops[].status": {relation: {entityName: "crops", refField: "status"}},
                "crops[].createdAt": {relation: {entityName: "crops", refField: "createdAt", refColumn: "created_at"}},
                "crops[].farmerId": {relation: {entityName: "crops", refField: "farmerId"}}
            },
            keyFields: ["id"],
            joinMetadata: {
                user: {entity: User, fieldName: "user", refTable: "User", refColumns: ["id"], joinColumns: ["userId"], 'type: psql:ONE_TO_ONE},
                crops: {entity: Crop, fieldName: "crops", refTable: "Crop", refColumns: ["farmerId"], joinColumns: ["id"], 'type: psql:MANY_TO_ONE}
            }
        },
        [BUYER_AGENT]: {
            entityName: "BuyerAgent",
            tableName: "BuyerAgent",
            fieldMetadata: {
                id: {columnName: "id"},
                companyName: {columnName: "company_name"},
                contactPerson: {columnName: "contact_person"},
                phone: {columnName: "phone"},
                businessLicense: {columnName: "business_license"},
                verificationStatus: {columnName: "verification_status"},
                createdAt: {columnName: "created_at"},
                userId: {columnName: "userId"},
                "user.id": {relation: {entityName: "user", refField: "id"}},
                "user.email": {relation: {entityName: "user", refField: "email"}},
                "user.passwordHash": {relation: {entityName: "user", refField: "passwordHash", refColumn: "password_hash"}},
                "user.role": {relation: {entityName: "user", refField: "role"}},
                "user.status": {relation: {entityName: "user", refField: "status"}},
                "user.createdAt": {relation: {entityName: "user", refField: "createdAt", refColumn: "created_at"}},
                "user.updatedAt": {relation: {entityName: "user", refField: "updatedAt", refColumn: "updated_at"}},
                "orders[].id": {relation: {entityName: "orders", refField: "id"}},
                "orders[].totalAmount": {relation: {entityName: "orders", refField: "totalAmount", refColumn: "total_amount"}},
                "orders[].status": {relation: {entityName: "orders", refField: "status"}},
                "orders[].createdAt": {relation: {entityName: "orders", refField: "createdAt", refColumn: "created_at"}},
                "orders[].updatedAt": {relation: {entityName: "orders", refField: "updatedAt", refColumn: "updated_at"}},
                "orders[].buyeragentId": {relation: {entityName: "orders", refField: "buyeragentId"}}
            },
            keyFields: ["id"],
            joinMetadata: {
                user: {entity: User, fieldName: "user", refTable: "User", refColumns: ["id"], joinColumns: ["userId"], 'type: psql:ONE_TO_ONE},
                orders: {entity: Order, fieldName: "orders", refTable: "Order", refColumns: ["buyeragentId"], joinColumns: ["id"], 'type: psql:MANY_TO_ONE}
            }
        },
        [CROP]: {
            entityName: "Crop",
            tableName: "Crop",
            fieldMetadata: {
                id: {columnName: "id"},
                cropType: {columnName: "crop_type"},
                variety: {columnName: "variety"},
                grade: {columnName: "grade"},
                quantity: {columnName: "quantity"},
                unit: {columnName: "unit"},
                pricePerUnit: {columnName: "price_per_unit"},
                harvestDate: {columnName: "harvest_date"},
                expiryDate: {columnName: "expiry_date"},
                description: {columnName: "description"},
                status: {columnName: "status"},
                createdAt: {columnName: "created_at"},
                farmerId: {columnName: "farmerId"},
                "farmer.id": {relation: {entityName: "farmer", refField: "id"}},
                "farmer.firstName": {relation: {entityName: "farmer", refField: "firstName", refColumn: "first_name"}},
                "farmer.lastName": {relation: {entityName: "farmer", refField: "lastName", refColumn: "last_name"}},
                "farmer.phone": {relation: {entityName: "farmer", refField: "phone"}},
                "farmer.address": {relation: {entityName: "farmer", refField: "address"}},
                "farmer.farmLocation": {relation: {entityName: "farmer", refField: "farmLocation", refColumn: "farm_location"}},
                "farmer.farmSize": {relation: {entityName: "farmer", refField: "farmSize", refColumn: "farm_size"}},
                "farmer.verificationStatus": {relation: {entityName: "farmer", refField: "verificationStatus", refColumn: "verification_status"}},
                "farmer.createdAt": {relation: {entityName: "farmer", refField: "createdAt", refColumn: "created_at"}},
                "farmer.userId": {relation: {entityName: "farmer", refField: "userId"}},
                "orderItems[].id": {relation: {entityName: "orderItems", refField: "id"}},
                "orderItems[].quantity": {relation: {entityName: "orderItems", refField: "quantity"}},
                "orderItems[].unitPrice": {relation: {entityName: "orderItems", refField: "unitPrice", refColumn: "unit_price"}},
                "orderItems[].totalPrice": {relation: {entityName: "orderItems", refField: "totalPrice", refColumn: "total_price"}},
                "orderItems[].orderId": {relation: {entityName: "orderItems", refField: "orderId"}},
                "orderItems[].cropId": {relation: {entityName: "orderItems", refField: "cropId"}}
            },
            keyFields: ["id"],
            joinMetadata: {
                farmer: {entity: Farmer, fieldName: "farmer", refTable: "Farmer", refColumns: ["id"], joinColumns: ["farmerId"], 'type: psql:ONE_TO_MANY},
                orderItems: {entity: OrderItem, fieldName: "orderItems", refTable: "OrderItem", refColumns: ["cropId"], joinColumns: ["id"], 'type: psql:MANY_TO_ONE}
            }
        },
        [ORDER]: {
            entityName: "Order",
            tableName: "Order",
            fieldMetadata: {
                id: {columnName: "id"},
                totalAmount: {columnName: "total_amount"},
                status: {columnName: "status"},
                createdAt: {columnName: "created_at"},
                updatedAt: {columnName: "updated_at"},
                buyeragentId: {columnName: "buyeragentId"},
                "buyerAgent.id": {relation: {entityName: "buyerAgent", refField: "id"}},
                "buyerAgent.companyName": {relation: {entityName: "buyerAgent", refField: "companyName", refColumn: "company_name"}},
                "buyerAgent.contactPerson": {relation: {entityName: "buyerAgent", refField: "contactPerson", refColumn: "contact_person"}},
                "buyerAgent.phone": {relation: {entityName: "buyerAgent", refField: "phone"}},
                "buyerAgent.businessLicense": {relation: {entityName: "buyerAgent", refField: "businessLicense", refColumn: "business_license"}},
                "buyerAgent.verificationStatus": {relation: {entityName: "buyerAgent", refField: "verificationStatus", refColumn: "verification_status"}},
                "buyerAgent.createdAt": {relation: {entityName: "buyerAgent", refField: "createdAt", refColumn: "created_at"}},
                "buyerAgent.userId": {relation: {entityName: "buyerAgent", refField: "userId"}},
                "orderItems[].id": {relation: {entityName: "orderItems", refField: "id"}},
                "orderItems[].quantity": {relation: {entityName: "orderItems", refField: "quantity"}},
                "orderItems[].unitPrice": {relation: {entityName: "orderItems", refField: "unitPrice", refColumn: "unit_price"}},
                "orderItems[].totalPrice": {relation: {entityName: "orderItems", refField: "totalPrice", refColumn: "total_price"}},
                "orderItems[].orderId": {relation: {entityName: "orderItems", refField: "orderId"}},
                "orderItems[].cropId": {relation: {entityName: "orderItems", refField: "cropId"}}
            },
            keyFields: ["id"],
            joinMetadata: {
                buyerAgent: {entity: BuyerAgent, fieldName: "buyerAgent", refTable: "BuyerAgent", refColumns: ["id"], joinColumns: ["buyeragentId"], 'type: psql:ONE_TO_MANY},
                orderItems: {entity: OrderItem, fieldName: "orderItems", refTable: "OrderItem", refColumns: ["orderId"], joinColumns: ["id"], 'type: psql:MANY_TO_ONE}
            }
        },
        [ORDER_ITEM]: {
            entityName: "OrderItem",
            tableName: "OrderItem",
            fieldMetadata: {
                id: {columnName: "id"},
                quantity: {columnName: "quantity"},
                unitPrice: {columnName: "unit_price"},
                totalPrice: {columnName: "total_price"},
                orderId: {columnName: "orderId"},
                cropId: {columnName: "cropId"},
                "order.id": {relation: {entityName: "order", refField: "id"}},
                "order.totalAmount": {relation: {entityName: "order", refField: "totalAmount", refColumn: "total_amount"}},
                "order.status": {relation: {entityName: "order", refField: "status"}},
                "order.createdAt": {relation: {entityName: "order", refField: "createdAt", refColumn: "created_at"}},
                "order.updatedAt": {relation: {entityName: "order", refField: "updatedAt", refColumn: "updated_at"}},
                "'order.buyeragentId": {relation: {entityName: "order", refField: "buyeragentId"}},
                "crop.id": {relation: {entityName: "crop", refField: "id"}},
                "crop.cropType": {relation: {entityName: "crop", refField: "cropType", refColumn: "crop_type"}},
                "crop.variety": {relation: {entityName: "crop", refField: "variety"}},
                "crop.grade": {relation: {entityName: "crop", refField: "grade"}},
                "crop.quantity": {relation: {entityName: "crop", refField: "quantity"}},
                "crop.unit": {relation: {entityName: "crop", refField: "unit"}},
                "crop.pricePerUnit": {relation: {entityName: "crop", refField: "pricePerUnit", refColumn: "price_per_unit"}},
                "crop.harvestDate": {relation: {entityName: "crop", refField: "harvestDate", refColumn: "harvest_date"}},
                "crop.expiryDate": {relation: {entityName: "crop", refField: "expiryDate", refColumn: "expiry_date"}},
                "crop.description": {relation: {entityName: "crop", refField: "description"}},
                "crop.status": {relation: {entityName: "crop", refField: "status"}},
                "crop.createdAt": {relation: {entityName: "crop", refField: "createdAt", refColumn: "created_at"}},
                "crop.farmerId": {relation: {entityName: "crop", refField: "farmerId"}}
            },
            keyFields: ["id"],
            joinMetadata: {
                'order: {entity: Order, fieldName: "'order", refTable: "Order", refColumns: ["id"], joinColumns: ["orderId"], 'type: psql:ONE_TO_MANY},
                crop: {entity: Crop, fieldName: "crop", refTable: "Crop", refColumns: ["id"], joinColumns: ["cropId"], 'type: psql:ONE_TO_MANY}
            }
        }
    };

    public isolated function init() returns persist:Error? {
        postgresql:Client|error dbClient = new (host = host, username = user, password = password, database = database, port = port, options = connectionOptions);
        if dbClient is error {
            return <persist:Error>error(dbClient.message());
        }
        self.dbClient = dbClient;
        if defaultSchema != () {
            lock {
                foreach string key in self.metadata.keys() {
                    psql:SQLMetadata metadata = self.metadata.get(key);
                    if metadata.schemaName == () {
                        metadata.schemaName = defaultSchema;
                    }
                    map<psql:JoinMetadata>? joinMetadataMap = metadata.joinMetadata;
                    if joinMetadataMap == () {
                        continue;
                    }
                    foreach [string, psql:JoinMetadata] [_, joinMetadata] in joinMetadataMap.entries() {
                        if joinMetadata.refSchema == () {
                            joinMetadata.refSchema = defaultSchema;
                        }
                    }
                }
            }
        }
        self.persistClients = {
            [USER]: check new (dbClient, self.metadata.get(USER).cloneReadOnly(), psql:POSTGRESQL_SPECIFICS),
            [FARMER]: check new (dbClient, self.metadata.get(FARMER).cloneReadOnly(), psql:POSTGRESQL_SPECIFICS),
            [BUYER_AGENT]: check new (dbClient, self.metadata.get(BUYER_AGENT).cloneReadOnly(), psql:POSTGRESQL_SPECIFICS),
            [CROP]: check new (dbClient, self.metadata.get(CROP).cloneReadOnly(), psql:POSTGRESQL_SPECIFICS),
            [ORDER]: check new (dbClient, self.metadata.get(ORDER).cloneReadOnly(), psql:POSTGRESQL_SPECIFICS),
            [ORDER_ITEM]: check new (dbClient, self.metadata.get(ORDER_ITEM).cloneReadOnly(), psql:POSTGRESQL_SPECIFICS)
        };
    }

    isolated resource function get users(UserTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "query"
    } external;

    isolated resource function get users/[string id](UserTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post users(UserInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from UserInsert inserted in data
            select inserted.id;
    }

    isolated resource function put users/[string id](UserUpdate value) returns User|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/users/[id].get();
    }

    isolated resource function delete users/[string id]() returns User|persist:Error {
        User result = check self->/users/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    isolated resource function get farmers(FarmerTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "query"
    } external;

    isolated resource function get farmers/[string id](FarmerTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post farmers(FarmerInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(FARMER);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from FarmerInsert inserted in data
            select inserted.id;
    }

    isolated resource function put farmers/[string id](FarmerUpdate value) returns Farmer|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(FARMER);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/farmers/[id].get();
    }

    isolated resource function delete farmers/[string id]() returns Farmer|persist:Error {
        Farmer result = check self->/farmers/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(FARMER);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    isolated resource function get buyeragents(BuyerAgentTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "query"
    } external;

    isolated resource function get buyeragents/[string id](BuyerAgentTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post buyeragents(BuyerAgentInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(BUYER_AGENT);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from BuyerAgentInsert inserted in data
            select inserted.id;
    }

    isolated resource function put buyeragents/[string id](BuyerAgentUpdate value) returns BuyerAgent|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(BUYER_AGENT);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/buyeragents/[id].get();
    }

    isolated resource function delete buyeragents/[string id]() returns BuyerAgent|persist:Error {
        BuyerAgent result = check self->/buyeragents/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(BUYER_AGENT);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    isolated resource function get crops(CropTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "query"
    } external;

    isolated resource function get crops/[string id](CropTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post crops(CropInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(CROP);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from CropInsert inserted in data
            select inserted.id;
    }

    isolated resource function put crops/[string id](CropUpdate value) returns Crop|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(CROP);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/crops/[id].get();
    }

    isolated resource function delete crops/[string id]() returns Crop|persist:Error {
        Crop result = check self->/crops/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(CROP);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    isolated resource function get orders(OrderTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "query"
    } external;

    isolated resource function get orders/[string id](OrderTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post orders(OrderInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ORDER);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from OrderInsert inserted in data
            select inserted.id;
    }

    isolated resource function put orders/[string id](OrderUpdate value) returns Order|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ORDER);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/orders/[id].get();
    }

    isolated resource function delete orders/[string id]() returns Order|persist:Error {
        Order result = check self->/orders/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ORDER);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    isolated resource function get orderitems(OrderItemTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "query"
    } external;

    isolated resource function get orderitems/[string id](OrderItemTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post orderitems(OrderItemInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ORDER_ITEM);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from OrderItemInsert inserted in data
            select inserted.id;
    }

    isolated resource function put orderitems/[string id](OrderItemUpdate value) returns OrderItem|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ORDER_ITEM);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/orderitems/[id].get();
    }

    isolated resource function delete orderitems/[string id]() returns OrderItem|persist:Error {
        OrderItem result = check self->/orderitems/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ORDER_ITEM);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    remote isolated function queryNativeSQL(sql:ParameterizedQuery sqlQuery, typedesc<record {}> rowType = <>) returns stream<rowType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor"
    } external;

    remote isolated function executeNativeSQL(sql:ParameterizedQuery sqlQuery) returns psql:ExecutionResult|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.PostgreSQLProcessor"
    } external;

    public isolated function close() returns persist:Error? {
        error? result = self.dbClient.close();
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }
}

