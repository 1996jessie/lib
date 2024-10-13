package reserve;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;





public class ReserveDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	private static ReserveDao instance;

	public static ReserveDao getInstance() {
		if (instance == null) {
			instance = new ReserveDao();
		}
		return instance;
	} //getInstance

	private ReserveDao() {
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
	}// ReserveDao
	
	public int canIReserve(int mnum) {
		int mycount = 0;
		try {
			String sql = "select * from reserve where rmnum = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mnum);
			rs = ps.executeQuery();
			while(rs.next()) {
				mycount++;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return mycount;
	}
	
	public int canIReserveThis(String bcode) {
		int bookcount = 0;
		try {
			String sql = "select * from reserve where rbcode = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bcode);
			rs = ps.executeQuery();
			while(rs.next()) {
				bookcount++;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return bookcount;
		
	}
	
	public boolean canIReserveThisBook(int mnum, String bcode) {
		boolean flag = false;
		try {
			String sql = "select * from reserve where rmnum = ? and rbcode = ?";
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
	
	public int reserveThisBook(int mnum, int bnum, String bcode) {
		int cnt = -1;
		try {
			String sql = "insert into reserve values (reserveseq.nextval, ?, ?, ?)";
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
	
	public ArrayList<ReserveBean> getAllReservedBookByMe(int mnum) {
		ArrayList<ReserveBean> rlist = new ArrayList<ReserveBean>();
		try {
			String sql = "select * from reserve where rmnum = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mnum);
			rs = ps.executeQuery();
			while(rs.next()) {
				ReserveBean rb = getReserveBean(rs);
				rlist.add(rb);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return rlist;
	
	
	}
	
	public int cancelReservation(int rmnum, String rbcode) {
		int cnt = -1;
		try {
			String sql = "delete from reserve where rmnum = ? and rbcode = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, rmnum);
			ps.setString(2, rbcode);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return cnt;
	}
	
	public int countReservation(String rbcode) {
		int count = 0;
		try {
			String sql = "select * from reserve where rbcode = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, rbcode);
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
	

	public int countMyOrder(int rmnum, String rbcode) {
		int rank = 0;
		try {
			String sql = "select rank from (select rank() over (order by rnum) as rank, rnum, rmnum, rbcode from reserve where rbcode = ?) where rmnum = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, rbcode);
			ps.setInt(2, rmnum);
			rs = ps.executeQuery();
			if(rs.next()) {
				rank = rs.getInt("rank");
			}
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return rank;
	}
	
	public boolean checkCanAdminDeleteThisBook(int bnum) {
		boolean flag = false;
		try {
			String sql = "select * from reserve where rbnum = ?";
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
	
	public int checkReserveCount(String bcode) {
	    int count = 0;
	    try {
	        String sql = "select count(*) from reserve where rbcode = ?";
	        ps = conn.prepareStatement(sql);
	        ps.setString(1, bcode);
	        rs = ps.executeQuery(); // PreparedStatement 실행하여 ResultSet 얻기
	        if(rs.next()) {
	            count = rs.getInt(1); // "count(*)" 대신에 컬럼 인덱스를 사용
	        }
	    } catch (SQLException e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	    } finally {
	        fin();
	    }
	    return count;
	}
	
	
	private ReserveBean getReserveBean(ResultSet rs) throws SQLException {
		// TODO Auto-generated method stub
		ReserveBean rb = new ReserveBean();
		rb.setRnum(rs.getInt("rnum"));
		rb.setRmnum(rs.getInt("rmnum"));
		rb.setRbnum(rs.getInt("rbnum"));
		rb.setRbcode(rs.getString("rbcode"));
		return rb;
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
