package real.project;

import java.util.ArrayList;

import common.DBConnPool;

public class ZipcodeDAO extends DBConnPool{
	
	public ArrayList<String> getSido() {
		ArrayList<String> sidoAddr = new ArrayList<String>();
		
		String sql = "SELECT DISTINCT sido FROM zipcode "
				+ " WHERE 1=1 "
				+ " ORDER BY sido ASC ";
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				sidoAddr.add(rs.getString(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return sidoAddr;
	}
	
	public ArrayList<String> getGugun(String sido) {
		ArrayList<String> gugunAddr = new ArrayList<String>();
		
		String sql = "SELECT DISTINCT gugun FROM zipcode "
				+ " WHERE sido=? "
				+ " ORDER BY gugun DESC ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, sido);
			rs = psmt.executeQuery();
			while(rs.next()) {
				gugunAddr.add(rs.getString(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return gugunAddr;
	}
	
}
