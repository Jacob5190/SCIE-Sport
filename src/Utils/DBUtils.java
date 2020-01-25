package Utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtils {
	static final String URL = "jdbc:mysql://127.0.0.1:3306/SCIE_Sport?user=root&serverTimezone=Hongkong";
	static final String USER = "root";
	static final String PASSWORD = "admin";

	//Function which execute the database update command from query.
	public static void updateDB(String query){
		try {
			Connection conn = getConn();
			Statement stm = conn.createStatement();
			stm.executeUpdate(query);
		}catch (SQLException e){
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
