import Utils.DBUtils;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class deleteFile extends HttpServlet {
	@Override
	protected void doGet (HttpServletRequest req, HttpServletResponse resp) {
		String id = req.getParameter("id");
		String fId = req.getParameter("fId");
		String query = String.format("UPDATE files SET file_%s = 0, f%s_format = null WHERE id = %s;", fId, fId, id);
		DBUtils.updateDB(query);
	}
}
