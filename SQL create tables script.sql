DROP TABLE IF EXISTS coffeesales;

CREATE TABLE coffeesales(
	sale_date DATE,
	date_time TIMESTAMP,
	payment_mode TEXT,
	card TEXT,
	amount_paid NUMERIC,
	coffee_name TEXt
);

DROP TABLE IF EXISTS amazon_categories;
DROP TABLE IF EXISTS amazon_products;

CREATE TABLE amazon_categories(
	id Numeric,
	category_name TEXT
);

CREATE TABLE amazon_products(
	asin TEXT,
	title TEXT,
	stars FLOAT,
	reviews NUMERIC,
	price FLOAT,
	listprice FLOAT,
	category_id NUMERIC,
	isBestSeller BOOLEAN,
	boughtInLastMonth NUMERIC
);

DROP TABLE IF EXISTS digital_marketing;

CREATE TABLE digital_marketing(
	CustomerID NUMERIC,
	Age NUMERIC,
	Gender TEXT,
	Income NUMERIC,
	CampaignChannel TEXT,
	CampaignType TEXT,
	AdSpend FLOAT,
	ClickThroughRate FLOAT,
	ConversionRate FLOAT,
	WebsiteVisits NUMERIC,
	PagesPerVisit FLOAT,
	TimeOnSite FLOAT,
	SocialShares NUMERIC,
	EmailOpens NUMERIC,
	EmailClicks NUMERIC,
	PreviousPurchases NUMERIC,
	LoyaltyPoints NUMERIC,
	AdvertisingPlatform TEXT,
	AdvertisingTool TEXT,
	Conversion NUMERIC
);
