# Loan Approval Prediction Analysis

A stretch project built for MUMB (Malayan United Merchant Bank), a fictional bank used as the stakeholder scenario for this portfolio piece. The project moves past descriptive analytics into predictive modeling, using historical loan applicant data to estimate approval likelihood and identify which applicant traits actually drive the bank's lending decisions.

## Problem Statement

MUMB's credit risk team reviews loan applications manually, one case at a time. As application volume grows, this becomes a bottleneck, and two reviewers looking at similar applicant profiles don't always land on the same decision.

The Head of Credit Risk wants a data-backed reference point: which applicant characteristics actually predict approval, and can a model flag straightforward cases (clear approve, clear reject) so reviewers can focus their time on the ones that genuinely need judgment.

This project uses MUMB's historical applicant and approval data to build a classification model that estimates loan approval likelihood, and evaluates whether that model is reliable enough to be useful as a reference tool.

## Dataset

Source: [Loan Approval Dataset on Kaggle](https://www.kaggle.com/datasets/yashrana121/loan-approval)

4,269 loan applications with demographic, employment, financial, credit, and asset-related fields, plus the historical approval outcome (Approved or Rejected).

## Approach

**1. Data cleaning**
Loaded the raw CSV, stripped stray whitespace from column names and text fields, and corrected a placeholder value in the residential assets column (a negative number that didn't represent a real asset value). Saved the cleaned dataset separately from the raw file so the original source data stays untouched.

**2. Exploratory data analysis**
Looked at how approval rates shift across CIBIL score bands, income, loan amount relative to income, education, self-employment status, and asset holdings. This step was about finding out which variables actually separate approved applicants from rejected ones before building any model.

**3. Feature preparation and modeling**
Encoded categorical fields (education, self-employment, loan status) into numeric form, split the data into training and test sets (80/20, stratified on the target so both sets kept the same approve/reject ratio), and trained two classification models: logistic regression as a baseline, and a decision tree as a comparison.

**4. Model evaluation**
Evaluated both models on accuracy, precision, recall, and ROC-AUC, not accuracy alone, since a model can look accurate while still being unreliable for one class. Also examined feature importance to see which variables the stronger model actually relied on.

**5. Data storage**
Stored the cleaned applicant data, the model's predictions, feature importance scores, and the ROC-AUC metric in a MySQL database, so the dashboard could query live results instead of static exports.

**6. Dashboard**
Built a two page Power BI dashboard for the Head of Credit Risk: one page covering EDA findings, one page covering model results, connected live to the MySQL database.

## Dashboard

**Page 1: EDA Findings**

![EDA Findings](Dashboard/screenshots/01_EDA_Findings.png)

Covers total applications, approval rate, rejection rate, and average CIBIL score, plus how approval rates break down by CIBIL band, education, self-employment status, and asset value.

**Page 2: Model Results**

![Model Results](Dashboard/screenshots/02_Model_Results.png)

Covers the model's accuracy, precision, recall, and ROC-AUC, a confusion matrix, feature importance, prediction accuracy by CIBIL band, and a search tool where a reviewer can look up an individual application by its ID and see its predicted vs actual outcome.

## Key Findings

- **CIBIL score dominates the decision.** It accounted for roughly 82% of the decision tree's feature importance, by a wide margin over every other variable.
- **Income, loan amount, education, and self-employment status showed little to no relationship with approval on their own.** Even applicants asking for a loan several times their annual income didn't see meaningfully lower approval rates, which suggests CIBIL score is carrying most of the weight in the actual lending decision.
- **The decision tree outperformed logistic regression**, reaching about 98% accuracy, 98.5% precision and recall on the approved class, and a 0.98 ROC-AUC score. Logistic regression was noticeably weaker across the same metrics.
- **The model's mistakes were rare and fairly balanced** between false approvals and false rejections, based on the confusion matrix, rather than being skewed heavily toward one type of error.

## Honest Limitations

- This model is trained and evaluated on a single historical dataset. It has never been tested against a real applicant outside this data, so there's no way to know how it would hold up in production.
- The evaluation here is a one time test on a held out sample, not ongoing monitoring. A real deployment would need to track the model's performance over time as new applications come in, since approval patterns can drift.
- The dataset doesn't include everything a real underwriter would weigh, like full credit history detail or macroeconomic conditions, so "approval likelihood" here is based on a narrower picture than an actual reviewer works from.
- No fairness or bias auditing was done. If historical approvals reflect any unintentional bias, the model would learn and repeat that pattern rather than catch it. This would need to be addressed before a model like this could inform any real decision.
- This is a first classification project built to demonstrate the workflow end to end, not a production ready system. Everything above is treated as a known limitation, not something to hide behind strong looking metrics.

Planning documents (project charter and dashboard wireframe) are in the `Planning Doc` folder for anyone who wants to see how the project was scoped before it was built.

## Skills Demonstrated

**Technical:** Python (pandas, NumPy), scikit-learn, matplotlib/seaborn, MySQL, SQLAlchemy, Power BI (DAX, Power Query), Git/GitHub

**Analytical:** exploratory data analysis, binary classification modeling, train/test splitting with stratification, model evaluation using precision, recall, and ROC-AUC, feature importance interpretation, awareness of model limitations and ethical considerations in predictive analytics
