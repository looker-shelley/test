view: inventory_items {
  sql_table_name: demo_db.inventory_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
    value_format_name: usd
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: sold {
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
    sql: ${TABLE}.sold_at ;;
  }

  dimension:  is_sold {
    type: yesno
    sql: ${sold_month} is not null ;;
  }

  measure: count {
    type: count
    drill_fields: [item_detail*, order_items.count]
  }

  measure: average_cost {
    type: average
    sql: ${cost}  ;;
    value_format_name: usd
    drill_fields: [item_detail*]
  }

  measure: average_cost_of_items_sold {
    type: average
    sql: ${cost} ;;
    filters: {
      field: is_sold
      value: "yes"
    }
    drill_fields: [item_detail*, order_items.count]
    value_format_name: usd
  }

  set: item_detail {
    fields: [products.item_name, cost, products.retail_price]
  }
}
