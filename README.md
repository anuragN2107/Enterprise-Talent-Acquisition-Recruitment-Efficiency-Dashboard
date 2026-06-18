# Enterprise Talent Acquisition & Recruitment Intelligence Suite

![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![DAX](https://img.shields.io/badge/DAX-Data_Analysis_Expressions-blue?style=for-the-badge)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Data Governance](https://img.shields.io/badge/Security-Row_Level_Security-red?style=for-the-badge)

## 📌 Project Deliverables
* **Production Power BI Workspace File:** [`Dashboard`]([./Enterprise_TA_Analytics.pbix](https://github.com/anuragN2107/Enterprise-Talent-Acquisition-Recruitment-Efficiency-Dashboard/blob/main/Recruitment_Intelligence_Dashboard.pbix))
* **Underlying Data Layer:** Optimized Star Schema Model built across 5 connected entities.
* **Automated Engineering Script:** [`dataset_generator.py`](./Scripts/dataset_generator.py) (Python logic used to generate realistic HR logs with intentional operational bottlenecks).

---

## 💼 The Business Challenge & Objectives
A rapidly growing corporate entity faced escalating recruitment agency dependencies, prolonged interview loops, and highly unpredictable talent sourcing expenses. HR executives lacked structured visibility into pipeline drop-offs and operational latency.

This data solution was engineered to act as a centralized decision-making engine to:
1. **Identify Pipeline Friction:** Locate exactly where candidates stall or drop out of the hiring funnel (Velocity Analysis).
2. **Quantify Sourcing ROI:** Evaluate the financial efficiency of premium channels (LinkedIn vs. External Agencies vs. Referrals) to balance Cost-Per-Hire (CPH).
3. **Monitor Process Equity:** Surface demographic conversion rates across individual loop stages to ensure Diversity, Equity, and Inclusion (DEI) operational standards.

---
### 🛠️ Core Tools & Technologies Used

* **Microsoft Power BI Desktop:** Used as the primary business intelligence platform for data modeling, DAX engineering, report canvas design, and analytical visual layout.
* **Power Query (M Language):** Utilized for the Extract, Transform, Load (ETL) pipeline, data type transformations, and creating the dynamic, custom corporate `Dim_Calendar` dimension table.
* **DAX (Data Analysis Expressions):** Used to write context-aware measures tracking candidate pipelines, chronological sequence timestamps (Time-to-Hire iterations), and financial efficiency KPIs.
* **Python:** Leveraged via an automated script (`dataset_generator.py`) to engineer realistic, multi-table relational HR datasets embedded with intentional operational bottlenecks.
* **Built-in Power BI AI Engines:** 
  * *Key Influencers:* Background linear/logistic regression modeling used to isolate singular drivers of early-stage candidate rejections.
  * *Top Segments:* Background decision-tree clustering algorithms utilized to detect multi-variable risk profiles causing candidate dropouts.
  * *Time-Series Anomaly Detection:* Rolling statistical boundary band algorithms applied to historical cost metrics to automatically surface and explain budget exceptions.
* **Row-Level Security (RLS):** Implemented via DAX governance rules (`USERPRINCIPALNAME()`) to enforce regional data role privacy and mask sensitive target salary bands based on corporate profiles.
* **Markdown:** Used to build clear, scannable, and bold-emphasized portfolio documentation for GitHub deployment.

## 🗂️ Data Architecture & Star Schema Model
To guarantee optimal DAX query execution speeds and modular enterprise scalability, this project rejects standard flat-file layouts in favor of a strictly structured **Star Schema Dimensional Model**.

* **Fact Tables:**
  * `Fact_Applications`: Captures candidate profile entries, sourcing channels, demographic markers, and categorical hiring costs.
  * `Fact_Interview_Logs`: A transactional, granular ledger tracking individual step-by-step interview stages, timeline durations, and interviewer feedback scores.
* **Dimension Tables:**
  * `Dim_Jobs`: Houses corporate vacancy parameters, departmental structures, and targeted base compensation budgets.
  * `Dim_Recruiters`: Tracks recruiter regional ownership (AMER, EMEA, APAC) and internal team allocations.
  * `Dim_Calendar`: A dedicated time-intelligence dimension built via specialized Power Query M-Code to handle complex calendar trends.

---

## 🧬 Advanced DAX & Analytical Business Logic
The core calculations move beyond basic summary stats, utilizing context-aware DAX expressions to isolate lifecycle behaviors across moving transactional boundaries.

### 1. Timeline Sequence Tracking: Average Time-to-Hire (Days)
Iterates through granular interview log timestamps to calculate the exact elapsed days between initial application entry and successful final offer conversion:
```dax
Avg Time-to-Hire (Days) = 
AVERAGEX(
    KEEPFILTERS(FILTER(VALUES('Fact_Applications'[ApplicationID]), [Total Hired] > 0)),
    VAR StartDate = CALCULATE(MIN('Fact_Interview_Logs'[StepDate]), 'Fact_Interview_Logs'[Stage] = "Applied")
    VAR HireDate = CALCULATE(MIN('Fact_Interview_Logs'[StepDate]), 'Fact_Interview_Logs'[Stage] = "Hired")
    RETURN DATEDIFF(StartDate, HireDate, DAY)
)
```

### 2. Fiscal Efficiency Optimization: **Cost-Per-Hire (CPH)**
Evaluates financial efficiency across disparate operational pipelines:
```dax
Cost-Per-Hire = DIVIDE(SUM('Fact_Applications'[RecruitmentCost]), [Total Hired], 0)
```

### 3. Funnel Conversion Metrics: Offer Acceptance Rate (OAR %)
Measures candidate pipeline closing strength at the ultimate conversion junction:
```dax
Offer Acceptance Rate (%) = DIVIDE([Total Hired], [Offers Extended], 0)
```
### Insights
* **Engineering Funnel Friction:** The **Engineering** department exhibits a disproportionately high dropout rate specifically during the **Technical Test** phase. This indicates an immediate need to align initial recruiter screening parameters with hiring manager technical expectations.
* **Sourcing Budget Arbitrage:** While third-party recruitment agencies provide direct hires, analysis of the **Cost-Per-Hire (CPH)** proves agency channels are **4.2x more expensive** than optimized internal referrals and LinkedIn pipelines, supporting a strategic pivot toward direct-sourcing budgets.
* **Velocity vs. Offer Rejection:** Data trends indicate that when **Time-to-Hire exceeds 45 days**, the **Offer Acceptance Rate drops by 30%**. Speed-to-market is the primary driver of closing top talent, showing that operational delays directly result in lost candidates.
