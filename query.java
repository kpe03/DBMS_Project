import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Statement;
import java.util.Scanner;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;


/*
 * Make connections to the database
 */
public class query{
	 // Database credentials
    final static String HOSTNAME = "pete0272-sql-server.database.windows.net";
    final static String DBNAME = "cs-dsa-4513-sql-db";
    final static String USERNAME = "pete0272";
    final static String PASSWORD = "Ambergrisb03!";

    // Database connection string
    final static String URL = String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;",
            HOSTNAME, DBNAME, USERNAME, PASSWORD);
    
    
    /*
     * string of all the queries to be asked
     */
    final static String PROMPT = 
            "\nPlease select one of the options below: \n" +
            "1) Enter a new team into the database \n" + 
            "2) Enter a new client into the database and associate him or her with one or more teams\n" + 		
            "3) Enter a new volunteer into the database and associate him or her with one or more teams \n" + 
            "4) Enter the number of hours a volunteer worked this month for a particular team \n" +
            "5) Enter a new employee into the database and associate him or her with one or more teams \n" + 
            "6) Enter an expense charged by an employee \n" + 
            "7) Enter a new donor and associate him or her with several donations \n  " + 
            "8) Retrieve the name and phone number of the doctor of a particular client \n  " +
            "9) Retrieve the total amount of expenses charged by each employee for a particular period of "
            + "time. The list should be sorted by the total amount of expenses \n  " +
            "10) Retrieve the list of volunteers that are members of teams that support a particular client \n  " +
            "11) Retrieve the names of all teams that were founded after a particular date \n  " +
            "12) Retrieve the names, social security numbers, contact information, and emergency contact "  + 
            "information of all people in the database  \n" +
            "13) Retrieve the name and total amount donated by donors that are also employees. The list "
            + "should be sorted by the total amount of the donations, and indicate if each donor wishes to "
            + "remain anonymous  " +
            "14) Increase the salary by 10% of all employees to whom more than one team must report \n" +
            "15) Delete all clients who do not have health insurance and whose value of importance for transportation is less than 5" +
            "16)Import: enter new teams from a data file until the file is empty (the user must be asked" +
            " to enter the input file name). \n" +
            "17) Export: Retrieve names and mailing addresses of all people on the mailing list and " +
             "output them to a data file instead of screen (the user must be asked to enter the output file " +
             "name).  \n" +
            "18) Quit \n";
            
    /*
     * Main function with exception handling
     */
    public static void main(String[] args) throws SQLException {
    	System.out.println("Welcome to the Patient Assistant Network (PAN) Database System");
    	
    	 final Scanner sc = new Scanner(System.in); // Scanner is used to collect the user input
         String option = ""; // Initialize user option selection as nothing
         
         //create a connection
         Connection conn = DriverManager.getConnection(URL);
         //loop until user selects query 18 to QUIT
         while (!option.equals("18")) { 
        	 System.out.println(PROMPT); // print the available queries
        	 option = sc.next(); //get user input

        	 //conditonal for queries
             switch (option) {
	             case "1":
	            	 enterTeam(conn, sc);
	            	 break;
	            	 
	             case "2":
	            	 break;
	            	 
	             case "3":
	            	 break;
	            	 
	             case "4":
	            	 break;
	            	 
	             case "5":
	            	 break;
	            	 
	             case "6":
	            	 break;
	            	 
	             case "7":
	            	 break;
	            	 
	             case "8":
	            	 break;
	            	 
	             case "9":
	            	 break;
	            	 
	             case "10":
	            	 break;
	            	 
	             case "11":
	            	 break;
	            	 
	             case "12":
	            	 break;
	            	 
	             case "13":
	            	 break;
	            	 
	             case "14":
	            	 break;
	            	 
	             case "15":
	            	 break;
	            	 
	             case "16":
	            	 break;
	            	 
	             case "17":
	            	 break;
	            	 
	             case "18":
	            	 break;
             }
         }

    }
    
    
    /*
     * query 1
     */
    public static void enterTeam(Connection conn, Scanner sc) throws SQLException{
    	String input1, input2, input3;
    	
    	//gather the inputs
    	System.out.println("1) Enter a team\n");
    	
    	System.out.println("Enter the team name: \n");
    	input1 = sc.next();
    	
    	System.out.println("Enter the team type: \n");
    	input2 = sc.next();
    	
    	System.out.println("Enter the date that the team formed: \n");
    	input3 = sc.next();
    	Date date = java.sql.Date.valueOf(input3); //convert to a date object
      	
    	
    	
    	//create the connection
    	CallableStatement stmt = conn.prepareCall("{call enterTeam(?, ?, ?)}");
    	stmt.setString(1, input1);
    	stmt.setString(2, input2);
    	stmt.setDate(3, date);
    }
    
    /*
     * query 2
     */
    public static void enterClient(Connection conn, Scanner sc) throws SQLException{
//    	String cname, cphone, relationship;
//    	String ssn, pname, gender, profession, mailingList, mailingAddr, emailAddr, phone, 
//    		assignmentDate, doctorName, doctorPhone;
//    	String team_name;
    	String input;
    	int intInput;
    	
    	//configure the connection string
    	CallableStatement stmt = conn.prepareCall("{call enterClient(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
    	
   
    	System.out.println("Enter the client's emergency contact name:\n");
    	input = sc.next();
    	stmt.setString(1, input);
    	
    	System.out.println("Enter the client's emergency contact phone number:\n");
     	input = sc.next();
    	stmt.setString(2, input);
    	
    	System.out.println("Enter the emergency contact's relationship with the client:\n");
    	input = sc.next();
      	stmt.setString(3, input);
      	
    	System.out.println("Enter the client's social security number:\n");
    	intInput = sc.nextInt();
      	stmt.setInt(4, intInput);
      	
    	System.out.println("Enter the client's gender:\n");
    	input = sc.next();
      	stmt.setString(5, input);
      	
    	System.out.println("Enter the client's profession:\n");
    	input = sc.next();
      	stmt.setString(6, input);
      	
    	System.out.println("Is the client on the mailing list? (Y or N)\n");
    	input = sc.next();
      	stmt.setString(7, input);
      	
    	System.out.println("Enter the client's mailing address:\n");
    	input = sc.next();
      	stmt.setString(8, input);
      	
    	System.out.println("Enter the client's email address:\n");
    	input = sc.next();
      	stmt.setString(9, input);
      	
    	System.out.println("Enter the client's phone number:\n");
    	input = sc.next();
      	stmt.setString(10, input);
    	
    	System.out.println("Enter the client's assignment date:\n");
    	input = sc.next();
    	Date date = java.sql.Date.valueOf(input); //convert to a date object
      	stmt.setDate(11, date);
      	
    	System.out.println("Enter the client's doctor's name:\n");
    	input = sc.next();
      	stmt.setString(12, input);
      	
    	System.out.println("Enter the client's doctor's phone number: \n");
    	input = sc.next();
      	stmt.setString(13, input);
      	
    	
    	System.out.println("Enter the team name associated with this client: \n");
    	input = sc.next();
      	stmt.setString(14, input);
    }
    
    /*
     * query 3
     */
    public static void enterVolunteer(Connection conn, Scanner sc) throws SQLException{
    	String input;
    	int intInput;
    	
    	//configure the connection string
    	CallableStatement stmt = conn.prepareCall("{call enterClient(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
    	
//   
//    	System.out.println("Enter the volunteer's emergency contact name:\n");
//    	input = sc.next();
//    	stmt.setString(1, input);
//    	
//    	System.out.println("Enter the volunteer's emergency contact phone number:\n");
//     	input = sc.next();
//    	stmt.setString(2, input);
//    	
//    	System.out.println("Enter the emergency contact's relationship with the client:\n");
//    	input = sc.next();
//      	stmt.setString(3, input);
//      	
    	/*
    	 * volunteer information
    	 */
    	System.out.println("Enter the volunteer's social security number:\n");
    	intInput = sc.nextInt();
      	stmt.setInt(4, intInput);
      	
    	System.out.println("Enter the volunteer's gender:\n");
    	input = sc.next();
      	stmt.setString(5, input);
      	
    	System.out.println("Enter the volunteer's profession:\n");
    	input = sc.next();
      	stmt.setString(6, input);
      	
    	System.out.println("Is the volunteer on the mailing list? (Y or N)\n");
    	input = sc.next();
      	stmt.setString(7, input);
      	
    	System.out.println("Enter the volunteer's mailing address:\n");
    	input = sc.next();
      	stmt.setString(8, input);
      	
    	System.out.println("Enter the volunteer's email address:\n");
    	input = sc.next();
      	stmt.setString(9, input);
      	
    	System.out.println("Enter the volunteer's phone number:\n");
    	input = sc.next();
      	stmt.setString(10, input);
    	
    	System.out.println("Enter the volunteer's date joined:\n");
    	input = sc.next();
    	Date date = java.sql.Date.valueOf(input); //convert to a date object
      	stmt.setDate(11, date);
      	
      	System.out.println("Enter the volunteer's date training:\n");
    	input = sc.next();
    	date = java.sql.Date.valueOf(input); //convert to a date object
      	stmt.setDate(12, date);
      	
      	System.out.println("Enter the volunteer's emergency contact name:\n");
    	input = sc.next();
    	date = java.sql.Date.valueOf(input); //convert to a date object
      	stmt.setDate(12, date);
      	
    	/*
    	 * servesOn information
    	 */
    	System.out.println("Enter the team name associated with this client: \n");
    	input = sc.next();
      	stmt.setString(14, input);
    }
}
    