package jp.co.kissco.vo;

public class PaymentVo {
	private String kanji_name;
	private String id;
	private int report_id;
	private boolean ispayed;
	private String means;
	private String deposit_date;
	private String report_type;
	private int report_state;
	private String number;
	public PaymentVo() {
		// TODO Auto-generated constructor stub
	}
	
	@Override
	public String toString() {
		return "PaymentVo [kanji_name=" + kanji_name + ", id=" + id
				+ ", report_id=" + report_id + ", ispayed=" + ispayed
				+ ", means=" + means + ", deposit_date=" + deposit_date
				+ ", report_type=" + report_type + ", report_state="
				+ report_state + ", number=" + number + "]";
	}

	public PaymentVo(String kanji_name, String id, int report_id,
			boolean ispayed, String means, String deposit_date,
			String report_type, int report_state, String number) {
		super();
		this.kanji_name = kanji_name;
		this.id = id;
		this.report_id = report_id;
		this.ispayed = ispayed;
		this.means = means;
		this.deposit_date = deposit_date;
		this.report_type = report_type;
		this.report_state = report_state;
		this.number = number;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getKanji_name() {
		return kanji_name;
	}
	public void setKanji_name(String kanji_name) {
		this.kanji_name = kanji_name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getReport_id() {
		return report_id;
	}
	public void setReport_id(int report_id) {
		this.report_id = report_id;
	}
	public boolean isIspayed() {
		return ispayed;
	}
	public void setIspayed(boolean ispayed) {
		this.ispayed = ispayed;
	}
	public String getMeans() {
		return means;
	}
	public void setMeans(String means) {
		this.means = means;
	}
	public String getDeposit_date() {
		return deposit_date;
	}
	public void setDeposit_date(String deposit_date) {
		this.deposit_date = deposit_date;
	}
	public String getReport_type() {
		return report_type;
	}
	public void setReport_type(String report_type) {
		this.report_type = report_type;
	}
	public int getReport_state() {
		return report_state;
	}
	public void setReport_state(int report_state) {
		this.report_state = report_state;
	}
	
}