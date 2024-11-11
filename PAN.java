// Kaitlyn Peters
// PAN Database System
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
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
public class PAN{
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
            "7) Enter a new donor and associate him or her with several donations \n" + 
            "8) Retrieve the name and phone number of the doctor of a particular client \n" +
            "9) Retrieve the total amount of expenses charged by each employee for a particular period of "
            + "time. The list should be sorted by the total amount of expenses \n" +
            "10) Retrieve the list of volunteers that are members of teams that support a particular client \n" +
            "11) Retrieve the names of all teams that were founded after a particular date \n" +
            "12) Retrieve the names, social security numbers, contact information, and emergency contact "  + 
            "information of all people in the database  \n" +
            "13) Retrieve the name and total amount donated by donors that are also employees. The list "
            + "should be sorted by the total amount of the donations, and indicate if each donor wishes to "
            + "remain anonymous  \n" +
            "14) Increase the salary by 10% of all employees to whom more than one team must report \n" +
            "15) Delete all clients who do not have health insurance and whose value of importance for transportation is less than 5\n" +
            "16) Import: enter new teams from a data file until the file is empty (the user must be asked" +
            " to enter the input file name). \n" +
            "17) Export: Retrieve names and mailing addresses of all people on the mailing list and " +
             "output them to a data file instead of screen (the user must be asked to enter the output file " +
             "name).  \n" +
            "18) Quit \n";
            
