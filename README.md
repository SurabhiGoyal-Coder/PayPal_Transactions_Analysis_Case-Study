# PayPal_Transactions_Analysis_Case_Study
Conducted an in-depth MySQL analysis of a global digital payment platform to increase transaction volume and improve user satisfaction. The goal is to identify actionable insights from the transaction data that can drive strategic decisions, improve risk management, and ultimately increase the platform's market share and profitability in the competitive digital payment industry.

Objectives:

* User Behavior and Engagement: Identify key user segments and analyze transaction patterns to enhance customer retention and value.
* Geographic Insights: Analyze transaction distribution to uncover high-performing regions and growth opportunities.
* Sales Optimization: Evaluate sales trends and customer preferences to boost platform adoption and revenue.
* Platform Performance: Monitor KPIs like transaction volume, revenue, and user growth to ensure optimal platform performance.

Dataset Tables:

* Countries Table: This table contains information about different countries. It includes the name of each country to facilitate various analyses and operations.
* Currencies Table: This table provides a comprehensive list of currencies used in financial transactions. The structure allows for efficient referencing of currencies throughout the database, enabling accurate currency-related operations and reporting across various financial processes and international transactions.
* Merchants Table: This table captures essential information about businesses or individuals who accept payments through the platform. This structure enables efficient merchant management, facilitates reporting, and supports tailored services based on geographical considerations.
* Transactions Table: This data structure captures detailed information about financial exchanges within the system. The comprehensive record of transactions forms the core of the system, facilitating various financial operations, user activity tracking, and providing essential data for analytics and compliance purposes.
* Users Table: This data structure contains essential information about individuals who utilize the platform for financial transactions. This comprehensive user profile supports various functions including personalized services, security measures, and demographic analysis to inform business strategies and improve user experience.

Steps:
* Explored the transactions, users, and countries tables to understand the schema and relationships.
* Verified data consistency and integrity to ensure accurate analysis; no additional cleaning was required as the data was pre-validated.
* Analysis of Top 5 Countries by Transaction Amount and dentification of High-Value Transactions.
* Merchant Performance Analysis and identify currency Risk and Conversion Trends.
* Classified transactions into 'High Value' and 'Regular' based on thresholds, and further into 'Domestic' and 'International' .
* Created a monthly financial reporting for year 2023 and Identification of High-Value Users with an average transaction amount exceeding $5,000.
* Identified users who made at least one transaction in at least 6 out of the 12 months from May 2023 to April 2024; Provided user details to aid in targeted engagement strategies.
* Identified the most valuable customer by total transaction amount over the past year; Provided user details to assist in designing loyalty rewards.
* Evaluated affiliate and marketing channels by counting bookings and calculating conversion rates to identify the most effective channels.

Insights:
* 'Iceland', 'Zambia' and 'Israel' are the countries that sent the most funds and 'Zambia', 'Iceland' and 'Saint Kitts and Nevis' are those countries that received the most funds in the last quarter of 2023 so it assist in optimizing marketing strategies, tailoring financial products, and managing cross-border transaction risks.
* High-value transactions (2 lacs) were flagged, highlighting key users and regions contributing to significant monetary movement. This data is crucial for risk assessment, fraud detection, and targeted customer engagement strategies.
* 'Gould LLC' , 'Wilson-Mosley', 'Grant-Gallegos', 'Simon PLC', 'Shelton, Jones and Ferguson' are top 5 merchants with the highest transaction volumes, providing valuable information for prioritizing partnerships and customizing merchant services.
* The top 3 currencies for conversion were identified, with 'Euro' leading as the most frequently transacted currency and it helps for currency risk management and strategic planning for forex operations.
* There are '2233' Transactions which are categorized as 'regular international', while 'Regular Domestic' are '45' only and 'High Value International' with only '1' so mostly transactions are international with transaction amount < $10,000.
* Userid with email 'wrodriguez@hotmail.com' have the highest average transaction amount from November 2023 to April 2024.
* In 'Oct 2023', there are highest total transactions amount compare with other months in year 2023.
* Users who transacted in at least 6 months were highlighted as consistent contributors, providing opportunities for enhanced retention strategies.
* Users with an average transaction amount exceeding $5,000 were identified, aiding in segmenting high-value customers for tailored services.

Recommendations based on the insights:
* For Marketing Teams: Focus on high-performing countries and consistently engaged users to design campaigns.
* For Finance Teams: Utilize high-value transaction data to manage risks and address compliance requirements.
* For Merchant Relations: Collaborate with top-performing merchants to sustain and grow transaction volumes.
* For Risk Management: Monitor currency trends and implement measures to mitigate exposure to forex volatility.
* For Customer Retention: Use insights from consistent and high-value user behavior to personalize offerings and improve engagement.
