   package utile;
   import java.util.*;
   import java.sql.*;
    public class GereUtilisateur {
    //les  3 propriétés
      private String lePrenom,   leNom, leMotPasse ;
      static private String  baseUtilise ;
   
     private Connection  connectionPret=null;
      Statement stmt=null;
      ResultSet rset = null;
      PreparedStatement pstmt;
    
       public void setLeNom(String nom) {
         leNom = nom;
      }
    

       public void setLePrenom(String prenom) {
         lePrenom = prenom;
      }
   
       public void setLeMotPasse(String motPasse) {
         leMotPasse = motPasse;
      }
   
       static public  void setBaseUtilise(String laBase) {
   	    baseUtilise = laBase;
     }
       public void  setConnectionPret() {
            connectionPret = ouverture();
        }
       
       
       public String getLeNom() {
         return leNom;
      }
    
       public String getLePrenom() {
         return lePrenom;
      }
   
       public String getLeMotPasse() {
         return leMotPasse;
      }
       
       public Connection getConnectionPret() {
           return connectionPret;
        }
	   private void reset() {
		   leNom = null; leMotPasse = null; lePrenom = null;
		}
    
	   static public String getBaseUtilise() {
         return baseUtilise;
      }
	 
	 
	 
       public Connection ouverture() {
       	Connection  connection = null;
         try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            connection = DriverManager.getConnection(
            		baseUtilise,"root","");
            connection.setAutoCommit(true);
         }
             catch (Exception E) {         
               System.out.println(" -------- probleme  " + E.getClass().getName() );
               E.printStackTrace();
            }	
         return connection;
      }
   
       public ResultSet recherchePersonne() {
		 System.out.println(" recherchePersonne ");
         try {
			System.out.println(" leNom "+ leNom);
			System.out.println(" lePrenom " + lePrenom);
			System.out.println(" leMotPasse " + leMotPasse);
            PreparedStatement pstmt = connectionPret.prepareStatement("select id,nom, prenom, fonction from utilisateur where nom=? and prenom=? and motpasse=?");
            pstmt.setString(1, leNom);
            pstmt.setString(2, lePrenom);
            pstmt.setString(3, leMotPasse);
            rset = pstmt.executeQuery();
         }
             catch (Exception E) {         
               System.out.println(" -------- probleme recherche " + E.getClass().getName() + "connection   : " + connectionPret );
               E.printStackTrace();
            }
         reset();
			return rset;
      }
		
		
      public void inscrireUtilisateur() {
         try {
	
            PreparedStatement pstmt = connectionPret.prepareStatement("insert into utilisateur(nom, prenom, motpasse) VALUES (?,?,?)" );
            pstmt.setString(1, leNom);
            pstmt.setString(2, lePrenom);
            pstmt.setString(3, leMotPasse);
            pstmt.executeUpdate();
         }
             catch (Exception E) {         
               System.out.println(" -------- probleme recherche inscrireUtilisateur " + E.getClass().getName()+ "connection   : " + connectionPret );
               E.printStackTrace();
            }
		      reset();
      }

   
   
   }