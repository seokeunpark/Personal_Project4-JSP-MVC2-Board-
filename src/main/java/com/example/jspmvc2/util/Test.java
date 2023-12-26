package com.example.jspmvc2.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Map;

public class Test {

    public static void test1(Map<String, Object> map) {
        /*Connection connection = new Connection();
        PreparedStatement preparedStatement = connection.prepareStatement();
        preparedStatement.set*/
        String query = "SELECT * " +
                       "FROM mvcboard " +
                       "WHERE idx > 0 " ;

        if (map.get("searchWord") != null && !((String) map.get("searchWord")).equals("")) {
            if (map.get("searchField").equals("title")) {
                query += "and title like concat('%', " + map.get("searchWord") + ", '%') ";
            } else if (map.get("searchWord").equals("content")) {
                query += "and content like concat('%', " + map.get("searchWord") + ", '%') ";
            }
        }

        query += "LIMIT ?, 10";
    }
}
