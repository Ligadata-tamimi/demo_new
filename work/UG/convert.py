import pandas as pd

# Read the output CSV file with one row of data
df = pd.read_csv("output_1.csv", header=None)

# Extract the date (which is the first value in the row)
date = df.iloc[0, 0]

# Extract the single row of data
data_row = df.iloc[0, :]

# Assign specific values to each column based on your instructions
df_selected = pd.DataFrame({
    "RGS1": [data_row[1]],
    "RGS30": [data_row[2]],
    "RGS90": [data_row[3]],
    "RGS90_OFFNET_IN_OUT": [data_row[4]],
    "Activations": [data_row[5]],
    "Returners": [data_row[6]],
    "Churn": [data_row[7]]
})

# Add a new column for the date
#df_selected["Date"] = date

# Transpose the DataFrame so that the column names become values in one column
df_selected_transposed = df_selected.T.reset_index()

# Rename the columns
df_selected_transposed.columns = ["Modernized RGS Subscribers",date]

# Save the selected columns to a new CSV file
df_selected_transposed.to_csv("selected_output.csv", index=False)

