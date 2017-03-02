view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }


  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
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
  dimension: is_teen {
    type: yesno
    sql: ${age} > 12 and ${age} <20 ;;
    description: "A user between the ages of 13 and 19"
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: full_name {
    type: string
    sql: concat(${first_name},' ', ${last_name}) ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zipcode {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

dimension: user_status {
type: string
case: {
  when: {
    sql: ${orders.id} is null ;;
    label: "Non-Active"
  }
  else: "Active User"
}
}

dimension: first_purchase_lag {
  type: number
  sql: datediff(${user_facts.first_order_date}, ${created_date}) ;;
  drill_fields: [detail*]
  description: "The amount of time between when a user creates an account and makes their first purchase"
}

  measure: count {
    type: count
    drill_fields: [detail*]
  }

measure: average_user_purchasing_lag {
  type: average
  sql: ${first_purchase_lag} ;;
  drill_fields: [detail*]
}


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [id, full_name, age, gender, email]
  }

}
