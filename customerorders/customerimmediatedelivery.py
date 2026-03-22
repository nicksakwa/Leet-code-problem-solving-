import pandas as pd
def immediate_food_delivery(delivery: pd.DataFrame) -> pd.DataFrame:
    first_orders = delivery.sort_values(['custome_id', 'order_date']).drop_duplicates('customer_id')
    is_immediate = first_orders['order_date'] == first_orders['customer_pref_delivery_date']
    percentage = round(is_immediate.mean() * 100, 2)
    return pd.DataFrame({'immediate_percentage':[percentage]})