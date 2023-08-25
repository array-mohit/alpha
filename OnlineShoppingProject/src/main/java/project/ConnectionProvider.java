package project;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {
	public static Connection getCon() {
		Connection connection = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineshoppingproject","root","root@98754321");
			return connection;
			
		}catch(Exception e) {
			System.out.println(e);
			return null;
		}
		
	}
}
