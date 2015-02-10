<%@ page import="java.sql.*"%>
<%@ page language="java" import="cal.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://jakarta.apache.org/taglibs/dbtags" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql2"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<jsp:useBean id="date" scope="session" class="cal.JspCalendar" />
<sql:connection id="conn3">
	<sql:url>jdbc:mysql://localhost:3306/consommation?user=root </sql:url>
	<sql:driver>com.mysql.jdbc.Driver</sql:driver>
</sql:connection>

<%
String[] lesMois = new String[] {"Janvier", "Férier", "Mars", "Avril", "Mai", "Juin", "Juillet",
                              "Aout", "Septembre", "Octobre", "Novembre", "Déembre"  };
String lannee = request.getParameter("annee");
String consommable = request.getParameter("consommable");
String lieu = request.getParameter("lieu");
int annee  =  (lannee!=null)? (new Integer(lannee)).intValue():date.getYear();;
int [] valCompteur= {0,0,0,0,0,0,0,0,0,0,0,0};
ResultSet rset = null ;
PreparedStatement pstmt = null; 
int leMois=0;
int indexCourant =0;
if (consommable==null)  consommable = "EAU";
if (lieu==null)  lieu = "Ecole";
String fonction = session.getAttribute("fonction").toString();

// recherche des valeurs de compteurs pour ce consommable, dans ce lieu pour cette ann閑

pstmt = conn3.prepareStatement("select * from tableau where annee = ? and lieu=? and consommable=? order by mois" );
         pstmt.setInt(1, annee);
		 pstmt.setString(2, lieu);
		 pstmt.setString(3, consommable);
 	rset = pstmt.executeQuery();
 	while(rset.next()) {
	   leMois = rset.getInt("mois") ;
	   indexCourant = rset.getInt("compteur");
	   valCompteur[leMois-1] = indexCourant;
	}
int monthLimit = 12;
if (annee == date.getYear()){
	monthLimit = date.getMonthInt();
}
int[] valConsommation = new int[monthLimit];
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link type="text/css" href="../style/deco.css" rel="stylesheet">
<title>Courbes de consommation</TITLE>
</head>
<body BGCOLOR="white">
 	<%@ include file="accesmenuConsommation.jsp" %>
	<H1>
		<%=lieu%>
		Consommation en
		<%=consommable%>
	</h1>
	<form name="enregistrer" method="get" action="gerebaseConsommation.jsp">
		<table WIDTH=800px class="Casebleu">
			<tr>
				<td><a href=conso.jsp?annee=<%=annee - 1%>>Precedente</a></td>
				<td>Annee:<%=annee%>
				</td>
				<%
				if (annee != date.getYear()) {
			%>
				<td><a href=conso.jsp?annee=<%=annee + 1%>>Suivante</a></td>
				<%
				}
			%>
				<%
				if (fonction.equals("administrateur")) {
			%>
				<td>
					<button name="enregistrer" type="submit" value="> enregistrer"
						style="height: 20px; width: 85px">> enregistrer</button> <input
					type=hidden name=annee value=<%=annee%>> <input type=hidden
					name=lieu value=<%=lieu%>> <input type=hidden
					name=consommable value=<%=consommable%>>
				</td>
				<%
				}
			%>
			</tr>
		</table>

		<table WIDTH=20% BGCOLOR=lightblue BORDER=1>
			<tr>
				<td>
					<table>
						<tr>
							<th BGCOLOR=yellow><%=consommable%></th>
						</tr>
						<tr>
							<th>compteur</th>
						</tr>
						<tr>
							<th>consommation</th>
						</tr>
					</table>
				</td>

				<%
				for (int i = 0; i < monthLimit; i++) {
				%>
				<td>
					<table style="width: 50px;" class="Casebleu1">
						<tr>
							<td><%=lesMois[i]%></td>
						</tr>
						<tr>
							<td>
								<%
							if (!fonction.equals("administrateur")) {
						%> <%=valCompteur[i]%> <%
							} else if(fonction.equals("administrateur")){
						%> <input name=<%=i%> type="text" size=2
								value="<%=valCompteur[i]%>"> <%
							}
						%>
							</td>
						</tr>
						<tr>
							<td>
								<%
								int valCompteurDecembrePrecedent = 0;
										if (valCompteur[i] == 0) {
											out.println(0);
											valConsommation[i] = 0;
										} else if (i != 0) {
											valConsommation[i] = valCompteur[i] - valCompteur[i - 1];
											out.println(valConsommation[i]);
										} else if (i == 0) {
											pstmt = conn3.prepareStatement("select * from tableau where annee = ? and mois = ? and lieu=? and consommable=?");
											pstmt.setInt(1, annee - 1);
											pstmt.setInt(2, 12);
											pstmt.setString(3, lieu);
											pstmt.setString(4, consommable);
											rset = pstmt.executeQuery();
											while (rset.next()) {
												valCompteurDecembrePrecedent = rset
														.getInt("compteur");
											}
											valConsommation[i] = valCompteur[i]
													- valCompteurDecembrePrecedent;
											out.println(valConsommation[i]);
										}
							%>
							</td>
						</tr>
					</table>
				</td>
				<%
				}
			%>
			</tr>
		</table>
	</form>
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	<script type="text/javascript">
		google.load("visualization","0",{packages:["corechart"]});
		google.setOnLoadCallback(drawChart);
		function drawChart(){
			var arraysCompteur = [['Mois','Compteur']];
			var arraysConsommation = [['Mois','Consommation']];
			<% for (int i = 0; i < monthLimit; i++) {
 				out.println("arraysCompteur.push(['" + lesMois[i] + "', " + valCompteur[i] + "]);");
 				out.println("arraysConsommation.push(['" + lesMois[i] + "', " + valConsommation[i] + "]);");
			}%>				
			var dataCompteur = google.visualization.arrayToDataTable(arraysCompteur);
			var dataConsommation = google.visualization.arrayToDataTable(arraysConsommation);
			var options = {
				annotations: {
					textStyle:{
					fontName:'Times-Roman',
					fontSize:18,
					bold:true,
					italic:true,
					color:'#871b47',
					auraColor:'#d799ae',
					opacity:0.8
					}
				}
			};
			var chartCompteur = new google.visualization.LineChart(document.getElementById('chart_divCompteur'));
			var chartConsommation = new google.visualization.LineChart(document.getElementById('chart_divConsommation'));
			chartCompteur.draw(dataCompteur,options);
			chartConsommation.draw(dataConsommation,options);
					
		}
	</script>
	<div id="chart_divCompteur" style="width:900px; hight=:800px;"></div>
	<div id="chart_divConsommation" style="width:900px; hight=:800px;"></div>
	
</body>
</html>


