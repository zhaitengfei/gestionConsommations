package utile;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class portier implements Filter {

	private FilterConfig filterConfig = null;
	
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
		
		
	}
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
	throws IOException, ServletException { 
		HttpServletRequest hrequest = (HttpServletRequest) request;
		HttpServletResponse hresponse = (HttpServletResponse) response;
	   HttpSession session = hrequest.getSession(true);
	    System.out.println("dans le filtre portier");
		if ((session.getAttribute("leNom") == null) )		
		{
		     System.out.println("dans le filtre  3");

		        hresponse.sendRedirect("../index.jsp");
				  }
		 else {
		  chain.doFilter(request, response); }
	
	}
	

	public void destroy() {
		this.filterConfig = null;
		
	}
	
	
}
