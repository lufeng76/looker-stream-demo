# The name of this view in Looker is "V Taxi"
view: v_taxi {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `iceberg_dataset.v_taxi` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Latitude" in Explore.

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.



  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: taxi_location {
    type: location
    sql_latitude:${latitude} ;;
    sql_longitude:${longitude} ;;
  }

  dimension: meter_increment {
    type: number
    sql: ${TABLE}.meter_increment ;;
  }

  dimension: meter_reading {
    type: number
    sql: ${TABLE}.meter_reading ;;
  }

  dimension: passenger_count {
    type: string
    sql: ${TABLE}.passenger_count ;;
  }

  dimension: point_idx {
    type: string
    sql: ${TABLE}.point_idx ;;
  }

  dimension: ps_timestamp {
    type: string
    sql: ${TABLE}.ps_timestamp ;;
  }

  dimension: sg_publish {
    type: string
    sql: ${TABLE}.sg_publish ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: publish {
    type: time
    timeframes: [
      raw,
      time,
      date,
      minute,
      hour,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.sg_publish ;;
  }

  dimension: ride_id {
    type: string
    sql: ${TABLE}.ride_id ;;
  }

  dimension: ride_status {
    type: string
    sql: ${TABLE}.ride_status ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: average_meter_reading {
    type: average
    sql: ${meter_reading} ;;
  }

  measure: max_meter_reading {
    type: max
    sql: ${meter_reading} ;;
  }

  measure: max_publish_time {
    type: time
    sql: max(${TABLE}.sg_publish) ;;
  }
}
