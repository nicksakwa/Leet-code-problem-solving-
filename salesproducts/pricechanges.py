import pandas as pd
def price_at_given_date(products: pd.DataFrame) -> pd.DataFrame:
    on_or_before = products[products['change_date'] <= '2019-08-16']
    latest_price = on_or_before.sort_values('change_date').drop_duplicates('product_id', keep='last')
    latest_price = latest_price[['product_id', 'new_price']].rename(columns={'new_price':'price'})

    all_ids =set(products['product_id'])
    ids_with_changes = set(latest_price['product_id'])
    ids_with_no_changes = all_ids - ids_with_changes

    default_prices = pd.DataFrame({
        'product_id':list(ids_with_no_changes),
        'price':10
    })
    return pd.concat([latest_price, default_prices])