import pandas as pd

# Read the first output CSV file with one row of data
df1 = pd.read_csv("output_1.csv", header=None)

# Extract the date (which is the first value in the row)
date1 = df1.iloc[0, 0]

# Extract the single row of data
data_row1 = df1.iloc[0, :]

# Assign specific values to each column based on your instructions
net_addition = data_row[7] - (data_row[5] + data_row[6])
df_selected1 = pd.DataFrame({
    "RGS1 Base (ND)": [data_row1[1]],
    "RGS30 Base (ND)": [data_row1[2]],
    "RGS90 Base (ND)": [data_row1[3]],
    "RGS90_OFFNET_IN_OUT": [data_row1[4]],
    "Activations": [data_row1[5]],
    "Returners": [data_row1[6]],
    "Churn": [data_row1[7]],
    "Net Adittion": [net_addition]
})

# Transpose the DataFrame so that the column names become values in one column
df_selected_transposed1 = df_selected1.T.reset_index()

# Rename the columns
df_selected_transposed1.columns = ["Modernized RGS Subscribers", date1]

# Save the selected columns to a new CSV file
df_selected_transposed1.to_csv("selected_output.csv", index=False)

# Insert empty row
with open("selected_output.csv", "a") as f:
    f.write("\n")

# Read the second output CSV file with one row of data
df2 = pd.read_csv("output_2.csv", header=None)

# Extract the date (which is the first value in the row)
date2 = str(df2.iloc[0, 0])  # Convert to string

# Extract the single row of data
data_row2 = df2.iloc[0, :]

# Define column names for df_selected2
column_names = [
    "Subscribers - Business Defined " + date2,
    "RGS:1 Base (ND)",
    "RGS30 Base (ND)",
    "RGS90 Base (ND)",
    "Total Subscriber Base (Active in IN)",
    "Total Installed Base (Market Stock)",
    "New sim sales: Fully Verified",
    "Activations (Active IN)",
    "RGS Activation",
    "Reconnections",
    "Churn"
]
# Fill missing elements in data_row2 with None
data_row2_extended = data_row2.tolist() + [None] * (len(column_names) - len(data_row2))

# Assign specific values to each column based on your instructions for df_selected2
df_selected2 = pd.DataFrame({
    column_names[i]: [data_row2_extended[i]] for i in range(len(column_names))
})

# Transpose the DataFrame so that the column names become values in one column
df_selected_transposed2 = df_selected2.T.reset_index()

# Rename the columns
df_selected_transposed2.columns = ["Modernized RGS Subscribers", date2]

# Save the selected columns to a new CSV file
df_selected_transposed2.to_csv("selected_output.csv", mode='a', header=False, index=False)

