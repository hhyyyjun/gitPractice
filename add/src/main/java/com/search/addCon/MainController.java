package com.search.addCon;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MainController {

	/**
	  * @Method Name : main
	  * @작성일 : 2022. 2. 22.
	  * @변경이력 : 
	  * @Method 설명 : 메인
	  * @return
	*/
	@GetMapping(MAIN.MAIN)
	public String main() {
		
		return MAIN.MAIN_JSP;
	}
	
	@ResponseBody
	@PostMapping("SEARCH.SEARCH")
	public Map<String, Object> search(HttpServletResponse response, HttpServletRequest request, @RequestParam Map<String, Object> params) throws Exception {
		
		String url = makeSearchUrl("http://api.vworld.kr/req/search", params);
		System.out.println("url : " + url);
		
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST, GET, DELETE, PUT");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with, origin, content-type, accept");
		
		HttpConnectionExample httpConnectionExample = new HttpConnectionExample();
		return httpConnectionExample.sendGet(url);
	}
	
	
	/**
	  * @Method Name : makeSearchUrl
	  * @작성일 : 2022. 2. 22.
	  * @변경이력 : 
	  * @Method 설명 : 조회 url 생성
	  * @param url
	  * @param params
	  * @return
	 * @throws UnsupportedEncodingException 
	*/
	private String makeSearchUrl(String url, Map<String, Object> params) throws Exception {
		
		String service = (String) params.get("service");
		String request = (String) params.get("request");
		String version = (String) params.get("version");
		String crs = (String) params.get("crs");
		int size = Integer.parseInt((String) params.get("size"));
		int page = Integer.parseInt((String) params.get("page"));
		String query = URLEncoder.encode((String) params.get("query"), "UTF-8");
		String type = (String) params.get("type");
		String format = (String) params.get("format");
		String errorformat = (String) params.get("errorformat");
		String key = (String) params.get("key");

		url = url+"?key="+key+"&service="+service+"&request="+request+"&version="+version
				+"&crs="+crs+"&size="+size+"&page="+page+"&query="+query
				+"&type="+type+"&format="+format+"&errorformat="+errorformat;
		
		return url;
	}
	
}
