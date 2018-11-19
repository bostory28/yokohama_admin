package jp.co.kissco.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Hashtable;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oz.framework.api.Service;

public class ConvertToPDF {
	
	String rid = null;																//REPORT番号
	String number = null;															//受験番号
	String uname = null;															//ユーザ名前
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	
	//受験票に入る基本情報と読み込むファイル
	String ozrName = "confirm.ozr";													//formファイル
	String odiName = "yoko";														//odiファイル
	String filePath = "D:\\";														//ファイルをセーブ所
	String[] ozrParamVal = {"connection.id=admin", "connection.password=admin"};	//OZに接続するための情報
	String fileFormat = "";														//変換ファイル形式
	String fileName	= null;															//ファイル名前
	String fileName_user = null;													//ファイル名前user
	
	public ConvertToPDF(String rid, String number, String uname, HttpServletRequest request,
			HttpServletResponse response) {
		super();
		this.rid = rid;
		this.number = number;
		this.request = request;
		this.response = response;
		this.uname = uname;
		
		fileFormat = "pdf";
		fileName = number + "_受験票";												//ファイル名前
		fileName_user = uname + "_受験票." + fileFormat;								//ファイル名前(ユーザの名前、メール送るとき)
		String[] odiParamVal = {"report="+rid};										//parameter
		
		convertOZToPDDF(odiParamVal);
	}

	public ConvertToPDF(String rid, String sort, String number, String uname, HttpServletRequest request,
			HttpServletResponse response) {
		super();
		this.rid = rid;
		ozrName = sort;
		this.number = number;
		this.request = request;
		this.response = response;
		this.uname = uname;
		filePath = "C:\\Users\\PC58\\git\\yokohama_admin\\src\\main\\webapp\\ozd_file\\";
		fileFormat = "ozd";
		fileName = number;															//ファイル名前
		
		fileName_user = uname + "." + fileFormat;								//ファイル名前(ユーザの名前、メール送るとき)
		String[] odiParamVal = {"report="+rid};										//parameter
		
		convertOZToPDDF(odiParamVal);
	}

	//CONVERT PROCESS
	public void convertOZToPDDF(String[] odiParamVal) {
		try	{
			//ファイル経路設定
			fileName += "." + fileFormat;
			
			//基本情報をparamに設定
			Hashtable<String, String> param = new Hashtable<String, String>();
			
			param.put("connection.servlet", "http://192.168.1.51:9999/kissco/server");
			
			param.put("viewer.useprogressbar", "true");
			param.put("export.useprogressbar", "true");
			param.put("export.mode", "normal");
			
			param.put("comment.all", "true");
			param.put("ozd.savecomment", "true");
			param.put("pdf.savecomment", "true");
			
			param.put("export.format", fileFormat);
			param.put("export.path", filePath);
			param.put("export.filename", fileName);
			
			param.put("connection.reportname", ozrName);
			param.put("connection.pcount", Integer.toString(ozrParamVal.length));
			
			//parameter情報入力
			for (int i = 0; i < ozrParamVal.length; i++) {
				if (ozrParamVal[i].indexOf("=") > -1) {
					param.put("connection.args" + (i + 1), ozrParamVal[i]);
				}
			}
			
			// ODI設定
			param.put("odi.odinames", odiName);
			param.put("odi." + odiName + ".pcount", Integer.toString(odiParamVal.length));
			for (int i = 0; i < odiParamVal.length; i++) {
				if (odiParamVal[i].indexOf("=") > -1) {
					param.put("odi." + odiName + ".args" + (i + 1), odiParamVal[i]);
				}
			}
			
			
			//サーバ接続
			request.setAttribute("OZViewerExportParam", param);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/server");
			dispatcher.include(request, response);
			
			Boolean result = false;
			Object o = request.getAttribute("OZViewerExportResult");
			
			//ファイルセーブ
			Hashtable t = (Hashtable)o;
			System.out.println("t : "+t.get(filePath+fileName));
			byte[] b = (byte[])t.get(filePath + fileName);
			System.out.println("filePath:"+filePath+"fileName:"+fileName);			
			
			if (b != null) {
				FileOutputStream fos = null;
				File file = new File(filePath);
				System.out.println(filePath+" 디렉토리 존재여부:"+file.isDirectory());				
				if(!file.isDirectory()) {
					file.mkdir();
				}
				System.out.println(filePath+" 디렉토리 존재여부:"+file.isDirectory());
				try	{
					fos = new FileOutputStream(filePath +"\\"+ fileName);
					
					fos.write(b);
					fos.flush();
				} catch (Exception e) {
					result = false;
					e.printStackTrace();
				}
				finally {
					if (fos != null) {
						fos.close();
					}
					if (fileFormat.equals("pdf")) {
						//名前に送るためファイルcopy
						FileInputStream fis = new FileInputStream(filePath +"\\"+ fileName);
						fos = new FileOutputStream(filePath +"\\" + fileName_user);
						int data = 0;
						while ((data = fis.read()) != -1) {
							fos.write(data);
						}
						fis.close();
						fos.close();
					}
				}
				result = file.exists() ? true : false;
			} else {
			System.out.println("result=false");
				result = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return;
		}
	}
}
