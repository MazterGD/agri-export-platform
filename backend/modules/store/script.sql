-- AUTO-GENERATED FILE.

-- This file is an auto-generated file by Ballerina persistence layer for model.
-- Please verify the generated scripts and execute them against the target DB server.

DROP TABLE IF EXISTS "Crop";
DROP TABLE IF EXISTS "OrderItem";
DROP TABLE IF EXISTS "Order";
DROP TABLE IF EXISTS "BuyerAgent";
DROP TABLE IF EXISTS "Farmer";
DROP TABLE IF EXISTS "User";

CREATE TABLE "User" (
	"id" VARCHAR(191) NOT NULL,
	"email" VARCHAR(191) NOT NULL,
	"password_hash" VARCHAR(191),
	"role" VARCHAR(11) CHECK ("role" IN ('admin', 'farmer', 'buyer_agent')) NOT NULL,
	"status" VARCHAR(9) CHECK ("status" IN ('pending', 'active', 'suspended')) NOT NULL,
	"created_at" TIMESTAMP NOT NULL,
	"updated_at" TIMESTAMP NOT NULL,
	"asgardeo_user_id" VARCHAR(191),
	"last_login" TIMESTAMP,
	"login_count" INT NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE "Farmer" (
	"id" VARCHAR(191) NOT NULL,
	"first_name" VARCHAR(191) NOT NULL,
	"last_name" VARCHAR(191) NOT NULL,
	"phone" VARCHAR(191),
	"address" VARCHAR(191),
	"farm_location" VARCHAR(191),
	"farm_size" DECIMAL(65,30),
	"verification_status" VARCHAR(8) CHECK ("verification_status" IN ('pending', 'verified', 'rejected')) NOT NULL,
	"created_at" TIMESTAMP NOT NULL,
	"userId" VARCHAR(191) UNIQUE NOT NULL,
	FOREIGN KEY("userId") REFERENCES "User"("id"),
	PRIMARY KEY("id")
);

CREATE TABLE "BuyerAgent" (
	"id" VARCHAR(191) NOT NULL,
	"company_name" VARCHAR(191) NOT NULL,
	"contact_person" VARCHAR(191) NOT NULL,
	"phone" VARCHAR(191),
	"business_license" VARCHAR(191),
	"verification_status" VARCHAR(8) CHECK ("verification_status" IN ('pending', 'verified', 'rejected')) NOT NULL,
	"created_at" TIMESTAMP NOT NULL,
	"userId" VARCHAR(191) UNIQUE NOT NULL,
	FOREIGN KEY("userId") REFERENCES "User"("id"),
	PRIMARY KEY("id")
);

CREATE TABLE "Order" (
	"id" VARCHAR(191) NOT NULL,
	"total_amount" DECIMAL(65,30) NOT NULL,
	"status" VARCHAR(11) CHECK ("status" IN ('pending', 'confirmed', 'in_progress', 'shipped', 'delivered', 'cancelled')) NOT NULL,
	"created_at" TIMESTAMP NOT NULL,
	"updated_at" TIMESTAMP NOT NULL,
	"buyeragentId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("buyeragentId") REFERENCES "BuyerAgent"("id"),
	PRIMARY KEY("id")
);

CREATE TABLE "OrderItem" (
	"id" VARCHAR(191) NOT NULL,
	"quantity" DECIMAL(65,30) NOT NULL,
	"unit_price" DECIMAL(65,30) NOT NULL,
	"total_price" DECIMAL(65,30) NOT NULL,
	"orderId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("orderId") REFERENCES "Order"("id"),
	"cropId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("cropId") REFERENCES "Crop"("id"),
	PRIMARY KEY("id")
);

CREATE TABLE "Crop" (
	"id" VARCHAR(191) NOT NULL,
	"crop_type" VARCHAR(191) NOT NULL,
	"variety" VARCHAR(191),
	"grade" VARCHAR(191),
	"quantity" DECIMAL(65,30) NOT NULL,
	"unit" VARCHAR(191) NOT NULL,
	"price_per_unit" DECIMAL(65,30) NOT NULL,
	"harvest_date" DATE,
	"expiry_date" DATE,
	"description" VARCHAR(191),
	"status" VARCHAR(9) CHECK ("status" IN ('available', 'reserved', 'sold', 'expired')) NOT NULL,
	"created_at" TIMESTAMP NOT NULL,
	"farmerId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("farmerId") REFERENCES "Farmer"("id"),
	PRIMARY KEY("id")
);


