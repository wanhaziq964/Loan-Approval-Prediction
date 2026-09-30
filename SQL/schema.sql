CREATE TABLE loan_applications (
	loan_id INT PRIMARY KEY,
    no_of_dependents INT,
    education VARCHAR(20),
    self_employed VARCHAR(10),
    income_annum BIGINT,
    loan_amount BIGINT,
    loan_term INT,
    residential_assets_value BIGINT,
    commercial_assets_value BIGINT,
    luxury_assets_value BIGINT,
    bank_asset_value BIGINT, 
    loan_status VARCHAR(10)
);

DROP TABLE loan_applications;

CREATE TABLE loan_applications (
    loan_id INT PRIMARY KEY,
    no_of_dependents INT,
    education VARCHAR(20),
    self_employed VARCHAR(10),
    income_annum BIGINT,
    loan_amount BIGINT,
    loan_term INT,
    cibil_score INT,
    residential_assets_value BIGINT,
    commercial_assets_value BIGINT,
    luxury_assets_value BIGINT,
    bank_asset_value BIGINT,
    loan_status VARCHAR(10)
);

DESCRIBE loan_applications;

CREATE TABLE loan_predictions (
    prediction_id INT AUTO_INCREMENT PRIMARY KEY,
    no_of_dependents INT,
    education VARCHAR(20),
    self_employed VARCHAR(10),
    income_annum BIGINT,
    loan_amount BIGINT,
    loan_term INT,
    cibil_score INT,
    residential_assets_value BIGINT,
    commercial_assets_value BIGINT,
    luxury_assets_value BIGINT,
    bank_asset_value BIGINT,
    actual_status INT,
    predicted_status INT
);