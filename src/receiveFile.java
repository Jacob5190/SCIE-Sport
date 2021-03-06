import Utils.DBUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.io.IOException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
@MultipartConfig()
public class receiveFile extends HttpServlet {
	static final String SEPARATOR = File.separator;
	@Override
	protected void doPost (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Part identifier = req.getPart("identifier");
		Part fileName = req.getPart("fileName");
		Part file = req.getPart("file");
		String fileId = new BufferedReader(new InputStreamReader(identifier.getInputStream())).readLine();
		String fName = new BufferedReader(new InputStreamReader(fileName.getInputStream())).readLine();
		String directory = req.getSession().getServletContext().getRealPath("/files");
		//Check which file is uploaded.
		switch (fileId) {
			case "1":
				directory = directory + SEPARATOR + "report";
				break;
			case "2":
				directory = directory + SEPARATOR + "r_video";
				break;
			case "3":
				directory = directory + SEPARATOR + "e_video";
				break;
			case "4":
				directory = directory + SEPARATOR + "g_file";
				break;
			default:
				directory = "NULL";
				break;
		}
		//Create file path if the file does not exist.
		new File(directory).mkdirs();
		new File(directory + SEPARATOR +  fName).createNewFile();
		try {
			file.write(directory + SEPARATOR + fName);
			resp.getWriter().println("File write to: " + directory + SEPARATOR + fName);
			updateDB(fileId, fName);
		}catch (Exception e){
			resp.getWriter().println(e.getMessage());
		}
	}
	private static void updateDB(String identifier, String fName) {
		String fId = fName.substring(fName.lastIndexOf(".") - 1, fName.lastIndexOf("."));
		String fFormat = fName.substring(fName.lastIndexOf("."));
		String file = "file_" + identifier;
		//Format the query statement to inset the data into database.
		String query = String.format("UPDATE files SET %s = 1, f%s_format = \"%s\" WHERE id = %s;", file, identifier, fFormat, fId);
		DBUtils.updateDB(query);
	}
}
