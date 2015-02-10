
<tr>
	<td>
		<table class="Casebleu" style="border: 0px; margin: 0; padding: 0px;">
			<tr>
				<td colspan="4">
					<p class="Casebleu">
						<%= ((String)session.getAttribute("leNom")).toUpperCase() %>
						<%= ((String)session.getAttribute("lePrenom")).toUpperCase() %>
						&nbsp;&nbsp;&nbsp;&nbsp; Fonction :
						<%= session.getAttribute("fonction") %>
					</p>
				</td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td class="Casebleu">déconnexion</td>
				<td>
					<button name="choix"
						onClick="self.location.href='deconnection.jsp'" type="button"
						style="width: 100px">Se déconnecter</button>
				</td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

			</tr>
		</table>
	</td>
</tr>
