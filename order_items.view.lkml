view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: was_returned {
    type: yesno
    sql: ${returned_date} is not null ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
    value_format: "$0.00"
  }


dimension:  profit {
  type:  number
  sql: case when ${was_returned} ='no' then ${sale_price} - ${inventory_items.cost} else 0 end ;;
  value_format_name: usd
  label: "Gross Margin"
}


  dimension: gross_margin_percentage {
    type: number
    sql: 1.0*${profit}/nullif(${sale_price},0) ;;
    value_format_name: percent_2
  }


  measure: count {
    type: count
    drill_fields: [order_item_details*]
  }

  measure: total_sales {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd_0
    drill_fields: [order_item_details*]

  }
  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
    value_format_name: usd
    drill_fields: [order_item_details*]
  }


  measure: total_profit {
    type: sum
    sql: ${profit};;
    value_format_name: usd_0
    drill_fields: [order_item_details*, gross_margin_percentage]
  }

measure:  average_profit {
  type:  average
  sql: ${profit};;
  value_format_name: usd_0
  drill_fields: [order_item_details*, gross_margin_percentage]
}

  measure: avg_gross_margin_percentage {
    type: number
    sql: 1.0* ${average_profit}/nullif(${average_sale_price},0) ;;
    value_format_name: percent_2
    drill_fields: [order_item_details*, average_profit, average_sale_price]
  }


measure: teen_profits {
  type: sum
  sql: ${profit};;
  filters: {
    field: users.is_teen
    value: "yes"
  }
  value_format_name: usd_0
  drill_fields: [order_item_details*, gross_margin_percentage, users.age]
}

  measure: max_item_price {
    type: max
    sql: ${sale_price} ;;
    value_format_name: usd
    drill_fields: [order_item_details*]
  }

  measure: min_item_price {
    type: min
    sql: ${sale_price};;
    value_format_name: usd
    drill_fields: [order_item_details*]
  }

set: order_item_details {
fields: [id, users.full_name, products.category, products.item_name, sale_price]
}
}
