view: User_Sales_info{
  derived_table: {
    sql: SELECT
        ord.user_id AS User_info,
        COUNT(*) AS Total_OID,
        oitems.sale_price AS SALES,
        AVG(oitems.sale_price) as Avg_Sales_Price,
        SUM(oitems.sale_price) as Total_Sales_Price
      FROM order_items AS oitems
      LEFT JOIN orders AS ord
      ON oitems.order_id = ord.id

      GROUP BY user_id
       ;;
    indexes: ["User_info"]

  }

  dimension: User_info {
   # primary_key: yes
    #hidden: yes
    sql: ${TABLE}.User_info ;;
  }

dimension: SALES {
  type:  number
  sql: ${TABLE}.SALES ;;
}
  dimension: Total_OID {
    type: number
    sql: ${TABLE}.Total_OID ;;
  }

  dimension: lifetime_items_tiered {
    type: tier
    tiers: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 30, 50, 100, 200]
    sql: ${Total_OID} ;;
  }

  dimension: Avg_Sales_Price {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.Avg_Sales_Price ;;
  }

  dimension: Total_Sales_Price {
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.Total_Sales_Price ;;
  }

  dimension: lifetime_revenue_tiered {
    type: tier
    tiers: [0, 5, 10, 15, 20, 25, 50, 100, 250, 500, 1000]
    sql: ${Total_Sales_Price} ;;
  }
  measure: AVG_SALES {
    type: sum
    sql: ${SALES} ;;
    value_format_name: decimal_2
  }
}
