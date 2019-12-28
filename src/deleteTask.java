import Utils.DBUtils;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class deleteTask extends HttpServlet {
	static String PASSWORD;

	@Override
	public void init (){
		PASSWORD = "administrator";
	}

	@Override
	protected void doGet (HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String password = req.getParameter("PW");
		String id = req.getParameter("ID");
		PrintWriter pw = resp.getWriter();
		if (!PASSWORD.equals(password)){
			pw.println(1);
		}else{
			String query1 = "delete from files where id="+id+";";
			String query2 = "delete from task where id="+id+";";
			DBUtils.updateDB(query1);
			DBUtils.updateDB(query2);
			pw.println(0);
		}
	}
}
