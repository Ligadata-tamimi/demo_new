#!/bin/bash

# Define the SSH and Presto CLI command with queries
SSH_CMD="ssh 10.156.42.131 /opt/presto/bin/presto --server ugmpdaasenode-01:7099 --catalog hive --schema devdata --execute"

# Define your queries
QUERIES=(
    \""SELECT tbl_dt, kv[1006] AS RGS1, kv[1001] AS RGS30, kv[1004] AS rgs90, kv[1138] AS RGS90_OFFNET_IN_OUT, kv[1003] AS activations, kv[1008] AS reconnections, kv[1010] AS churn FROM ( SELECT tbl_dt, map_agg(service_sub_key, amount) kv FROM kpi.aggr_subscriber WHERE tbl_dt=20240222 GROUP BY tbl_dt );\""
    \""SELECT tbl_dt, kv[1026] AS RGS1_new, kv[1030] AS RGS30_new, kv[1024] AS rgs90_new, kv[54] AS Total_Installed_Base_Market_Stock, kv[4] AS New_sim_sales_Fully_Verified , kv[97] as Activations_Active_IN, kv[1023] as RGS_Activation, kv[1028] as Reconnections, kv[1029] as Churn FROM ( SELECT tbl_dt, map_agg(service_sub_key, amount) kv FROM kpi.aggr_subscriber WHERE tbl_dt=20240222 GROUP BY tbl_dt );\""
    # Add more queries as needed
)

# Execute each query and write the results to separate CSV files
for (( i=0; i<${#QUERIES[@]}; i++ )); do
    # Execute the SSH and Presto CLI command for the current query
    OUTPUT=$($SSH_CMD "${QUERIES[$i]}")
    
    # Split the output into lines and extract the data lines
    IFS=$'\n' read -d '' -r -a DATA_LINES <<<"$OUTPUT"
    
    # Check if data_lines is not empty
    if [ ${#DATA_LINES[@]} -gt 0 ]; then
        # Get the header and data
        HEADER="${DATA_LINES[0]}"
        DATA="${DATA_LINES[@]:1}"
        
        # Write parsed data to CSV file
        FILENAME="report_$((i+1)).csv"
        echo "$HEADER" > "$FILENAME"
        echo "$DATA" | sed 's/\t/,/g' >> "$FILENAME"
        
        echo "Query $((i+1)) results saved to $FILENAME"
    else
        echo "No data returned for query $((i+1))"
    fi
done

