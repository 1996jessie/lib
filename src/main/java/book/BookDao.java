package book;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;

public class BookDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	private static BookDao instance;

	public static BookDao getInstance() {
		if (instance == null) {
			instance = new BookDao();
		}
		return instance;
	} //getInstance

	private BookDao() {
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
	}// BookDao
	
	public ArrayList<BookBean> getAllBook() {
		ArrayList<BookBean> blist = new ArrayList<BookBean>();
		try {
			String sql = "select * from book order by bnum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				BookBean bb = getBookBean(rs);
				blist.add(bb);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return blist;
	}
	
	public ArrayList<BookBean> getBookByPage(int start, int end) {
		ArrayList<BookBean> blist = new ArrayList<BookBean>();
		try {
			String sql = "select bnum, btitle, bauthor, bcategory, scategory, bpublisher, bcode, bimage, bpubyear, bbuydate, bprice, blendcount, breservecount from (select rownum as rank, bnum, btitle, bauthor, bcategory, scategory, bpublisher, bcode, bimage, bpubyear, bbuydate, bprice, blendcount, breservecount from (select bnum, btitle, bauthor, bcategory, scategory, bpublisher, bcode, bimage, bpubyear, bbuydate, bprice, blendcount, breservecount from book)) where rank between ? and ?";
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			while(rs.next()) {
				BookBean bb = getBookBean(rs);
				blist.add(bb);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return blist;
	}
	
	public BookBean getBookByBnum(int bnum) {
		BookBean bb = null;
		try {
			String sql = "select * from book where bnum = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bnum);
			rs = ps.executeQuery();
			if(rs.next()) {
				bb = getBookBean(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return bb;
		
	}
	
	public BookBean getBookByBcode(String bcode) {
		BookBean bb = null;
		try {
			String sql = "select * from book where bcode = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bcode);
			rs = ps.executeQuery();
			if(rs.next()) {
				bb = getBookBean(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return bb;
		
	}
	
	public int getBookCount() {
		int count = 0;
		try {
			String sql = "select count(*) from book";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		
		return count;
	}

	public int insertBook(MultipartRequest mr) {
		int cnt = -1;
		try {
			String sql = "insert into book (bnum, btitle, bauthor, bcategory, scategory, bpublisher, bimage, bpubyear, bbuydate, bprice) values (bookseq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mr.getParameter("btitle"));
			ps.setString(2, mr.getParameter("bauthor"));
			ps.setString(3, mr.getParameter("bcategory"));
			ps.setString(4, mr.getParameter("scategory"));
			ps.setString(5, mr.getParameter("bpublisher"));
			ps.setString(6, mr.getOriginalFileName("bimage"));
			ps.setInt(7, Integer.parseInt(mr.getParameter("bpubyear")));
			ps.setString(8, String.valueOf(mr.getParameter("bbuydate")));
			ps.setInt(9, Integer.parseInt(mr.getParameter("bprice")));
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return cnt;
	}
	
	public int updateBook(MultipartRequest mr, String img) {
		int cnt = -1;
		String sql = "update book set bcategory = ?, scategory = ?, bimage = ?, bpubyear = ?, bbuydate = ? where bnum = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mr.getParameter("bcategory"));
			ps.setString(2,  mr.getParameter("scategory"));
			ps.setString(3, img);
			ps.setInt(4, Integer.parseInt(mr.getParameter("bpubyear")));
			ps.setString(5, mr.getParameter("bbuydate"));
			ps.setInt(6, Integer.parseInt(mr.getParameter("bnum")));
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return cnt;
	}
	
	public int deleteBook(int bnum) {
		int cnt = -1;
		try {
			String sql = "delete from book where bnum = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bnum);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return cnt;
	}
	
	public int deleteBooks(String[] bRowCheck) {
	    int cnt = -1;
	    try {
	        String sql = "delete from book where bnum = ?";
	        for(int i=1;i<bRowCheck.length;i++) {
	            sql += " or bnum = ?";
	        }
	        ps = conn.prepareStatement(sql);
	        for(int i=0;i<bRowCheck.length;i++) {
	            ps.setInt(i+1,Integer.parseInt(bRowCheck[i]));
	        }
	        cnt = ps.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
			fin();
	    }
	    return cnt;
	}
	
	public int lendBook(String bcode) {
		int cnt = -1;
		try {
			String sql = "update book set blendcount = blendcount + 1 where bcode = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bcode);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return cnt;
	}
	
	public int countReservedBook(int count, String rbcode) {
		int cnt = -1;
		try {
			String sql = "update book set breservecount = ? where bcode = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, count);
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
	
	
	public boolean searchBook(String btitle, String bauthor) {
		boolean flag = false;
		try {
			String sql = "select * from book where btitle = ? and bauthor = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, btitle);
			ps.setString(2, bauthor);
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
	
	public ArrayList<BookBean> getBookContainsBtitle(String btitle) {
	    ArrayList<BookBean> blist = new ArrayList<BookBean>();
	    try {
	        String sql = "select * from book where btitle like ?";
	        ps = conn.prepareStatement(sql);
	        ps.setString(1, "%" + btitle + "%"); // '%'를 이용하여 와일드카드를 사용하여 부분 일치 검색 수행
	        rs = ps.executeQuery();
	        while(rs.next()) {
	            BookBean bb = getBookBean(rs);
	            blist.add(bb);
	        }
	    } catch (SQLException e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	    } finally {
	        fin();
	    }
	    return blist;
	}
	
	public int makeBcode(MultipartRequest mr) {
		int cnt = -1;
		int bnum = 0;
		try {
			String selectSql = "select bnum from book where btitle = ? and bauthor = ?";
			ps = conn.prepareStatement(selectSql);
			ps.setString(1, mr.getParameter("btitle"));
			ps.setString(2, mr.getParameter("bauthor"));
			
			rs = ps.executeQuery();
			if(rs.next()) {
				bnum = rs.getInt("bnum");
			}
			String sql = "update book set bcode = ? where bnum = ?";
			ps = conn.prepareStatement(sql);
			int cnum = Integer.parseInt(mr.getParameter("bcategory"));
			int snum = Integer.parseInt(mr.getParameter("scategory"));
			String btitleFirstLetter = mr.getParameter("btitle").substring(0, 1);
			String bauthorFirstLetter = mr.getParameter("bauthor").substring(0,1);
			String bcode = String.valueOf(cnum+snum) + "-" + bauthorFirstLetter  + String.valueOf(bnum) + btitleFirstLetter;
		
			ps.setString(1, bcode);
			ps.setInt(2, bnum);
			
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return cnt;
	}
	
	public ArrayList<BookBean> getBookByBpubyear(String bpubyear) {
		ArrayList<BookBean> blist = new ArrayList<BookBean>();
		
		try {
			String sql = "select * from book where bpubyear = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bpubyear);
			rs = ps.executeQuery();
			while(rs.next()) {
	            BookBean bb = getBookBean(rs);
	            blist.add(bb);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}		
		return blist;
	}
	
	public int deleteCheckedBook(String[] checkThis) {
		int cnt = -1;
		int i;

		try {
			String sql = "delete from book where bnum = ?";
			
			for(i=1;i<checkThis.length;i++) {
				sql += " or bnum = ?";
			}
			System.out.println("완성된 sql : " + sql);
			
			ps = conn.prepareStatement(sql);
			
			for(i=0;i<checkThis.length;i++) {
				ps.setInt(i+1, Integer.parseInt(checkThis[i]));
			}
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return cnt;
	}
	
	public ArrayList<BookBean> getBookByCategory(String bcategory) {
		ArrayList<BookBean> blist = new ArrayList<BookBean>();
		try {
			String sql = "select * from book where bcategory = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bcategory);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				BookBean bb = getBookBean(rs);
				blist.add(bb);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		
		
		return blist;
		
	}
	
	public ArrayList<BookBean> getBookByCat(String bcategory, String scategory) {
		ArrayList<BookBean> blist = new ArrayList<BookBean>();
		try {
			String sql = "select * from book where bcategory = ? and scategory = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bcategory);
			ps.setString(2, scategory);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				BookBean bb = getBookBean(rs);
				blist.add(bb);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return blist;
		
	}
	
	public ArrayList<BookBean> getBookByMost() {
		ArrayList<BookBean> blist = new ArrayList<BookBean>();
		try {
			String sql = "select * from (select rank() over (order by blendcount desc) as rank, bnum, btitle, bauthor, bcategory, scategory, bpublisher, bcode, bimage, bpubyear, bbuydate, bprice, blendcount, breservecount from book) where rank between 1 and 5";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				BookBean bb = getBookBean(rs);
				blist.add(bb);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return blist;
	}
	
	public ArrayList<BookBean> getBookNew() {
		ArrayList<BookBean> blist = new ArrayList<BookBean>();
		try {
			String sql = "select * from (select rank() over (order by bbuydate desc) as rank, bnum, btitle, bauthor, bcategory, scategory, bpublisher, bcode, bimage, bpubyear, bbuydate, bprice, blendcount, breservecount from book) where rank between 1 and 10";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				BookBean bb = getBookBean(rs);
				blist.add(bb);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return blist;
	}
	
	private BookBean getBookBean(ResultSet rs) throws SQLException {
		// TODO Auto-generated method stub
		BookBean bb = new BookBean();
		bb.setBnum(rs.getInt("bnum"));
		bb.setBtitle(rs.getString("btitle"));
		bb.setBauthor(rs.getString("bauthor"));
		bb.setBcategory(rs.getString("bcategory"));
		bb.setBcode(rs.getString("bcode"));
		bb.setScategory(rs.getString("scategory"));
		bb.setBpublisher(rs.getString("bpublisher"));
		bb.setBimage(rs.getString("bimage"));
		bb.setBpubyear(rs.getInt("bpubyear"));
		bb.setBbuydate(String.valueOf(rs.getString("bbuydate")));
		bb.setBprice(rs.getInt("bprice"));
		bb.setBlendcount(rs.getInt("blendcount"));
		bb.setBreservecount(rs.getInt("breservecount"));
		return bb;
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
