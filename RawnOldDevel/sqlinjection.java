import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    // Example of a vulnerable query without parameterization
    public User getUserByUsername(String username) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        User user = null;
        
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "username", "password");
            String query = "SELECT * FROM users WHERE username = '" + username + "'";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setUsername(rs.getString("username"));
                // Set other user properties here
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return user;
    }
    
    // Example of a safe query using parameterization
    public User getSafeUserByUsername(String username) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        User user = null;
        
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydatabase", "username", "password");
            String query = "SELECT * FROM users WHERE username = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setUsername(rs.getString("username"));
                // Set other user properties here
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return user;
    }
}








Skip to content
JeffMuniz
/
Site-Reliability-Engineer

Type / to search

Code
Pull requests
Actions
Security
5
Insights
Settings
Code scanning alerts #7
Query built from user-controlled sources
 Open in main 1 hour ago
...a-wrk-autoec-lead/src/main/java/br/com/mac/repository/blue/CustomQueryRepositoryImpl.java:66 

        List<Object[]> result = null;
        try{
            result = this.entityManager.createNativeQuery(stringBuilder.toString()).getResultList();
This query depends on a .
CodeQL 

            for(Object[] obj : result) {
                funcionarios.replace((String) obj[2], FuncionarioDTO.builder()
Tool
CodeQL
Rule ID
java/sql-injection
Query
View source
If a database query is built using string concatenation, and the components of the concatenation include user input, a user is likely to be able to run malicious database queries. This applies to various database query languages, including SQL and the Java Persistence Query Language.

Recommendation
Usually, it is better to use a SQL prepared statement than to build a complete SQL query with string concatenation. A prepared statement can include a wildcard, written as a question mark (?), for each part of the SQL query that is expected to be filled in by a different value each time it is run. When the query is later executed, a value must be supplied for each wildcard in the query.

In the Java Persistence Query Language, it is better to use queries with parameters than to build a complete query with string concatenation. A Java Persistence query can include a parameter placeholder for each part of the query that is expected to be filled in by a different value when run. A parameter placeholder may be indicated by a colon (:) followed by a parameter name, or by a question mark (?) followed by an integer position. When the query is later executed, a value must be supplied for each parameter in the query, using the setParameter method. Specifying the query using the @NamedQuery annotation introduces an additional level of safety: the query must be a constant string literal, preventing construction by string concatenation, and the only way to fill in values for parts of the query is by setting positional parameters.

It is good practice to use prepared statements (in SQL) or query parameters (in the Java Persistence Query Language) for supplying parameter values to a query, whether or not any of the parameters are directly traceable to user input. Doing so avoids any need to worry about quoting and escaping.

Example
In the following example, the code runs a simple SQL query in two different ways.

The first way involves building a query, query1, by concatenating an environment variable with some string literals. The environment variable can include special characters, so this code allows for SQL injection attacks.

The second way, which shows good practice, involves building a query, query2, with a single string literal that includes a wildcard (?). The wildcard is then given a value by calling setString. This version is immune to injection attacks, because any special characters in the environment variable are not given any special treatment.

{
    // BAD: the category might have SQL special characters in it
    String category = System.getenv("ITEM_CATEGORY");
    Statement statement = connection.createStatement();
    String query1 = "SELECT ITEM,PRICE FROM PRODUCT WHERE ITEM_CATEGORY='"
        + category + "' ORDER BY PRICE";
    ResultSet results = statement.executeQuery(query1);
}

{
    // GOOD: use a prepared query
    String category = System.getenv("ITEM_CATEGORY");
    String query2 = "SELECT ITEM,PRICE FROM PRODUCT WHERE ITEM_CATEGORY=? ORDER BY PRICE";
    PreparedStatement statement = connection.prepareStatement(query2);
    statement.setString(1, category);
    ResultSet results = statement.executeQuery();
}
Example
The following code shows several different ways to run a Java Persistence query.

The first example involves building a query, query1, by concatenating an environment variable with some string literals. Just like the SQL example, the environment variable can include special characters, so this code allows for Java Persistence query injection attacks.

The remaining examples demonstrate different methods for safely building a Java Persistence query with user-supplied values:

query2 uses a single string literal that includes a placeholder for a parameter, indicated by a colon (:) and parameter name (category).
query3 uses a single string literal that includes a placeholder for a parameter, indicated by a question mark (?) and position number (1).
namedQuery1 is defined using the @NamedQuery annotation, whose query attribute is a string literal that includes a placeholder for a parameter, indicated by a colon (:) and parameter name (category).
namedQuery2 is defined using the @NamedQuery annotation, whose query attribute includes a placeholder for a parameter, indicated by a question mark (?) and position number (1).
The parameter is then given a value by calling setParameter. These versions are immune to injection attacks, because any special characters in the environment variable or user-supplied value are not given any special treatment.
{
    // BAD: the category might have Java Persistence Query Language special characters in it
    String category = System.getenv("ITEM_CATEGORY");
    Statement statement = connection.createStatement();
    String query1 = "SELECT p FROM Product p WHERE p.category LIKE '"
        + category + "' ORDER BY p.price";
    Query q = entityManager.createQuery(query1);
}

{
    // GOOD: use a named parameter and set its value
    String category = System.getenv("ITEM_CATEGORY");
    String query2 = "SELECT p FROM Product p WHERE p.category LIKE :category ORDER BY p.price"
    Query q = entityManager.createQuery(query2);
    q.setParameter("category", category);
}

{
    // GOOD: use a positional parameter and set its value
    String category = System.getenv("ITEM_CATEGORY");
    String query3 = "SELECT p FROM Product p WHERE p.category LIKE ?1 ORDER BY p.price"
    Query q = entityManager.createQuery(query3);
    q.setParameter(1, category);
}

{
    // GOOD: use a named query with a named parameter and set its value
    @NamedQuery(
            name="lookupByCategory",
            query="SELECT p FROM Product p WHERE p.category LIKE :category ORDER BY p.price")
    private static class NQ {}
    ...
    String category = System.getenv("ITEM_CATEGORY");
    Query namedQuery1 = entityManager.createNamedQuery("lookupByCategory");
    namedQuery1.setParameter("category", category);
}

{
    // GOOD: use a named query with a positional parameter and set its value
    @NamedQuery(
            name="lookupByCategory",
            query="SELECT p FROM Product p WHERE p.category LIKE ?1 ORDER BY p.price")
    private static class NQ {}
    ...
    String category = System.getenv("ITEM_CATEGORY");
    Query namedQuery2 = entityManager.createNamedQuery("lookupByCategory");
    namedQuery2.setParameter(1, category);
}
References
OWASP: SQL Injection Prevention Cheat Sheet.
SEI CERT Oracle Coding Standard for Java: IDS00-J. Prevent SQL injection.
The Java Tutorials: Using Prepared Statements.
The Java EE Tutorial: The Java Persistence Query Language.
Common Weakness Enumeration: CWE-89.
Common Weakness Enumeration: CWE-564.
First detected in commit
yesterday
@JeffMuniz
x
f34caca
grafana-wrk-autoec-lead/src/main/java/br/com/mac/repository/blue/CustomQueryRepositoryImpl.java:66 on branch main
Appeared in branch main
yesterday
Push on main #11: Commit f34cacaf ( language: java-kotlin )
Alert metadata
Severity
High
Affected branches
Tags
security
Weaknesses
 CWE-89
 CWE-564
Footer
© 2024 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
Status
Docs
Contact
Manage cookies
Do not share my personal information
Query built from user-controlled sources · Code scanning alert #7 · JeffMuniz/Site-Reliability-Engineer