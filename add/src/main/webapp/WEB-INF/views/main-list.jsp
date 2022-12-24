<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<style>
#leafletMap {
	height: 900px;
	width: 100%;
}
</style>

</head>
<body>
	<div class="page-header">
		<h1>�ּ� �˻� ����</h1>
	</div>
	<!-- 	<input type="text" id="address" /> -->
	<!-- 	<input type="button" value="��ȸ�ϱ�" /> -->
	<div class="input-group mb-3">
		<input type="text" class="form-control" id="address" value=""
			placeholder="�ּҸ� �Է����ּ���." aria-label="Recipient's username"
			aria-describedby="button-addon2">
		<div class="input-group-append">
			<button class="btn btn-outline-secondary" type="button"
				onclick="search()">��ȸ�ϱ�</button>
		</div>
	</div>
	<br>
	<br>
	<div id="leafletMap" class="lea"></div>


	<script type="text/javascript">

	var x = "";
	var y = "";
	
	// setup a marker group
    var markers = [];
	
	var leafletMap = "";
	
	//apikey
	var apiKey = $("#apiKey").val();

	$(document).ready(function(){
		mainCtrl.init();
	});
	
	//init
	var mainCtrl = {
		
		init : function(){
			//����
			var lon = 37.559718;
			
			//�浵
			var lat = 126.971120;
			
			//leaflet ���� ���� (EPSG : 4326)
			leafletMap = L.map('leafletMap').setView([lon, lat], 6)

			L.tileLayer("http://api.vworld.kr/req/wmts/1.0.0/"+E375A39D-7B0F-39D2-ADDD-97066A55263A+"/Base/{z}/{y}/{x}.png").addTo(leafletMap);	
		}
			
	}

	//��ȸ�ϱ�
	function search(){
		
		//������ ����� ��Ŀ ����
		for(var i = 0; i < markers.length; i++){
			leafletMap.removeLayer(markers[i]);
		}
		
		var params = {
			 service : "search"
			,request : "search"
			,version : "2.0"
			,crs : "EPSG:4326"
			,size : 10
			,page : 1
			,query : $.trim($("#address").val())
			,type : "place"
			,format : "json"
			,errorformat : "json"
			,key : E375A39D-7B0F-39D2-ADDD-97066A55263A
		}
		
		$.ajax({
			type : 'POST'
			,url : "${ct:url('/search')}"
			,dataType : 'json'
			,data : params
			,success : function(result) {
				
				var status = result.response.status;
				console.log(status);
				//��ȸ ������ ��츸
				if(status == "OK"){
					console.log(result);
					
					//leaflet ���� ���� (EPSG : 4326)
//	 				leafletMap.panTo(new L.LatLng(y, x), 10);

					var flyX = "";
					var flyY = "";
					
					for(var i=0; i<result.response.result.items.length; i++){
						x = result.response.result.items[i].point.x;
						y = result.response.result.items[i].point.y;
						
						var title = result.response.result.items[i].title;
						var address = result.response.result.items[i].address.road;
						
						//�ɸ�Ŀ ���
						leafletAddMarker(y, x, title, address);
						
					}	
					
// 					leafletMap.flyTo([flyY, flyX], 15);
					
				}
				
				else{
					alert("�ش� ��Ҹ� ã���� �����ϴ�.");
				}
				
			},
			error: function(request, status, error) {
	         
			}
		});
	}
	
	//��Ŀ �߰�
	function leafletAddMarker(lon, lat, title, address){
		//�ɸ�Ŀ
		var marker = L.marker([lon, lat]).addTo(leafletMap);
		
		//�˾� Ŭ����
		marker.bindPopup("<b>"+address+"</b><br><b>"+title+"</b>");
		markers.push(marker);
	}
	
	</script>
</body>
</html>