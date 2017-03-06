connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"



explore: order_items {
#   fields: [ALL_FIELDS*, -orders.order_tiers]
  ##view_name: order_items
  always_filter: {
    filters: {
      field: users.state
      value: "California"
    }
  }
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: one_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: user_facts {
    view_label: "Users"
    type: left_outer
    sql_on: ${users.id} = ${user_facts.user_id} ;;
    relationship: one_to_one
  }


}

explore: orders {
sql_always_where: ${users.state} = 'California' ;;
always_join: [users]
  fields: [ALL_FIELDS*, -users.first_name, -users.last_name]
  view_name: orders
  join: users {
    type: inner
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: user_facts {
    view_label: "Users"
    type: inner
    sql_on: ${user_facts.user_id} = ${orders.user_id};;
    relationship: many_to_one
  }
}

explore: products {
  persist_for: "4 hours"
  join: inventory_items {
    type: inner
    sql_on: ${inventory_items.product_id}=${products.id} ;;
    relationship: one_to_many
  }
  join:  order_items {
    fields: [order_items.was_returned]
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: one_to_many
  }
}


explore: users {
  join: user_facts {
    view_label: "Users"
    type: left_outer
    sql_on: ${user_facts.user_id} = ${users.id} ;;
    relationship: one_to_one
  }
  join:  orders {
    type: left_outer
    sql_on: ${orders.user_id}=${users.id} ;;
    relationship: one_to_many
  }

  join:  order_items {
    type: left_outer
    sql_on: ${orders.id}=${order_items.order_id} ;;
    relationship: one_to_many
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id}=${inventory_items.id} ;;
    relationship: one_to_many
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_many
  }

}
