package Utils;

import java.sql.*;

public class DBUtils {
	static final String URL = "jdbc:mysql://127.0.0.1:3306/SCIESport?user=root&serverTimezone=Hongkong";
	static final String USER = "root";
	static final String PASSWORD = "Aa*20021122";

	//Function which execute the database update command from query.
	public static void updateDB(String query){
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		try(Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);){
			Statement stm = conn.createStatement();
			stm.executeUpdate(query);
		} catch (SQLException e){
			e.printStackTrace();
		}
	}

	//Function used to obtain a database connection
	public static Connection getConn () throws SQLException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
		return conn;
	}
}
