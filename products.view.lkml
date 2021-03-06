view: products {
  sql_table_name: demo_db.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
    link: {
      label: "Brand Analytics Dashboard"
      url: "https://sandbox.dev.looker.com/dashboards/229?Date=90%20days&Country=USA&Brand={{ value | encode_uri }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
    value_format_name: usd
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }


  measure: count {
    type: count
    drill_fields: [product_details*]
  }

  measure: highest_priced_item {
    type: max
    sql: ${retail_price} ;;
    drill_fields: [product_details*]
    value_format_name: usd
}

measure: lowest_priced_item {
  type: min
  sql: ${retail_price} ;;
  drill_fields: [product_details*]
  value_format_name: usd
}

measure: avg_retail_price {
  type: average
  sql: ${retail_price} ;;
  drill_fields: [product_details*]
  value_format_name: usd
}
set: product_details {
  fields: [id, item_name, category, brand,inventory_items.count]
}
}
