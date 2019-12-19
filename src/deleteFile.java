import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class deleteFile extends HttpServlet {
	@Override
	protected void doGet (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		String fId = req.getParameter("f_id");
		updateDB(id, fId);
	}
	private static void updateDB(String id, String fId){
		String query = String.format("UPDATE files SET file_%s = 0, f%s_format = null WHERE id = %s;", fId, fId, id);
		DBUtils.updateDB(query);
	}
}
