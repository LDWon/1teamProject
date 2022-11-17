package vo;

public class M_userVO {
	private int prnum, mail_auth;
	private String id, pwd, birth, email, tel, mail_key;

	public int getMail_auth() {
		return mail_auth;
	}

	public void setMail_auth(int mail_auth) {
		this.mail_auth = mail_auth;
	}

	public String getMail_key() {
		return mail_key;
	}

	public void setMail_key(String mail_key) {
		this.mail_key = mail_key;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public int getPrnum() {
		return prnum;
	}

	public void setPrnum(int prnum) {
		this.prnum = prnum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

}