    /*
     * Main function with exception handling
     */
    public static void main(String[] args) throws SQLException, IOException, FileNotFoundException {
    	System.out.println("Welcome to the Patient Assistant Network (PAN) Database System");
    	
    	 final Scanner sc = new Scanner(System.in); // Scanner is used to collect the user input
         String option = ""; // Initialize user option selection as nothing
         
         //create a connection
         Connection conn = DriverManager.getConnection(URL);
         //loop until user selects query 18 to QUIT
         while (!option.equals("18")) { 
        	 System.out.println(PROMPT); // print the available queries
        	 option = sc.nextLine(); //get user input

        	 //prompt for queries
             switch (option) {
	             case "1":
	            	 enterTeam(conn, sc);
	            	 break;
	            	 
	             case "2":
	            	 enterClient(conn, sc);
	            	 break;
	            	 
	             case "3":
	            	 enterVolunteer(conn, sc);
	            	 break;
	            	 
	             case "4":
	            	 insertNumberHoursWorked(conn, sc);
	            	 break;
	            	 
	             case "5":
	            	 enterEmployees(conn, sc);
	            	 break;
	            	 
	             case "6":
	            	 enterEmployeeExpense(conn, sc);
	            	 break;
	            	 
	             case "7":
	            	 enterDonorAndDonations(conn, sc);
	            	 break;
	            	 
	             case "8":
	            	 retrieveDoctorInformation(conn, sc);
	            	 break;
	            	 
	             case "9":
	            	 totalExpenses(conn, sc);
	            	 break;
	            	 
	             case "10":
	            	 retrieveVolunteersOfClient(conn, sc);
	            	 break;
	            	 
	             case "11":
	            	 retrieveAllTeams(conn, sc);
	            	 break;
	            	 
	             case "12":
	            	 retrieveAllPeople(conn, sc);
	            	 break;
	            	 
	             case "13":
	            	 allDonorsAndEmployees(conn, sc);
	            	 break;
	            	 
	             case "14":
	            	 increaseSalary(conn, sc);
	            	 break;
	            	 
	             case "15":
	            	 deleteClientsWithoutInsurance(conn, sc);
	            	 break;
	            	 
	             case "16":
	            	 importData(conn, sc);
	            	 break;
	            	 
	             case "17":
	            	 exportData(conn, sc);
	            	 break;
	            	 
	             case "18":
	            	 System.out.println("Closing the PAN Database system...");
	            	 sc.close(); // Close the scanner before exiting the application
	            	 conn.close(); //Close the DB connection
	            	 System.exit(0); //exit the program
	            	 break;
	            	 
	            
             }
         }

    }
    
    
    /*
     * query 1
     */
    public static void enterTeam(Connection conn, Scanner sc) throws SQLException{
    	String input1, input2, input3;
   
    	System.out.println("Enter the team name: \n");
    	input1 = sc.nextLine();
    	
    	System.out.println("Enter the team type: \n");
    	input2 = sc.nextLine();
    	
    	System.out.println("Enter the date that the team formed (YYYY-MM-DD): \n");
    	input3 = sc.nextLine();
    	Date date = java.sql.Date.valueOf(input3); //convert to a date object
      	
    	
    	
    	//create the connection
    	CallableStatement stmt = conn.prepareCall("{call enterTeam(?, ?, ?)}");
    	stmt.setString(1, input1);
    	stmt.setString(2, input2);
    	stmt.setDate(3, date);
    	
    	stmt.execute();
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
    	CallableStatement stmt = conn.prepareCall("{call enterClient(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
    	
      	//-----------------
      	//ssn
    	System.out.println("Enter the client's social security number:\n");
    	input = sc.nextLine();
      	stmt.setString(1, input);
      	
      	//pname
      	System.out.println("Enter the client's name");
      	input = sc.nextLine();
      	stmt.setString(2, input);
      	
      	//gender
    	System.out.println("Enter the client's gender:\n");
    	input = sc.nextLine();
      	stmt.setString(3, input);
      	
      	//profession
    	System.out.println("Enter the client's profession:\n");
    	input = sc.nextLine();
      	stmt.setString(4, input);
      	
      	//on_mailing_list
    	System.out.println("Is the client on the mailing list? (Y or N)\n");
    	input = sc.nextLine();
      	stmt.setString(5, input);
      	
      	//mailing_addr
    	System.out.println("Enter the client's mailing address:\n");
    	input = sc.nextLine();
      	stmt.setString(6, input);
      	
      	//email_addr
    	System.out.println("Enter the client's email address:\n");
    	input = sc.nextLine();
      	stmt.setString(7, input);
      	
      	//phone number
    	System.out.println("Enter the client's phone number:\n");
    	input = sc.nextLine();
      	stmt.setString(8, input);
    	
      	//assignment date
    	System.out.println("Enter the client's assignment date (YYYY-MM-DD):\n");
    	input = sc.nextLine();
    	Date date = java.sql.Date.valueOf(input); //convert to a date object
      	stmt.setDate(9, date);
      	
      	//doctor name
    	System.out.println("Enter the client's doctor's name:\n");
    	input = sc.nextLine();
      	stmt.setString(10, input);
      	
      	//doctor phone number
    	System.out.println("Enter the client's doctor's phone number: \n");
    	input = sc.nextLine();
      	stmt.setString(11, input);
   
    	//team name
    	System.out.println("Enter the team name associated with this client: \n");
    	input = sc.nextLine();
      	stmt.setString(12, input);
       	
      	stmt.execute();
    }
    
    /*
     * query 3
     */
    public static void enterVolunteer(Connection conn, Scanner sc) throws SQLException{
    	String input;
    	int intInput;
    	
    	//configure the connection string
    	CallableStatement stmt = conn.prepareCall("{call enterVolunteer(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,"
    			+ "?, ?, ?)}");
  
    	/*
    	 * volunteer information
    	 */
      	//ssn
    	System.out.println("Enter the volunteer's social security number:\n");
    	input = sc.nextLine();
      	stmt.setString(1, input);
      	
      	//name
       	System.out.println("Enter the volunteer's name:\n");
    	input = sc.nextLine();
      	stmt.setString(2, input);
      	
      	//gender
    	System.out.println("Enter the volunteer's gender:\n");
    	input = sc.nextLine();
      	stmt.setString(3, input);
      	
      	//profession
    	System.out.println("Enter the volunteer's profession:\n");
    	input = sc.nextLine();
      	stmt.setString(4, input);
      	
      	//mailing list
    	System.out.println("Is the volunteer on the mailing list? (Y or N)\n");
    	input = sc.nextLine();
      	stmt.setString(5, input);
      	
      	//mailing addr
    	System.out.println("Enter the volunteer's mailing address:\n");
    	input = sc.nextLine();
      	stmt.setString(6, input);
      	
      	//email
    	System.out.println("Enter the volunteer's email address:\n");
    	input = sc.nextLine();
      	stmt.setString(7, input);
      	
      	//phone
    	System.out.println("Enter the volunteer's phone number:\n");
    	input = sc.nextLine();
      	stmt.setString(8, input);
    	
      	//date joined
    	System.out.println("Enter the volunteer's date joined (YYYY-MM-DD):\n");
    	input = sc.nextLine();
    	Date date = java.sql.Date.valueOf(input); //convert to a date object
      	stmt.setDate(9, date);
      	
      	//date training
      	System.out.println("Enter the volunteer's date training (YYYY-MM-DD):\n");
    	input = sc.nextLine();
    	date = java.sql.Date.valueOf(input); //convert to a date object
      	stmt.setDate(10, date);

      	//training location
      	System.out.println("\nEnter the training location:");
      	input = sc.nextLine();
      	stmt.setString(11, input);
      	
    	/*
    	 * servesOn information
    	 */
      	//team name
    	System.out.println("Enter the team name associated with this volunteer: \n");
    	input = sc.nextLine();
      	stmt.setString(12, input);
      	
      	//month served
      	System.out.println("Enter the month the volunteer served: \n");
    	input = sc.nextLine();
      	stmt.setString(13, input);
      	
      	//serves hours
      	System.out.println("Enter the number of hours the volunteer served: \n");
    	intInput = sc.nextInt();
      	stmt.setInt(14, intInput);
      	
      	// consume the leftover newline character
      	sc.nextLine();
      	
      	//active
      	System.out.println("Indicate the status of the volunteer on the team: \n");
    	input = sc.nextLine();
      	stmt.setString(15, input);
      	
      	
      	stmt.execute(); //carry out query
    }
    
    /*
     * query 4 -- number of hours worked 
     */
    public static void insertNumberHoursWorked(Connection conn, Scanner sc) throws SQLException{
    	String input;
    	int intInput;
    	
    	//configure the connection string
    	CallableStatement stmt = conn.prepareCall("{call insertNumberHoursWorked(?, ?, ?, ?, ?)}");
    	
    	/*
    	 * enter serves on information
    	 */
      	//ssn
    	System.out.println("Enter the volunteer's social security number:\n");
    	input = sc.nextLine();
      	stmt.setString(1, input);
      	
      	//name
       	System.out.println("Enter the volunteer's team name:\n");
    	input = sc.nextLine();
      	stmt.setString(2, input);
      	
      	//serve month
      	System.out.println("Enter the month the volunteer served: \n");
    	input = sc.nextLine();
      	stmt.setString(3, input);
      	
      	//serve hours
      	System.out.println("Enter the hours the volunteer served: \n");
    	intInput = sc.nextInt();
      	stmt.setInt(4, intInput);
      	
      	// consume the leftover newline character
      	sc.nextLine();
      	
      	//active 
    	System.out.println("Is the volunteer active? \n");
    	input = sc.nextLine();
      	stmt.setString(5, input);
      	
      	stmt.execute(); //carry out query
    }
    
    /*
     * query 5 --  Enter a new employee into the database and associate him or her with one or more teams 
     */
    public static void enterEmployees(Connection conn, Scanner sc) throws SQLException{
    	//input variables
    	String input, emergencycontact;
    	Date date;
    	int intInput;
    	
    	//create connection 
    	CallableStatement stmt = conn.prepareCall("{call enterEmployees(?, ?,"
    			+ "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
    	
      	//-----------------
      	//ssn
    	System.out.println("Enter the employee's social security number:\n");
    	input = sc.nextLine();
      	stmt.setString(1, input);
      	
      	//pname
      	System.out.println("\nEnter the employee's name:");
      	input = sc.nextLine();
      	stmt.setString(2, input);
      	
      	//gender
    	System.out.println("\nEnter the employee's gender:");
    	input = sc.nextLine();
      	stmt.setString(3, input);
      	
      	//profession
    	System.out.println("\nEnter the employee's profession:");
    	input = sc.nextLine();
      	stmt.setString(4, input);
      	
      	//on_mailing_list
    	System.out.println("\nIs the employee on the mailing list? (Y or N):");
    	input = sc.nextLine();
      	stmt.setString(5, input);
      	
      	//mailing_addr
    	System.out.println("\nEnter the employee's mailing address:");
    	input = sc.nextLine();
      	stmt.setString(6, input);
      	
      	//email_addr
    	System.out.println("\nEnter the employee's email address:");
    	input = sc.nextLine();
      	stmt.setString(7, input);
      	
      	//phone number
    	System.out.println("\nEnter the employee's phone number:");
    	input = sc.nextLine();
      	stmt.setString(8, input);
    
    	//salary
    	System.out.println("Enter the employee's salary:\n");
    	intInput = sc.nextInt();
      	stmt.setInt(9, intInput);
      	
      	// consume the leftover newline character
      	sc.nextLine();
      	
      	//marital status
      	System.out.println("\nEnter the employee's marital status:");
      	input = sc.nextLine();
      	stmt.setString(10, input);
      	
      	//hire date
      	System.out.println("\nEnter the employee's hire date(YYYY-MM-DD): ");
      	input = sc.nextLine();
      	date = java.sql.Date.valueOf(input); 
      	stmt.setDate(11, date);
      
      	/*
      	 * reports to
      	 */
      	
    	//team name
    	System.out.println("\nEnter the team name associated with this employee:");
    	input = sc.nextLine();
      	stmt.setString(12, input);
      	
      	//report status
      	System.out.println("\nEnter the report status:");
    	input = sc.nextLine();
      	stmt.setString(13, input);
      	
    	//report description
      	System.out.println("\nEnter the report description:");
    	input = sc.nextLine();
      	stmt.setString(14, input);
      	
    	//report date
      	System.out.println("\nEnter date of the report (YYYY-MM-DD):");
      	input = sc.nextLine();
      	date = java.sql.Date.valueOf(input); 
      	stmt.setDate(15, date);
      	
      	stmt.execute();
    }
    
    /*
     * query 6 -- enter employee expenses
     */
    public static void enterEmployeeExpense(Connection conn, Scanner sc) throws SQLException{
    	//input variables
    	String input;
    	Date date;
    	
    	//create connection 
    	CallableStatement stmt = conn.prepareCall("{call enterEmployeeExpense(?, ?, ?, ?)}");
    	
    	//employee ssn
    	System.out.println("\nEnter the employee's ssn:");
    	input = sc.nextLine();
    	stmt.setString(1, input);
    	
    	//expense date
    	System.out.println("\nEtner the expense date:");
    	input = sc.nextLine();
    	date = java.sql.Date.valueOf(input); 
    	stmt.setDate(2, date);
    	
    	//expense amount
    	System.out.println("\nEnter the expense amount:");
    	input = sc.nextLine();
    	stmt.setString(3, input);
    	
    	//expense description
    	System.out.println("\nEnter the expense description:");
    	input = sc.nextLine();
    	stmt.setString(4, input);
    	
    	stmt.execute();
    }
    
    
    /*
     * query 7
     */
    public static void enterDonorAndDonations(Connection conn, Scanner sc) throws SQLException{
    	String input;
    	Date date;
    	int intInput;
    	
    	CallableStatement stmt = conn.prepareCall("{call enterDonorAndDonations(?, ?, ?, ?, ?,"
    			+ "?, ?, ?, ?, ?, ?, ?, ?)}");
    	/*
    	 * donor 
    	 */
    	System.out.println("Enter the donor's social security number:\n");
    	input = sc.nextLine();
      	stmt.setString(1, input);
      	
      	//pname
      	System.out.println("\nEnter the donor's name:");
      	input = sc.nextLine();
      	stmt.setString(2, input);
      	
      	//gender
    	System.out.println("\nEnter the donor's gender:");
    	input = sc.nextLine();
      	stmt.setString(3, input);
      	
      	//profession
    	System.out.println("\nEnter the donor's profession:");
    	input = sc.nextLine();
      	stmt.setString(4, input);
      	
      	//on_mailing_list
    	System.out.println("\nIs the donor on the mailing list? (Y or N):");
    	input = sc.nextLine();
      	stmt.setString(5, input);
      	
      	//mailing_addr
    	System.out.println("\nEnter the donor's mailing address:");
    	input = sc.nextLine();
      	stmt.setString(6, input);
      	
      	//email_addr
    	System.out.println("\nEnter the donor's email address:");
    	input = sc.nextLine();
      	stmt.setString(7, input);
      	
      	//phone number
    	System.out.println("\nEnter the donor's phone number:");
    	input = sc.nextLine();
      	stmt.setString(8, input);
    	
      	System.out.println("\nDoes the donor wish to remain anonymous? (Y or N):");
    	input = sc.nextLine();
      	stmt.setString(9, input);
    	
    	/*
    	 * donation 
    	 */
      	System.out.println("\nEnter date of the donation (YYYY-MM-DD):");
      	input = sc.nextLine();
      	date = java.sql.Date.valueOf(input); 
      	stmt.setDate(10, date);
      	
      	System.out.println("\nEnter donation amount:");
      	intInput = sc.nextInt();
      	stmt.setInt(11, intInput);
      	
      	// consume the leftover newline character
      	sc.nextLine();
      	
    	System.out.println("\nEnter the type of donation: ");
      	input = sc.nextLine();
      	stmt.setString(12, input);
      	
      	System.out.println("\nEnter the campaign name: ");
      	input = sc.nextLine();
      	stmt.setString(13, input);
      	
      	stmt.execute();
    }
    
    /*
     * query 8 -- Retrieve the name and phone number of the doctor of a particular client 
     */
    public static void retrieveDoctorInformation(Connection conn, Scanner sc) throws SQLException{
    	String input;
    	
    	System.out.println("\nEnter the ssn of the client:");
    	input = sc.nextLine();
    	
      	CallableStatement stmt = conn.prepareCall("{call retrieveDoctorInformation(?)}");
      	stmt.setString(1,input);
      	
      	ResultSet rs = stmt.executeQuery();
      	
      	while(rs.next()) {
      		System.out.println("Doctor name:"
      				+ rs.getString("doctor_name"));
      		System.out.println("Doctor's phone number:"
      				+ rs.getString("doctor_phone_number"));
      	}
    }
    
    /*
     * query 9 -- Retrieve the total amount of expenses charged by each employee for a particular period of time. The list should be sorted by the total amount of expenses 
     */
    public static void totalExpenses(Connection conn, Scanner sc) throws SQLException{
    	String input;
    	
      	CallableStatement stmt = conn.prepareCall("{call totalExpenses(?, ?)}");
      	
      	System.out.println("Enter the start time for expenses:");
      	input = sc.nextLine();
      	Date date = java.sql.Date.valueOf(input); 
      	stmt.setDate(1, date);
      	
      	System.out.println("Enter the end time for expenses:");
      	input = sc.nextLine();
      	date = java.sql.Date.valueOf(input); 
      	stmt.setDate(2, date);
      	
      	ResultSet rs = stmt.executeQuery();
      	
      	//start getting the query
      	while(rs.next()) {
      		System.out.println(rs.getString("ssn") + ": " + rs.getDouble("totalExpenses"));
      	}
    	
    }
    
    /*
     * query 10 -- Retrieve the list of volunteers that are members of teams that support a particular client
     */
    public static void retrieveVolunteersOfClient(Connection conn, Scanner sc) throws SQLException{
    	String input;
    	
    	System.out.println("\nEnter the ssn of the client:");
    	input = sc.nextLine();
    	
      	CallableStatement stmt = conn.prepareCall("{call retrieveVolunteersOfClient(?)}");
      	stmt.setString(1,input);
      	
      	ResultSet rs = stmt.executeQuery();
      	
      	System.out.println("\nVolunteers:");
      	
      //start getting the query
      	while(rs.next()) {
      		System.out.println(rs.getString("pname"));
      	}
    }
    
    /*
     * query 11
     */
    public static void retrieveAllTeams(Connection conn, Scanner sc) throws SQLException{
    	
      	CallableStatement stmt = conn.prepareCall("{call retrieveAllTeams(?)}");

      	System.out.println("Enter a start date");
    	String input = sc.nextLine();
      	Date date = java.sql.Date.valueOf(input); 
      	stmt.setDate(1, date);
      	
      	//open the connection
      	ResultSet rs = stmt.executeQuery();
      	
      	System.out.println("\nTeams founded after " + date + ":");
      	
      	while(rs.next()) {
      		System.out.println(rs.getString("team_name"));
      	}
    }
    
    /*
     * query 12 -- Retrieve the names, social security numbers, contact information, and emergency contact
	 * information of all people in the database (1/week).
     */
    public static void retrieveAllPeople(Connection conn, Scanner sc) throws SQLException{
      	CallableStatement stmt = conn.prepareCall("{call retrieveAllPeople()}");
      	
      	ResultSet rs = stmt.executeQuery();
      	
      	//prints out a formatted header
      	System.out.println("\nAll people in the database:");
      	String formatted = String.format("%-10s %-10s %-20s %-20s %-20s %-20s",
      			"Name", "ssn", "Mailing Address", "Phone Number", "Email Address",
      			"Emergency Contact Name");
      	
      	System.out.println(formatted);
      	System.out.println("-----------------------------------------------------"
      			+ "-----------------------------------------------------"
      			+ "-----");
      	
      	//print all the information from the query
      	while(rs.next()) {
      		//formatted string
      		formatted = String.format("%-10s %-10s %-20s %-20s %-20s %-20s",
      				rs.getString("pname"), rs.getString("ssn"), rs.getString("mailing_addr"),
      				rs.getString("phone_num"), rs.getString("email_addr"),
      				rs.getString("cname"));
      		//print info
      		System.out.println(formatted);
      	}

    }
    
    /*
     * query 13 -- Retrieve the name and total amount donated by donors that are also employees. The list
 	 * should be sorted by the total amount of the donations, and indicate if each donor wishes to
	 * remain anonymous (1/week)
     */
    public static void allDonorsAndEmployees(Connection conn, Scanner sc) throws SQLException{
      	CallableStatement stmt = conn.prepareCall("{call allDonorsAndEmployees()}");

      	ResultSet rs = stmt.executeQuery();
      	
      //prints out a formatted header
      	System.out.println("\nDonations from donors that are also employees:");
      	String formatted = String.format("%-20s %-20s",
      			"Donor Name", "Total Amount");
      	
      	System.out.println(formatted);
      	System.out.println("-----------------------------------------------------");
      	
      	while(rs.next()) {
      		formatted = String.format("%-20s %-20s",
      				rs.getString("pname"), rs.getString("totalDonation"));
      		
          	System.out.println(formatted);
      	}
    }
    /*
     * query 14 -- Increase the salary by 10% of all employees to whom more than one team must report. (1/year)
     */
    public static void increaseSalary(Connection conn, Scanner sc) throws SQLException{
    	CallableStatement stmt = conn.prepareCall("{call increaseSalary()}");
    	System.out.println("Increasing salary by 1.1% ...");
    	stmt.execute();
    }
    
    /*
     * query 15 -- Delete all clients who do not have health insurance and whose value of importance for
	 * transportation is less than 5 (4/year).
     */
    public static void deleteClientsWithoutInsurance(Connection conn, Scanner sc) throws SQLException{
    	CallableStatement stmt = conn.prepareCall("{call deleteClientsWithoutInsurance()}");
    	
    	System.out.println("Deleting clients without insurance ...");
    	stmt.execute();
    }
    
    /* -----------------------------------------
     * query 16 -- Import: enter new teams from a data file until the file is empty (the user must be asked
	 *	to enter the input file name).
     * ---------------------------------------- */
    public static void importData(Connection conn, Scanner sc) throws SQLException, IOException, FileNotFoundException{
    	String fileName;
    	BufferedReader reader;
    	
    	System.out.println("\nEnter the file name to load data from:");
    	fileName = sc.nextLine();
    	
    	//open connection
    	CallableStatement stmt = conn.prepareCall("{call importTeams(?, ?, ?)}");
    	
    	//open the file
		reader = new BufferedReader(new FileReader("src/" + fileName));
		String line;
		//start reading the data and making a sql query
		while((line = reader.readLine()) != null) {
			String[] row = line.split(",");
				
			//get each col and execute the query
			stmt.setString(1, row[0]); //team name
			stmt.setString(2, row[1]); //team type
			
			//get date and remove whitespace
			String date = (row[2]).replaceAll("\\s+",""); //date founded
			stmt.setDate(3, java.sql.Date.valueOf(date));
			stmt.execute();
		}
		reader.close();
    }
    
    /*
     * query 17 Retrieve names and mailing addresses of all people on the mailing list and
	 * output them to a data file instead of screen (the user must be asked to enter the output file
	 * name).
     */
    public static void exportData(Connection conn, Scanner sc) throws SQLException, IOException, FileNotFoundException{
    	String filename = "test.csv";
    	String path = "src/";
    	
    	CallableStatement stmt = conn.prepareCall("{call exportMailingList()}");
    	ResultSet rs = stmt.executeQuery();
    	
    	System.out.println("\nEnter a file name to output to: ");
    	filename = sc.nextLine();
    	//open file to write to 
    	BufferedWriter writer = new BufferedWriter(new FileWriter(path + filename));
    	while(rs.next()) {
    		//delimit the data with columns for a .csv file
    		writer.write(rs.getString("pname") + ","
    				+ rs.getString("mailing_addr") + ",");
    		writer.write("\n"); //newline
    	}
    	writer.close();
    }
    
}


    