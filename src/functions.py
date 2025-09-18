import pandas as pd
import numpy as np
import re
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Returns a DataFrame of unique (group_col, neigh_col) pairs ordered by group_col and neigh_col.
def get_ordered_pairs(df, group_col, neigh_col):
    return (
        df[[group_col, neigh_col]]
        .drop_duplicates()
        .sort_values(by=[group_col, neigh_col])
        .reset_index(drop=True)
    )

# Merge two pandas DataFrames with customizable parameters.
def merge_dataframes(
    left_df, right_df,
    left_on, right_on,
    how='inner'
):
    return pd.merge(left_df, right_df, left_on=left_on, right_on=right_on, how=how)

# Returns a DataFrame with only the specified columns, for exporting listings or other data.
def select_columns_for_export(df, columns):
    return df[columns].copy()

# def load_data(file_path):
#     return pd.read_excel(file_path)

# Drop unnecessary columns
def drop_irrelevant_columns(df: pd.DataFrame, columns) -> pd.DataFrame:
    return df.drop(columns=columns, errors='ignore')

# Remove all punctuation and all special characters (keeps only letters, numbers, and spaces)
def remove_all_punctuation(df: pd.DataFrame, column) -> pd.DataFrame:
    df[column] = df[column].apply(lambda x: re.sub(r'[^A-Za-z0-9 ]+', '', x) if isinstance(x, str) else x)
    return df
    
# Removes any row from the dataframe where any of the specified columns have a missing (null/NaN) value.
def drop_rows_with_missing(df: pd.DataFrame, columns) -> pd.DataFrame:
    if isinstance(columns, str): # Ensure columns is a list
        columns = [columns]
    return df.dropna(subset=columns)

# Plots the average price per neighbourhood_group (borough) from an Airbnb DataFrame.
def plot_avg_price_per_borough(df: pd.DataFrame) -> pd.DataFrame:
    avg_price_borough = df.groupby('neighbourhood_group')['price'].mean().sort_values(ascending=False).reset_index()
    
    plt.figure(figsize=(8,5))
    sns.barplot(data=avg_price_borough, x='neighbourhood_group', y='price')
    plt.title('Average Price per Borough')
    plt.ylabel('Average Price (USD)')
    plt.xlabel('Borough')
    plt.show()

# Plots the most frequent room type per borough
def plot_most_frequent_room_type_per_borough(df: pd.DataFrame) -> pd.DataFrame:
    room_type_counts = df.groupby(['neighbourhood_group', 'room_type']).size().reset_index(name='count')
    most_freq_room = room_type_counts.sort_values(['neighbourhood_group','count'], ascending=[True, False]) \
        .groupby('neighbourhood_group').first().reset_index()
    
    plt.figure(figsize=(8,5))
    sns.barplot(data=most_freq_room, x='neighbourhood_group', y='count', hue='room_type', dodge=False, palette='Set2')
    plt.title('Most Frequent Room Type per Borough')
    plt.ylabel('Number of Listings')
    plt.xlabel('Borough')
    plt.legend(title='Room Type')
    plt.show()

# Plots the average minimum nights per neighbourhood_group (borough).
def plot_avg_minimum_nights_per_borough(df: pd.DataFrame) -> pd.DataFrame:
    avg_min_nights = df.groupby('neighbourhood_group')['minimum_nights'].mean().sort_values(ascending=False).reset_index()
    
    plt.figure(figsize=(8,5))
    sns.barplot(data=avg_min_nights, x='neighbourhood_group', y='minimum_nights')
    plt.title('Average Minimum Nights per Borough')
    plt.ylabel('Average Minimum Nights')
    plt.xlabel('Borough')
    plt.show()

# Buckets listings by their yearly availability and plots the average price for each bucket.
def plot_avg_price_by_availability_bucket(df: pd.DataFrame) -> pd.DataFrame:
    def availability_bucket(x):
        if 0 <= x <= 90:
            return '0–90'
        elif 91 <= x <= 180:
            return '91–180'
        elif 181 <= x <= 270:
            return '181–270'
        else:
            return '271–365'
    
    df['availability_bucket'] = df['availability_365'].apply(availability_bucket)
    avail_price = df.groupby('availability_bucket')['price'].mean().reset_index()
    
    plt.figure(figsize=(8,5))
    sns.barplot(data=avail_price, x='availability_bucket', y='price')
    plt.title('Availability vs Price (Buckets)')
    plt.xlabel('Availability (Days per Year)')
    plt.ylabel('Average Price (USD)')
    plt.show()


# Plots the top 5 most expensive neighborhoods (by average price) with at least `min_listings` listings.
def plot_topX_expensive_neighborhoods_min_listings(df: pd.DataFrame, min_listings=30):
    neigh_prices = df.groupby(['neighbourhood_group','neighbourhood']).agg(
        avg_price=('price', 'mean'),
        listings=('price', 'size')
    ).reset_index()
    
    top_neigh = neigh_prices[neigh_prices['listings'] >= min_listings].sort_values('avg_price', ascending=False).head(5)
    
    plt.figure(figsize=(10,6))
    sns.barplot(
        data=top_neigh, 
        x='neighbourhood', 
        y='avg_price', 
        hue='neighbourhood_group',
        dodge=False,
        palette='tab10'
    )
    plt.title('Top x Most Expensive Neighborhoods (min 30 listings)')
    plt.ylabel('Average Price (USD)')
    plt.xlabel('Neighborhood')
    plt.xticks(rotation=30)
    plt.legend(title='Borough')
    plt.show()
