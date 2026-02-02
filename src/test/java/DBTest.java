import java.sql.Connection;
import java.sql.DriverManager;

public class DBTest {
    public static void main(String[] args) throws Exception {
        Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3307/sys",
                "root",
                "pmg82004"
        );
        System.out.println("CONNECTED TO MYSQL 3307");
    }
}
