import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtils {
	static final String URL = "jdbc:mysql://127.0.0.1:3306/scie_sport?user=root&serverTimezone=Hongkong";
	static final String USER = "root";
	static final String PASSWORD = "admin";
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
}
