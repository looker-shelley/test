- dashboard: products
  title: Products
  layout: tile
  tile_size: 100

  # filters:

  elements:

  - name: inventory_items_by_brand
    title: "Inventory Items by Brand"
    type: looker_column
    model: shelley_test
    explore: products
    dimensions: [products.brand, inventory_items.is_sold]
    pivots: [inventory_items.is_sold]
    fill_fields: [inventory_items.is_sold]
    measures: [inventory_items.count]
    sorts: [inventory_items.count desc 0, inventory_items.is_sold]
    limit: '15'
    column_limit: '50'
    query_timezone: America/Los_Angeles
    stacking: percent
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"

  - name: brand_pricing_information
    title: "Brand Pricing Information"
    type: looker_column
    model: shelley_test
    explore: products
    dimensions: [products.brand]
    measures: [products.highest_priced_item, products.lowest_priced_item, products.avg_retail_price,
      inventory_items.count]
    filters:
      inventory_items.is_sold: 'Yes'
    sorts: [inventory_items.count desc]
    limit: '15'
    column_limit: '30'
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_null_points: true
    point_style: circle
    interpolation: linear
    hidden_series: []
    series_types:
      products.highest_priced_item: scatter
      products.lowest_priced_item: scatter
      products.avg_retail_price: scatter
    series_labels:
      inventory_items.count: Items Sold

  - name: inventory_by_category
    title: "Inventory Details by Category"
    type: looker_bar
    model: shelley_test
    explore: products
    dimensions: [products.category, inventory_items.is_sold]
    pivots: [inventory_items.is_sold]
    fill_fields: [inventory_items.is_sold]
    measures: [inventory_items.count]
    sorts: [inventory_items.count desc 0, inventory_items.is_sold]
    limit: '500'
    column_limit: '50'
    query_timezone: America/Los_Angeles
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    width: 12
    height: 6
