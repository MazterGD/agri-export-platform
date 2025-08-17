// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/time;

public enum UserRole {
    ADMIN = "admin",
    FARM_USER = "farmer",
    BUYER_USER = "buyer_agent"
}

public enum UserStatus {
    PENDING = "pending",
    ACTIVE = "active",
    SUSPENDED = "suspended"
}

public enum VerificationStatus {
    PENDING = "pending",
    VERIFIED = "verified",
    REJECTED = "rejected"
}

public enum CropStatus {
    AVAILABLE = "available",
    RESERVED = "reserved",
    SOLD = "sold",
    EXPIRED = "expired"
}

public enum OrderStatus {
    PENDING = "pending",
    CONFIRMED = "confirmed",
    IN_PROGRESS = "in_progress",
    SHIPPED = "shipped",
    DELIVERED = "delivered",
    CANCELLED = "cancelled"
}

public type User record {|
    readonly string id;
    string email;
    string? passwordHash;
    UserRole role;
    UserStatus status;
    time:Civil createdAt;
    time:Civil updatedAt;
    string? asgardeoUserId;
    time:Civil? lastLogin;
    int loginCount;

|};

public type UserOptionalized record {|
    string id?;
    string email?;
    string? passwordHash?;
    UserRole role?;
    UserStatus status?;
    time:Civil createdAt?;
    time:Civil updatedAt?;
    string? asgardeoUserId?;
    time:Civil? lastLogin?;
    int loginCount?;
|};

public type UserWithRelations record {|
    *UserOptionalized;
    FarmerOptionalized farmer?;
    BuyerAgentOptionalized buyerAgent?;
|};

public type UserTargetType typedesc<UserWithRelations>;

public type UserInsert User;

public type UserUpdate record {|
    string email?;
    string? passwordHash?;
    UserRole role?;
    UserStatus status?;
    time:Civil createdAt?;
    time:Civil updatedAt?;
    string? asgardeoUserId?;
    time:Civil? lastLogin?;
    int loginCount?;
|};

public type Farmer record {|
    readonly string id;
    string firstName;
    string lastName;
    string? phone;
    string? address;
    string? farmLocation;
    decimal? farmSize;
    VerificationStatus verificationStatus;
    time:Civil createdAt;
    string userId;

|};

public type FarmerOptionalized record {|
    string id?;
    string firstName?;
    string lastName?;
    string? phone?;
    string? address?;
    string? farmLocation?;
    decimal? farmSize?;
    VerificationStatus verificationStatus?;
    time:Civil createdAt?;
    string userId?;
|};

public type FarmerWithRelations record {|
    *FarmerOptionalized;
    UserOptionalized user?;
    CropOptionalized[] crops?;
|};

public type FarmerTargetType typedesc<FarmerWithRelations>;

public type FarmerInsert Farmer;

public type FarmerUpdate record {|
    string firstName?;
    string lastName?;
    string? phone?;
    string? address?;
    string? farmLocation?;
    decimal? farmSize?;
    VerificationStatus verificationStatus?;
    time:Civil createdAt?;
    string userId?;
|};

public type BuyerAgent record {|
    readonly string id;
    string companyName;
    string contactPerson;
    string? phone;
    string? businessLicense;
    VerificationStatus verificationStatus;
    time:Civil createdAt;
    string userId;

|};

public type BuyerAgentOptionalized record {|
    string id?;
    string companyName?;
    string contactPerson?;
    string? phone?;
    string? businessLicense?;
    VerificationStatus verificationStatus?;
    time:Civil createdAt?;
    string userId?;
|};

public type BuyerAgentWithRelations record {|
    *BuyerAgentOptionalized;
    UserOptionalized user?;
    OrderOptionalized[] orders?;
|};

public type BuyerAgentTargetType typedesc<BuyerAgentWithRelations>;

public type BuyerAgentInsert BuyerAgent;

public type BuyerAgentUpdate record {|
    string companyName?;
    string contactPerson?;
    string? phone?;
    string? businessLicense?;
    VerificationStatus verificationStatus?;
    time:Civil createdAt?;
    string userId?;
|};

public type Crop record {|
    readonly string id;
    string cropType;
    string? variety;
    string? grade;
    decimal quantity;
    string unit;
    decimal pricePerUnit;
    time:Date? harvestDate;
    time:Date? expiryDate;
    string? description;
    CropStatus status;
    time:Civil createdAt;
    string farmerId;

|};

public type CropOptionalized record {|
    string id?;
    string cropType?;
    string? variety?;
    string? grade?;
    decimal quantity?;
    string unit?;
    decimal pricePerUnit?;
    time:Date? harvestDate?;
    time:Date? expiryDate?;
    string? description?;
    CropStatus status?;
    time:Civil createdAt?;
    string farmerId?;
|};

public type CropWithRelations record {|
    *CropOptionalized;
    FarmerOptionalized farmer?;
    OrderItemOptionalized[] orderItems?;
|};

public type CropTargetType typedesc<CropWithRelations>;

public type CropInsert Crop;

public type CropUpdate record {|
    string cropType?;
    string? variety?;
    string? grade?;
    decimal quantity?;
    string unit?;
    decimal pricePerUnit?;
    time:Date? harvestDate?;
    time:Date? expiryDate?;
    string? description?;
    CropStatus status?;
    time:Civil createdAt?;
    string farmerId?;
|};

public type Order record {|
    readonly string id;
    decimal totalAmount;
    OrderStatus status;
    time:Civil createdAt;
    time:Civil updatedAt;
    string buyeragentId;

|};

public type OrderOptionalized record {|
    string id?;
    decimal totalAmount?;
    OrderStatus status?;
    time:Civil createdAt?;
    time:Civil updatedAt?;
    string buyeragentId?;
|};

public type OrderWithRelations record {|
    *OrderOptionalized;
    BuyerAgentOptionalized buyerAgent?;
    OrderItemOptionalized[] orderItems?;
|};

public type OrderTargetType typedesc<OrderWithRelations>;

public type OrderInsert Order;

public type OrderUpdate record {|
    decimal totalAmount?;
    OrderStatus status?;
    time:Civil createdAt?;
    time:Civil updatedAt?;
    string buyeragentId?;
|};

public type OrderItem record {|
    readonly string id;
    decimal quantity;
    decimal unitPrice;
    decimal totalPrice;
    string orderId;
    string cropId;
|};

public type OrderItemOptionalized record {|
    string id?;
    decimal quantity?;
    decimal unitPrice?;
    decimal totalPrice?;
    string orderId?;
    string cropId?;
|};

public type OrderItemWithRelations record {|
    *OrderItemOptionalized;
    OrderOptionalized 'order?;
    CropOptionalized crop?;
|};

public type OrderItemTargetType typedesc<OrderItemWithRelations>;

public type OrderItemInsert OrderItem;

public type OrderItemUpdate record {|
    decimal quantity?;
    decimal unitPrice?;
    decimal totalPrice?;
    string orderId?;
    string cropId?;
|};

