package article;

import java.sql.*;
import java.util.ArrayList;

import javax.naming.*;
import javax.sql.DataSource;

public class ArticleDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	private static ArticleDao instance;

	public static ArticleDao getInstance() {
		if (instance == null) {
			instance = new ArticleDao();
		}
		return instance;
	} //getInstance

	private ArticleDao() {
		//DBCP
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
	}// ArticleDao
	
	public ArrayList<ArticleBean> getArticles(int start, int end) {
		ArrayList<ArticleBean> alist = new ArrayList<ArticleBean>();
		String sql = "select anum, aname, atitle, adate, areadcount, checkPrivacy, aref, astep, alevel, acontent " ;		        
		sql += "from (select rownum as rank, anum, aname, atitle, adate, areadcount, checkPrivacy, aref, astep, alevel, acontent ";
		sql += "from (select anum, aname, atitle, adate, areadcount, checkPrivacy, aref, astep, alevel, acontent ";
		sql += "from article  ";
		sql += "order by aref desc, astep asc )) ";
		sql += "where rank between ? and ? ";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			while(rs.next()) {
				ArticleBean bb = getArticleBean(rs);
				alist.add(bb);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return alist;
	}//getArticles

	public int getArticleCount() {
		int count = 0;
		try {
			String sql = "select count(*) from article";
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
	} //getArticleCount
	
	public ArticleBean getThisArticle(int anum) {
		ArticleBean ab = null;
		try {
			String updateSql = "update article set areadcount = areadcount + 1 where anum = ?"; //조회수 먼저 증가시키기
			ps = conn.prepareStatement(updateSql);
			ps.setInt(1, anum);
			ps.executeUpdate();
			
			String selectSql = "select * from article where anum = ?";
			ps = conn.prepareStatement(selectSql);
			ps.setInt(1, anum);
			rs = ps.executeQuery();
			if(rs.next()) {
				ab = getArticleBean(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return ab;
	}//getArticle
	
	public int insertArticle(String aname, String atitle, String adate, String checkPrivacy, String acontent) { 
		int cnt = -1;
		try {
			String sql = "insert into article values (articleseq.nextval, ?, ?, sysdate, ?, 0, articleseq.currval, default, default, ?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, aname);
			ps.setString(2, atitle);			
			ps.setString(3, checkPrivacy);
			ps.setString(4, acontent);

			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return cnt;
	}//insertArticle
	
	public int deleteArticle(int anum) {
		int cnt = -1;
		try {
			String sql = "delete from article where anum = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, anum);
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return cnt;
	}//deleteArticle
	
	public int replyArticle(ArticleBean ab) {
		int updateCnt = -1;
		int insertCnt = -1;
		try {
			String updateSql = "update article set astep = astep + 1 where aref = ? and astep > ?";
			String insertSql = "insert into article values (articleseq.nextval, ?, ?, sysdate, ?, 0, ?, ?, ?, ?)";
			
			ps = conn.prepareStatement(updateSql);
			ps.setInt(1, ab.getAref());
			ps.setInt(2, ab.getAstep());
			
			updateCnt = ps.executeUpdate();
			if(updateCnt >= 0) {
				ps = conn.prepareStatement(insertSql);
				ps.setString(1, ab.getAname());
				ps.setString(2, ab.getAtitle());
				ps.setString(3, ab.getCheckPrivacy());
				ps.setInt(4, ab.getAref());
				ps.setInt(5, ab.getAstep()+1);
				ps.setInt(6, ab.getAlevel()+1);
				ps.setString(7, ab.getAcontent());
				insertCnt = ps.executeUpdate();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return insertCnt;
	} //replyArticle
	
	public ArticleBean updateGetArticle(int anum) {
		ArticleBean ab = null;
		try {
			String sql = "select * from article where anum = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, anum);
			rs = ps.executeQuery();
			if(rs.next()) {
				ab = getArticleBean(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return ab;
	}
	
	public int updateArticle(ArticleBean ab) {
		int cnt = -1;
		try {
			String sql = "update article set atitle = ?, checkPrivacy = ?, acontent = ? where anum = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, ab.getAtitle());
			ps.setString(2, ab.getCheckPrivacy());
			ps.setString(3, ab.getAcontent());
			ps.setInt(4, ab.getAnum());
			cnt = ps.executeUpdate();			
			if(cnt > 0) {
				updateCheckPrivacy(ab.getCheckPrivacy(), ab.getAref());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		return cnt;
	}
	
	
	
	
	private void updateCheckPrivacy(String checkPrivacy, int aref) {
		// TODO Auto-generated method stub
		int cnt = -1;
		String sql = "update article set checkPrivacy = ? where aref = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, checkPrivacy);
			ps.setInt(2, aref);
			cnt = ps.executeUpdate();			
			if(cnt > 0) {
				System.out.println("답글들도 공개비공개 변경 성공");
			} else {
				System.out.println("변경 안됨");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 

	}





	
	public int[] getArticleAref(String mname) {
	    ArrayList<Integer> arefList = new ArrayList<>();
	    try {
	        String sql = "SELECT aref FROM article WHERE aname = ?";
	        ps = conn.prepareStatement(sql);
	        ps.setString(1, mname);
	        rs = ps.executeQuery();
	        while (rs.next()) {
	            arefList.add(rs.getInt("aref"));
	        }
	    } catch (SQLException e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	    } finally {
	        fin();
	    }
	    // ArrayList를 배열로 변환
	    int[] arefArray = new int[arefList.size()];
	    for (int i = 0; i < arefList.size(); i++) {
	        arefArray[i] = arefList.get(i);
	    }
	    return arefArray;
	}
	
	
	public boolean canIDeleteThisArticle(int anum) {
		boolean flag = false;
		int aref = 0;
		try {
			String sql = "select aref from article where anum = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, anum);
			rs = ps.executeQuery();
			if(rs.next()) {
				aref = rs.getInt("aref");
			}
			System.out.println("<canIDeleteThisArticle> aref : " + aref);
			
			if(aref > 0) {
				int count = 0;
				String sql2 = "select count(*) from article where aref = ?";
				ps = conn.prepareStatement(sql2);
				ps.setInt(1, aref);
				rs = ps.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
				System.out.println("<canIDeleteThisArticle> count : " + count);
				if(count == 1) {
					flag = true;
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			fin();
		}
		
		return flag;
		
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

	private ArticleBean getArticleBean(ResultSet rs) throws SQLException {
		// TODO Auto-generated method stub
		ArticleBean ab = new ArticleBean();
		ab.setAnum(rs.getInt("anum"));
		ab.setAname(rs.getString("aname"));
		ab.setAtitle(rs.getString("atitle"));
		ab.setAdate(rs.getString("adate"));
		ab.setCheckPrivacy(rs.getString("checkPrivacy"));
		ab.setAreadcount(rs.getInt("areadcount"));
		ab.setAref(rs.getInt("aref"));
		ab.setAstep(rs.getInt("astep"));
		ab.setAlevel(rs.getInt("alevel"));
		ab.setAcontent(rs.getString("acontent"));
		
		return ab;
	}
}
