import Utils.DBUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class createTask extends HttpServlet {
	@Override
	protected void doGet (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int id;
		String title, grade, gender, photo, report, ddl, query1, query2;
		id = Integer.parseInt(req.getParameter("id"));
		title = req.getParameter("title");
		grade = req.getParameter("grade");
		gender = req.getParameter("gender");
		photo = req.getParameter("photo");
		report = req.getParameter("report");
		ddl = req.getParameter("ddl");
		query1 = String.format(
				"insert into task(id, title, grade, gender, photo, report, ddl) " +
				"values(%d, \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\");",
				id, title, grade, gender, photo, report, ddl);
		query2 = "insert into files(id) values(" + id + ");";
		//Create new task info in the database.
		//Create corresponding empty file data in database.
		DBUtils.updateDB(query1);
		DBUtils.updateDB(query2);
		resp.getWriter().println(0);
	}
}
