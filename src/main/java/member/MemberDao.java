package member;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;

public class MemberDao {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	private static MemberDao instance;

	public static MemberDao getInstance() {
		if (instance == null) {
			instance = new MemberDao();
		}
		return instance;
	} //getInstance

	private MemberDao() {
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:comp/env"); 
			DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB"); 
			conn = ds.getConnection(); 
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}// MemberDao
	
	public ArrayList<MemberBean> getAllMember() {
		ArrayList<MemberBean> mlist = new ArrayList<MemberBean>();
		try {
			String sql = "select * from member where not id like 'admin%' order by mnum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				MemberBean mb = getMemberBean(rs);
				mlist.add(mb);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return mlist;
	}
	
	public int insertMember(MemberBean mb) {
		int cnt = -1;
		try {
			String sql = "insert into member values (memseq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, default, default)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mb.getMname());
			ps.setString(2, mb.getId());
			ps.setString(3, mb.getPassword());
			ps.setString(4, mb.getEmail1());
			ps.setString(5, mb.getEmail2());
			ps.setString(6, mb.getRrn1());
			ps.setString(7, mb.getRrn2());
			ps.setString(8, mb.getPhone1());
			ps.setString(9, mb.getPhone2());
			ps.setString(10, mb.getPhone3());
			ps.setString(11, mb.getAddress1());
			ps.setString(12, mb.getAddress2());
			
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return cnt;
	}
	
	public int updateMember(MemberBean mb) {
		int cnt = -1;
		try {
			String sql = "update member set password = ?, email1 = ?, email2 = ?, phone1 = ?, phone2 = ?, phone3 = ?, address1 = ?, address2 = ? where mname = ? and rrn1 = ? and rrn2 = ?";  
			ps = conn.prepareStatement(sql);
			ps.setString(1, mb.getPassword());
			ps.setString(2, mb.getEmail1());
			ps.setString(3, mb.getEmail2());
			ps.setString(4, mb.getPhone1());
			ps.setString(5, mb.getPhone2());
			ps.setString(6, mb.getPhone3());
			ps.setString(7, mb.getAddress1());
			ps.setString(8, mb.getAddress2());
			ps.setString(9, mb.getMname());
			ps.setString(10, mb.getRrn1());
			ps.setString(11, mb.getRrn2());
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return cnt;
	}
	
	public int deleteMemberbyAdmin(int mnum) {
		int cnt = -1;
		try {
			String sql = "delete from member where mnum = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mnum);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return cnt;
	}
	
	public int deleteMembers(String[] mRowCheck) {
	    int cnt = -1;
	    try {
	        String sql = "delete from member where mnum = ?";
	        for(int i=1;i<mRowCheck.length;i++) {
	            sql += " or bnum = ?";
	        }
	        ps = conn.prepareStatement(sql);
	        for(int i=0;i<mRowCheck.length;i++) {
	            ps.setInt(i+1,Integer.parseInt(mRowCheck[i]));
	        }
	        cnt = ps.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	    	fin();
	    }
	    return cnt;
	}
	
	public int deleteMemberBySelf(int mnum, String password) {
		int cnt = -1;
		try {
			String sql = "delete from member where mnum = ? and password = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mnum);
			ps.setString(2, password);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return cnt;
	}
	
	public boolean searchId(String id) {
		boolean flag = false;
		try {
			String sql = "select * from member where id = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
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
	
	public MemberBean findId(String mname, String rrn1, String rrn2) {
		MemberBean mb =  null;
		String sql = "select * from member where mname = ? and rrn1 = ? and rrn2 = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mname);
			ps.setString(2, rrn1);
			ps.setString(3, rrn2);
			rs = ps.executeQuery();
			if(rs.next()) {
				mb = getMemberBean(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return mb;
	}
	
	public MemberBean findPw(String id, String mname, String rrn1, String rrn2) {
		MemberBean mb =  null;
		String sql = "select * from member where id = ? and mname = ? and rrn1 = ? and rrn2 = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, mname);
			ps.setString(3, rrn1);
			ps.setString(4, rrn2);
			rs = ps.executeQuery();
			if(rs.next()) {
				mb = getMemberBean(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return mb;
	}
	
	public MemberBean memberCheck(String id, String password) {
		MemberBean mb =  null;
		try {
			String sql = "select * from member where id = ? and password = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, password);
			rs = ps.executeQuery();
			if(rs.next()) {
				mb = getMemberBean(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return mb;
	}
	

	
	public boolean canIInsert(String mname, String rrn1, String rrn2) {
		boolean flag = false;
		try {
			String sql = "select * from member where mname = ? and rrn1 = ? and rrn2 = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mname);
			ps.setString(2, rrn1);
			ps.setString(3, rrn2);
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
	
	public int findmnum(String id) {
		int mnum = -1;
		try {
			String sql = "select mnum from member where id = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if(rs.next()) {
				mnum = rs.getInt("mnum");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return mnum;
	}
	
	private MemberBean getMemberBean(ResultSet rs) throws SQLException {
		MemberBean mb =  new MemberBean();
		mb.setMnum(rs.getInt("mnum"));
		mb.setMname(rs.getString("mname"));
		mb.setId(rs.getString("id"));
		mb.setPassword(rs.getString("password"));
		mb.setRrn1(rs.getString("rrn1"));
		mb.setRrn2(rs.getString("rrn2"));
		mb.setEmail1(rs.getString("email1"));
		mb.setEmail2(rs.getString("email2"));
		mb.setPhone1(rs.getString("phone1"));
		mb.setPhone2(rs.getString("phone2"));
		mb.setPhone3(rs.getString("phone3"));
		mb.setAddress1(rs.getString("address1"));
		mb.setAddress2(rs.getString("address2"));
		return mb;
	}

	private void fin() {
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
