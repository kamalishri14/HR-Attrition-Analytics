"""
HR Employee Attrition Analytics Dashboard
Run locally:  streamlit run app.py
Deploy free:  https://share.streamlit.io  (connect this GitHub repo)
"""
import streamlit as st
import pandas as pd
import plotly.express as px

st.set_page_config(page_title="HR Attrition Dashboard", page_icon="🧑‍💼", layout="wide")

df = pd.read_csv('data/hr_attrition_clean.csv')
# ---------------- Sidebar filters ----------------
st.sidebar.title("🔍 Filters")
departments = st.sidebar.multiselect("Department", sorted(df['Department'].unique()),
                                       default=sorted(df['Department'].unique()))
job_roles = st.sidebar.multiselect("Job Role", sorted(df['JobRole'].unique()),
                                     default=sorted(df['JobRole'].unique()))
overtime_filter = st.sidebar.multiselect("OverTime", sorted(df['OverTime'].unique()),
                                           default=sorted(df['OverTime'].unique()))
gender_filter = st.sidebar.multiselect("Gender", sorted(df['Gender'].unique()),
                                         default=sorted(df['Gender'].unique()))

mask = (
    df['Department'].isin(departments) &
    df['JobRole'].isin(job_roles) &
    df['OverTime'].isin(overtime_filter) &
    df['Gender'].isin(gender_filter)
)
fdf = df[mask]

# ---------------- Header ----------------
st.title("🧑‍💼 HR Employee Attrition Analytics Dashboard")
st.caption("Synthetic dataset (IBM HR Analytics schema) · Built with Python, Pandas & Streamlit")

# ---------------- KPI Row ----------------
total_emp = len(fdf)
attr_count = (fdf['Attrition'] == 'Yes').sum()
attr_rate = attr_count / total_emp * 100 if total_emp else 0
avg_income = fdf['MonthlyIncome'].mean() if total_emp else 0
avg_tenure = fdf['YearsAtCompany'].mean() if total_emp else 0
high_risk = len(fdf[(fdf['OverTime'] == 'Yes') & (fdf['JobSatisfaction'] <= 2)])

k1, k2, k3, k4, k5 = st.columns(5)
k1.metric("Total Employees", f"{total_emp:,}")
k2.metric("Attrition Count", f"{attr_count:,}")
k3.metric("Attrition Rate", f"{attr_rate:.1f}%")
k4.metric("Avg Monthly Income", f"₹{avg_income:,.0f}")
k5.metric("High Risk Employees", f"{high_risk:,}", help="OverTime=Yes AND Job Satisfaction ≤ 2")

st.divider()

# ---------------- Row 1: Department + OverTime ----------------
c1, c2 = st.columns(2)

with c1:
    dept_attr = (fdf.groupby('Department')['Attrition']
                 .apply(lambda x: (x == 'Yes').mean() * 100).sort_values(ascending=False).reset_index())
    dept_attr.columns = ['Department', 'AttritionRate']
    fig = px.bar(dept_attr, x='Department', y='AttritionRate',
                 title="Attrition Rate by Department", labels={'AttritionRate': 'Attrition Rate (%)'},
                 color='AttritionRate', color_continuous_scale='Purples')
    fig.update_layout(height=400, showlegend=False, coloraxis_showscale=False)
    st.plotly_chart(fig, use_container_width=True)

with c2:
    ot_attr = (fdf.groupby('OverTime')['Attrition']
               .apply(lambda x: (x == 'Yes').mean() * 100).reset_index())
    ot_attr.columns = ['OverTime', 'AttritionRate']
    fig = px.bar(ot_attr, x='OverTime', y='AttritionRate',
                 title="Attrition Rate: OverTime vs No OverTime", labels={'AttritionRate': 'Attrition Rate (%)'},
                 color='OverTime', color_discrete_map={'Yes': '#C44E52', 'No': '#55A868'})
    fig.update_layout(height=400, showlegend=False)
    st.plotly_chart(fig, use_container_width=True)

# ---------------- Row 2: Satisfaction + Tenure ----------------
c3, c4 = st.columns(2)

with c3:
    sat_order = ['Low', 'Medium', 'High', 'Very High']
    sat_attr = (fdf.groupby('JobSatisfactionLabel')['Attrition']
                .apply(lambda x: (x == 'Yes').mean() * 100).reindex(sat_order).reset_index())
    sat_attr.columns = ['JobSatisfaction', 'AttritionRate']
    fig = px.bar(sat_attr, x='JobSatisfaction', y='AttritionRate',
                 title="Attrition Rate by Job Satisfaction", labels={'AttritionRate': 'Attrition Rate (%)'},
                 color='AttritionRate', color_continuous_scale='RdYlGn_r')
    fig.update_layout(height=400, showlegend=False, coloraxis_showscale=False)
    st.plotly_chart(fig, use_container_width=True)

with c4:
    tenure_order = ['0-1 yrs', '2-3 yrs', '4-6 yrs', '7-10 yrs', '10+ yrs']
    tenure_attr = (fdf.groupby('TenureBand')['Attrition']
                   .apply(lambda x: (x == 'Yes').mean() * 100).reindex(tenure_order).reset_index())
    tenure_attr.columns = ['TenureBand', 'AttritionRate']
    fig = px.bar(tenure_attr, x='TenureBand', y='AttritionRate',
                 title="Attrition Rate by Tenure Band", labels={'AttritionRate': 'Attrition Rate (%)'},
                 color='AttritionRate', color_continuous_scale='OrRd')
    fig.update_layout(height=400, showlegend=False, coloraxis_showscale=False)
    st.plotly_chart(fig, use_container_width=True)

# ---------------- Row 3: Income box plot + Business Travel ----------------
c5, c6 = st.columns(2)

with c5:
    fig = px.box(fdf, x='Attrition', y='MonthlyIncome', color='Attrition',
                 title="Monthly Income Distribution by Attrition Status",
                 color_discrete_map={'Yes': '#DD8452', 'No': '#4C72B0'})
    fig.update_layout(height=400, showlegend=False)
    st.plotly_chart(fig, use_container_width=True)

with c6:
    travel_attr = (fdf.groupby('BusinessTravel')['Attrition']
                   .apply(lambda x: (x == 'Yes').mean() * 100).sort_values(ascending=False).reset_index())
    travel_attr.columns = ['BusinessTravel', 'AttritionRate']
    fig = px.bar(travel_attr, x='BusinessTravel', y='AttritionRate',
                 title="Attrition Rate by Business Travel", labels={'AttritionRate': 'Attrition Rate (%)'},
                 color='AttritionRate', color_continuous_scale='Oranges')
    fig.update_layout(height=400, showlegend=False, coloraxis_showscale=False)
    st.plotly_chart(fig, use_container_width=True)

# ---------------- Department x Job Role table ----------------
st.divider()
st.subheader("📋 Department × Job Role — Attrition Breakdown")
matrix = (fdf.groupby(['Department', 'JobRole']).agg(
    Employees=('EmployeeNumber', 'count'),
    AttritionRate=('Attrition', lambda x: round((x == 'Yes').mean() * 100, 2))
).reset_index().sort_values('AttritionRate', ascending=False))
st.dataframe(matrix, use_container_width=True, hide_index=True)

st.caption("Built by Kamali · Data: synthetic HR dataset (IBM HR Analytics schema) · Source code on GitHub")
