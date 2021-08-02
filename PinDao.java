package pin2.dao;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspWriter;

import pin2.dto.PinDto;

public class PinDao {

	Connection conn=null;
	
	public PinDao() throws ClassNotFoundException, SQLException
	{
		Class.forName("org.postgresql.Driver");
		String url="jdbc:postgresql://localhost:5432/board";
		String user="postgres";
		String password="1234";
		conn=DriverManager.getConnection(url,user,password);
	}
	
	public void reg_ok(HttpServletRequest request) throws UnsupportedEncodingException, SQLException
	{
		request.setCharacterEncoding("utf-8");
		
		int empno=Integer.parseInt(request.getParameter("empno").toString());
		String rank=request.getParameter("rank");
		String name=request.getParameter("name");
		String phone=request.getParameter("phone1")+"-"+request.getParameter("phone2")+"-"+request.getParameter("phone3");
		String email=request.getParameter("email1")+"@"+request.getParameter("email2");
		
		String sql="insert into register (empno,rank,name,phone,email) values (?,?,?,?,?)";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, empno);
		pstmt.setString(2, rank);
		pstmt.setString(3, name);
		pstmt.setString(4, phone);
		pstmt.setString(5, email);
		
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
	public ArrayList<PinDto> list(HttpServletRequest request) throws SQLException, UnsupportedEncodingException
	{
		request.setCharacterEncoding("utf-8");
		String stype=request.getParameter("stype");
		String search=request.getParameter("search");
		String sql = null;
		
		if(stype!=null)
		{
			if(stype.equals("1"))
			{
				sql="select * from register where empno="+search+" order by name";
			}
			else if(stype.equals("2"))
			{
				sql="select * from register where rank like '%"+search+"%' order by name";
			}
			else if(stype.equals("3"))
			{
				sql="select * from register where name like '%"+search+"%' order by name";
			}
			else if(stype.equals("4"))
			{
				sql="select * from register where phone like '%"+search+"%' order by name";
			}
			else if(stype.equals("5"))
			{
				sql="select * from register where email like '%"+search+"%' order by name";
			}
		}
		else
		{
			sql="select * from register order by name";
		}
		
		
		Statement stmt=conn.createStatement();
		ResultSet rs=stmt.executeQuery(sql);
		
		ArrayList<PinDto> list=new ArrayList<PinDto>();
		while(rs.next())
		{
			PinDto pdto=new PinDto();
			pdto.setEmail(rs.getString("email"));
			pdto.setEmpno(rs.getInt("empno"));
			pdto.setName(rs.getString("name"));
			pdto.setPhone(rs.getString("phone"));
			pdto.setRank(rs.getString("rank"));
			list.add(pdto);
		}
		
		return list;
	}
	
	public PinDto update(HttpServletRequest request) throws SQLException, UnsupportedEncodingException
	{
		request.setCharacterEncoding("utf-8");
		int empno=Integer.parseInt(request.getParameter("empno").toString());
		
		String sql="select * from register where empno=? order by name";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, empno);
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		PinDto pdto=new PinDto();
		pdto.setEmail(rs.getString("email"));
		pdto.setEmpno(rs.getInt("empno"));
		pdto.setName(rs.getString("name"));
		pdto.setPhone(rs.getString("phone"));
		pdto.setRank(rs.getString("rank"));
		return pdto;
	}
	
	
	public void update_ok(HttpServletRequest request) throws UnsupportedEncodingException, SQLException
	{
		request.setCharacterEncoding("utf-8");
		int empno=Integer.parseInt(request.getParameter("empno").toString());
		
		String rank=request.getParameter("rank");
		String name=request.getParameter("name");
		String phone=request.getParameter("phone1")+"-"+request.getParameter("phone2")+"-"+request.getParameter("phone3");
		String email=request.getParameter("email1")+"@"+request.getParameter("email2");
		
		String sql="update register set rank=?, name=?, phone=?, email=? where empno=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, rank);
		pstmt.setString(2, name);
		pstmt.setString(3, phone);
		pstmt.setString(4, email);
		pstmt.setInt(5, empno);
		
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
	public void delete(HttpServletRequest request) throws UnsupportedEncodingException, SQLException
	{
		request.setCharacterEncoding("utf-8");
		int empno=Integer.parseInt(request.getParameter("empno").toString());
		
		String sql="delete from register where empno=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, empno);
		
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
	public void empno_ok(HttpServletRequest request,JspWriter out) throws SQLException, IOException
	{
		request.setCharacterEncoding("utf-8");
		int empno=Integer.parseInt(request.getParameter("empno").toString());
		String sql="select * from register where empno=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, empno);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next())
		{
			out.print("1");
		}
		else
		{
			out.print("0");
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
