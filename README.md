# Enterprise Talent Acquisition & Recruitment Intelligence Suite

![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![DAX](https://img.shields.io/badge/DAX-Data_Analysis_Expressions-blue?style=for-the-badge)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Data Governance](https://img.shields.io/badge/Security-Row_Level_Security-red?style=for-the-badge)

## 📌 Project Deliverables
* **Production Power BI Workspace File:** [`Enterprise_TA_Analytics.pbix`](./Enterprise_TA_Analytics.pbix)
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

---

### **2. Fiscal Efficiency Optimization: Cost-Per-Hire (CPH)**
Evaluates financial efficiency across disparate operational pipelines:
```dax
Cost-Per-Hire = DIVIDE(SUM('Fact_Applications'[RecruitmentCost]), [Total Hired], 0)

3. Funnel Conversion Metrics: Offer Acceptance Rate (OAR %)
Measures candidate pipeline closing strength at the ultimate conversion junction:
```dax
Offer Acceptance Rate (%) = DIVIDE([Total Hired], [Offers Extended], 0)
