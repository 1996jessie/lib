package borrow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class BorrowDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	private static BorrowDao instance;

	public static BorrowDao getInstance() {
		if (instance == null) {
			instance = new BorrowDao();
		}
		return instance;
	} //getInstance

	private BorrowDao() {
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:comp/env"); 
			DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB"); 
			conn = ds.getConnection(); 
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			System.out.println("1111");
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("2222");
			e.printStackTrace();
		}
	}// BorrowDao
	
	public int canIBorrow(int mnum) {
		int count = 0;
		try {
			String sql = "select * from borrow where brmnum = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mnum);
			rs = ps.executeQuery();
			while(rs.next()) {
				count++;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return count;
		
	}
	
	public boolean isThisBookBorrowed(String bcode) {
		boolean flag = false;
		try {
			String sql = "select * from borrow where brbcode = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bcode);
			rs = ps.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return flag;
	}
	
	
	public boolean canIBorrowThisBook(int mnum, String bcode) {
		boolean flag = false;
		try {
			String sql = "select * from borrow where brmnum = ? and brbcode = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mnum);
			ps.setString(2, bcode);
			rs = ps.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return flag;
	}
	

	
	public int borrowThisBook(int mnum, int bnum, String bcode) {
		int cnt = -1;
		try {
			String sql = "insert into borrow (brnum, brmnum, brbnum, brbcode) values (borrowseq.nextval, ?, ?, ?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mnum);
			ps.setInt(2, bnum);
			ps.setString(3, bcode);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		
		return cnt;
	}
	
	public ArrayList<BorrowBean> getAllBorrowedBook() {
		ArrayList<BorrowBean> brlist = new ArrayList<BorrowBean>();
		try {
			String sql = "select * from borrow order by brnum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				BorrowBean brb = getBorrowBean(rs);
				brlist.add(brb);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return brlist;
	}
	
	public ArrayList<BorrowBean> getAllBorrowedBookByMe(int mnum) {
		ArrayList<BorrowBean> brlist = new ArrayList<BorrowBean>();
		try {
			String sql = "select * from borrow where brmnum = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mnum);
			rs = ps.executeQuery();
			while(rs.next()) {
				BorrowBean brb = getBorrowBean(rs);
				brlist.add(brb);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return brlist;
	}
	
	public int returnThisBook(int brmnum, String brbcode) {
		int cnt = -1;
		try {
			String sql = "delete from borrow where brmnum = ? and brbcode = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, brmnum);
			ps.setString(2, brbcode);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return cnt;	
	}
	
	public boolean canIExtendThisBook(int brmnum, String brbcode) {
		boolean flag = false;
		int extendcount = 0;
		try {
			String sql = "select extendcount from borrow where brmnum = ? and brbcode = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, brmnum);
			ps.setString(2, brbcode);
			rs = ps.executeQuery();
			if(rs.next()) {
				extendcount = rs.getInt("extendcount");
				System.out.println("canIExtendThisBook메서드 extendcount : " + extendcount);
			}
			
			if(extendcount >= 2) {
				flag = true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return flag;

		
	}
	
	
	public int extendReturnDate(int brmnum, String brbcode) {
		int cnt = -1;
		try {
			String sql = "update borrow returndate set returndate = returndate + 7, extendcount = extendcount + 1 where brmnum = ? and brbcode = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, brmnum);
			ps.setString(2, brbcode);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return cnt;

	}
	
	public boolean checkCanIDeleteMyAccount(int mnum) {
		boolean flag = false;
		try {
			String sql = "select * from borrow where brmnum = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mnum);
			rs = ps.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		
		return flag;
	}
	
	public boolean checkCanAdminDeleteThisBook(int bnum) {
		boolean flag = false;
		try {
			String sql = "select * from borrow where brbnum = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bnum);
			rs = ps.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		
		return flag;
	}
	
	public boolean checkCanAdminDeleteThisMember(int mnum) {
		boolean flag = false;
		try {
			String sql = "select * from borrow where brmnum = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mnum);
			rs = ps.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		
		return flag;
	}
	
	public String getReturnDate(String bcode) {
		String returndate = null;
		try {
			String sql = "select returndate from borrow where brbcode = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bcode);
			rs = ps.executeQuery();
			if(rs.next()) {
				returndate = rs.getString("returndate");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return returndate;
	}
	
	
	private BorrowBean getBorrowBean(ResultSet rs) throws SQLException {
		// TODO Auto-generated method stub
		BorrowBean brb = new BorrowBean();
		brb.setBrnum(rs.getInt("brnum"));
		brb.setBrmnum(rs.getInt("brmnum"));
		brb.setBrbcode(rs.getString("brbcode"));
		brb.setBorrowdate(String.valueOf(rs.getDate("borrowdate")));
		brb.setReturndate(String.valueOf(rs.getDate("returndate")));
		brb.setExtendcount(rs.getInt("extendcount"));
		return brb;
	}

	private void fin() {
		// TODO Auto-generated method stub
		try {
			if(rs != null) {
				rs.close();
			}
			if(ps != null) {
				ps.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
