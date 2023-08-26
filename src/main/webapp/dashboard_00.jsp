<%@ page language = "java" import = "java.sql.*, javax.naming.*, javax.sql.*, java.io.FileOutputStream, java.io.IOException,
 java.awt.Color,java.lang.*,java.text.*, java.util.ArrayList, java.util.List, java.util.HashMap, java.util.LinkedHashMap,
  java.util.Map,java.util.Map,java.io.*, java.net.*, java.io.*, java.io.File,java.util.regex.*"%>
<!DOCTYPE html>
<html>
<head>
	<title>Database</title>


	<!--http://192.168.62.201:8889/Imm/vishwajeet/im_flight_routes_dashboard_00.jsp-->

	<script>
	function openDetails(tagname)
	{
		if(tagname == 'arrival')
		{
			modelWindow_download("im_flight_routes_dashboard_01_arr.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if(tagname == 'departure')
		{
			modelWindow_download("im_flight_routes_dashboard_02_dep.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'domestic') 
		{
			modelWindow_download("im_flight_routes_dashboard_03_domestic.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'neither') 
		{
			modelWindow_download("im_flight_routes_dashboard_04_neither.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'arrival_Hop')
		{
			modelWindow_download("im_flight_routes_dashboard_05_arr_hop.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'departure_Hop')
		{
			modelWindow_download("im_flight_routes_dashboard_06_dep_hop.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'country') 
		{
			modelWindow_download("im_flight_routes_dashboard_07_country.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'carrier') 
		{
			modelWindow_download("im_flight_routes_dashboard_08_carrier.jsp?tagname="+tagname,'_blank', '0.80');
		}
	}
	var popupWindow = null;
	function modelWindow_download (mypage, myname, v_size)
	{
		var tmp_width = Math.round(screen.width * 0.70);
		var tmp_height = Math.round(screen.height * 0.80);
		var LeftPosition = (screen.width) ? (screen.width-tmp_width)/2 : 0;
		var TopPosition = (screen.height) ? (screen.height-tmp_height)/2 : 0;

		settings = 'dialogWidth:'+tmp_width+'px; dialogHeight:'+tmp_height+'px; dialogLeft:'+LeftPosition+'px;'+';dialogTop:'+TopPosition+'px;'+';toolbar=no;location=no;directories=no;menubar=no;scrollbars=yes;resizable=yes;';
		//win2 = window.showModalDialog(mypage, settings, settings);
			//window.open(mypage,"_blank","toolbar=yes,scrollbars=yes,resizable=yes,top=500,left=500,width=400,height=400");
			
			if(popupWindow && !popupWindow.closed){
				popupWindow.focus();

				document.onmousedown = popupWindow.focus();
				document.onkeyup = popupWindow.focus();
				document.onmousemove = popupWindow.focus();
			}
			else{

				popupWindow = window.open(mypage,"_blank","toolbar=yes,scrollbars=yes,resizable=0,location=yes,directories=no,menubar=yes,width="+tmp_width+",height="+tmp_height+",left="+LeftPosition+",top="+TopPosition);

				popupWindow.focus();
				
				document.onmousedown = popupWindow.focus();
				document.onkeyup = popupWindow.focus();
				document.onmousemove = popupWindow.focus();
			}

	}

	</script>
</head>

<body style="background-color: #f6f2ff; ">
			
		<h1 style="font-family: Arial;background-color: #D0DDEA; color: #347FAA; font-size: 40px;"><center>International Flights Arriving to India</center></h1><br><br>

		<!--http://192.168.62.201:8889/Imm/vishwajeet/im_flight_routes_dashboard_00.jsp-->

		<%
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = null;
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tutorial","root", "root");

		PreparedStatement ps1 = null;
		PreparedStatement ps3 = null;
		PreparedStatement ps4 = null;
		PreparedStatement ps5 = null;
		PreparedStatement ps9 = null;
		PreparedStatement ps10 = null;
		PreparedStatement ps11 = null;
		PreparedStatement ps12 = null;
		PreparedStatement ps13 = null;	

			/////////////////////////////////////////////////////	Summary Table	//////////////////////////////////////////////////////////

		String selectQuery= "";
		String flightNumber1 = "";String  sourcePort1 = "" ;String  destinationPort1 = "" ;String sourceCountryCode1 = "";String  destinationCountryCode1 = "" ;
		String flightNumber2 = "";String  sourcePort2 = "" ;String  destinationPort2 = "" ;String sourceCountryCode2 = "";
		String destinationCountryCode2 = "" ;

		String dep_flt_no = "";
					
		String selectSummary = "";
		String total_Flights_By_Digits = "";
		String bothIndiaFlights = "";
		int arr_dep_matched_flts = 0;
		int arr_dep_not_matched_flts = 0;
		int arr_dep_not_defined_matched_flts = 0;

		String totalflights= ""; String arrflights = ""; String depflights = ""; String neitherFlights = "";
			
	try{
			
		try{
				selectSummary = "select count(1) from IM_FLIGHT_ROUTES";
				ps3 = con.prepareStatement(selectSummary);
				ResultSet rs3 = null;
				rs3 = ps3.executeQuery();
				if(rs3.next()){
						totalflights = rs3.getString(1);
				} 
				if(rs3!=null)
				{	
					rs3.close();
				}
			}

			catch(Exception e){
				System.out.println("All Flights Exception");
			}
				
				try{
						selectSummary = "select count(1) from IM_FLIGHT_ROUTES where DEST_COUNTRY_CODE='IND' and SRC_COUNTRY_CODE <> 'IND'";
						ps3 = con.prepareStatement(selectSummary);
						ResultSet rs3 = null;
						rs3 = ps3.executeQuery();
						if(rs3.next()){
								arrflights = rs3.getString(1);
						} 
						rs3.close();
				}
					catch(Exception e){
						System.out.println("Arrival Exception");
					}

				try{
						selectSummary = "select count(1) from IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE='IND' and DEST_COUNTRY_CODE <>'IND' ";
						ps3 = con.prepareStatement(selectSummary);
						ResultSet rs3 = null;
						rs3 = ps3.executeQuery();
						if(rs3.next()){
								depflights = rs3.getString(1);
						} 
						rs3.close();
				}
					catch(Exception e){
						System.out.println("Departure Exception");
					}
				
				try{
						selectSummary = "SELECT count(1) FROM IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE <> 'IND' ";
						ps3 = con.prepareStatement(selectSummary);
						ResultSet rs3 = null;
						rs3 = ps3.executeQuery();
						if(rs3.next()){
								neitherFlights = rs3.getString(1);
						} 
						rs3.close();

				}
				
					 catch(Exception e){
						System.out.println("Neither Arrival nor Departure Exception");

					}

					try{
						selectSummary = "SELECT count(1) FROM IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE = 'IND' ";
						ps3 = con.prepareStatement(selectSummary);
						ResultSet rs3 = null;
						rs3 = ps3.executeQuery();
						if(rs3.next()){
								bothIndiaFlights = rs3.getString(1);
						} 
						rs3.close();

				}
				
					 catch(Exception e){
						System.out.println("both Arrival and Departure Exception");
					}

			%>
				<table align="center" width="80%" border="1" cellspacing="0" cellpadding="8" bordercolorlight="#e5f6ff" bodercolordark="#e5f6ff" bodercolor="#e5f6ff" style="border-collapse: collapse;background-color: #FFFFFF; font-family: verdana;font-size: 8pt;text-align: left; border-color:#e5f6ff;">
					<tr style=" background-color: #E6AD80;font-family: Verdana; font-size: 15px; font-weight: bold; color: white;">
						<td bgcolor="#ADB643"><center>Total Flights<!--<br><br><font style="font-size:8px;font-weight: normal; ">select count(1) from IM_FLIGHT_ROUTES--></center></td>
						<td bgcolor="#9f1853"><center>Arrival Flights<!--<br><br><font style="font-size:8px; color: white; font-weight: normal; ">DEST_COUNTRY_CODE='IND' and SRC_COUNTRY_CODE <> 'IND'</font>--></center></td>
						<td bgcolor="#D46545"><center>Departure Flights<!--<br><br><font style="font-size:8px; color: white; font-weight: normal;">SRC_COUNTRY_CODE='IND' and DEST_COUNTRY_CODE <>'IND'</font>--></center></td>
						<td bgcolor="#818A59"><center>Domestic Flights<!--<br><br><font style="font-size:8px; color:white; font-weight: normal;">SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE = 'IND'</font>--></center></td>
						<td bgcolor="#E89C2D"><center>Flights neither Arriving nor Departing<br> from India<!--<br><br><font style="font-size:8px; color: white; font-weight: normal;">SRC_COUNTRY_CODE <> 'IND' and DEST_COUNTRY_CODE <> 'IND'</font>--></center></td>
					</tr>

					<tr style="font-family: Verdana; font-size: 14pt; color:white;font-weight: bold">
						<td bgcolor="#ADB643"><center><%=totalflights%></center></td>
						<td bgcolor="#9f1853"><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('arrival')">
							<%=arrflights%></a></center></td>
						<td bgcolor="#D46545"><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('departure')">
							<%=depflights%></a></center></td>
						<td bgcolor="#818A59"><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('domestic')">
							<%=bothIndiaFlights%></a></center></td>
						<td bgcolor="#E89C2D"><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('neither')"><%=neitherFlights%></a></center></td>
					</tr>

							<%///////////////////////////////////////////		Summary Table - End 	///////////////////////////////////////%>


		<%////////////////////////////////////////////////////////////  Hoping Table - Start  //////////////////////////////////////////////////////////////////////%>
							
					<tr style=" background-color: #E6AD80;color: white;">
						<td bgcolor="f6f2ff" colspan="5">&nbsp;</td>				
					</tr>

					<tr style=" background-color: #E6AD80;font-family: Verdana; font-size: 15px; font-weight: bold; color: white;">
						<td bgcolor="#f6f2ff">&nbsp;</td>
						<td bgcolor="#599e94"><center>Arrival Hopping Flights</center></td>
						<td bgcolor="#76c8c8"><center>Departure Hopping Flights	</center></td>
						<td bgcolor="#f6f2ff">&nbsp;</td>
						<td bgcolor="#f6f2ff">&nbsp;&nbsp;</td>
					</tr>

					<%
					String selectHopping = "";
					String arr_Hop = "";
					String dep_Hop = "";
					String dep_Count = "";
					try{
						selectHopping = "SELECT count(1) as arr_count FROM IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' and (HOP1_PORT_CODE is not null or HOP2_PORT_CODE is not null)";
						ps11 = con.prepareStatement(selectHopping);
						ResultSet rs11 = null;
						rs11 = ps11.executeQuery();
                       if(rs11.next())
                       {
							arr_Hop = rs11.getString("arr_count");
                       }
                       rs11.close();
                       ps11.close();
                       selectHopping = "SELECT count(1) as dep_Count FROM IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' and (HOP1_PORT_CODE is not null or HOP2_PORT_CODE is not null)";
						ps11 = con.prepareStatement(selectHopping);
						rs11 = null;
						rs11 = ps11.executeQuery();
                      if(rs11.next())
                      {
                    	  dep_Hop = rs11.getString("dep_Count");
                      }
                      rs11.close();
                      ps11.close();
                       
					%>

					<tr style=" background-color: #E6AD80;font-family: Verdana; font-size: 14pt; font-weight: bold; color: white;">
						<td bgcolor="#f6f2ff">&nbsp;</td>
						<td bgcolor="#599e94"><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('arrival_Hop')">
							<%=arr_Hop %></a></center></td>
						<td bgcolor="#76c8c8"><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('departure_Hop')">
							<%=dep_Hop %></a></center></td>
						<td bgcolor="#f6f2ff">&nbsp;</td>
						<td bgcolor="#f6f2ff">&nbsp;&nbsp;</td>
					</tr>
				</table><br><br><p>
					<%
		}
				catch(Exception e){
					System.out.println("Hoping Table Exception");
				} 
							
							//////////////////////////////////////////////////////////	End of Hoping Table 	////////////////////////////////////////////////////////


		////////////////////////////////////////////////////////////	Flight No. Length Table Start ///////////////////////////////////////////////////////////

				String selectTotal = "";
				String fiveDigitFlight = "";
				String sixDigitFlight = "";
				String sevenDigitFlight = "";
				String eightDigitFlight = "";
				String nineDigitFlight = "";
				String tenDigitFlight = "";
				try{
					selectTotal = "select LENGTH(flight_no) as flight_no_length, count(1) as ccount from IM_FLIGHT_ROUTES group by LENGTH(flight_no) order by 1 asc";
					ps4 = con.prepareStatement(selectTotal);
					ResultSet rs4 = null;
					rs4 = ps4.executeQuery();

				%><table align="center" width="50%" border="1" cellspacing="0" cellpadding="8" bordercolorlight="#FF99CC" bodercolordark="#FF99CC" bodercolor="#FF99CC" style="border-collapse: collapse;background-color: #FFFFFF; font-family: verdana;font-size: 8pt;text-align: left; border-color:#e5f6ff;">
				<tr style=" background-color: #E6E6EA;font-family: Verdana; font-size: 15px; color:white;font-weight: normal;">
					<td bgcolor="#115f9a"><center>Flight No.<br>(length 5 char)</center></td>
					<td bgcolor="#1984c5"><center>Flight No.<br>(length 6 char)</td>
					<td bgcolor="#22a7f0"><center>Flight No.<br>(length 7 char)</center></td>
					<td bgcolor="#de6e56"><center>Flight No.<br>(length 8 char)</center></td>
					<td bgcolor="#e14b31"><center>Flight No.<br>(length 9 char)</center></td>
					<td bgcolor="#c23728"><center>Flight No.<br>(length 10 char)</center></td>
				</tr>
				<%	
					while(rs4.next())
					{
						if(rs4.getInt("FLIGHT_NO_LENGTH")==5) fiveDigitFlight=rs4.getString("CCOUNT");
						if(rs4.getInt("FLIGHT_NO_LENGTH")==6) sixDigitFlight=rs4.getString("CCOUNT");
						if(rs4.getInt("FLIGHT_NO_LENGTH")==7) sevenDigitFlight=rs4.getString("CCOUNT");
						if(rs4.getInt("FLIGHT_NO_LENGTH")==8) eightDigitFlight=rs4.getString("CCOUNT");
						if(rs4.getInt("FLIGHT_NO_LENGTH")==9) nineDigitFlight=rs4.getString("CCOUNT");
						if(rs4.getInt("FLIGHT_NO_LENGTH")==10) tenDigitFlight=rs4.getString("CCOUNT");

					}
						if(rs4!=null)
								{	
									rs4.close();
								}

					%>
						<tr style="font-family: Verdana; font-size: 14pt; color:white;font-weight: bold">
							<td bgcolor="#115f9a"><center><%=fiveDigitFlight%></center></td>
							<td bgcolor="#1984c5"><center><%=sixDigitFlight%></center></td>
							<td bgcolor="#22a7f0"><center><%=sevenDigitFlight%></center></td>
							<td bgcolor="#de6e56"><center><%=eightDigitFlight%></center></td>
							<td bgcolor="#e14b31"><center><%=nineDigitFlight%></center></td>
							<td bgcolor="#c23728"><center><%=tenDigitFlight%></center></td>
						</tr>
					</table><br><p><p>
					<%
								
					}
				
			catch(Exception e){
				System.out.println("Digits Flights");
			}
		/////////////////////////////////////////////////		Flight No. Length Table - End		/////////////////////////////////////////////////

		//////////////////////////////////////////		Country Arrival And Departure Table - Start (Demo)     ///////////////////////////////////////////

	String select_Arr_CarrierTotal = "";
	String select_Dep_CarrierTotal = "";

	String srcCountryCode = "";
	String srcCountryCode2 = "";
	String carriersCount2 = "";
	String carriersCount3 = "";
	String carriersCount4 = "";
	String CountQuery3 = "";
	String CountQuery4 = "";
	String QueryCount3 = "";
	String QueryCount4 = "";

	int carrierCount5 = 0;
	int total_Arr_Country = 0;
	int sum_Arr_Dep_Country = 0;
	int count3 = 0;
	int count4 = 0;
	int sum_Countries_Record = 0;
	
	PreparedStatement ps6 = null;
	PreparedStatement ps7 = null;
	PreparedStatement ps8 = null;


	try{
		select_Arr_CarrierTotal = "select SRC_COUNTRY_CODE as src_country, count(1) as ca_arr_count from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by SRC_COUNTRY_CODE order by 2 desc";
		ps6 = con.prepareStatement(select_Arr_CarrierTotal);
		ResultSet rs6 = null;
		rs6 = ps6.executeQuery();  
		
		ResultSet rs13 = null;

		try{
				CountQuery3 = "select count(1) from (" + select_Arr_CarrierTotal.toString() + ")"; //out.println("<br>" + CountQuery);
				ps13 = con.prepareStatement(CountQuery3);
				rs13 = ps13.executeQuery(); 
				if(rs13.next())
					{
						QueryCount3 = rs13.getString(1);
					}
					rs13.close();
					ps13.close();						
					//out.println("      Your Query yields " + QueryCount3 + " Records");
					count3 = Integer.parseInt(QueryCount3);

		   }
		catch(Exception e)
		{
			out.println(e);
		}


		try{
			CountQuery4 = "select count(1) from (select DEST_COUNTRY_CODE as dest_country, count(1) as ca_dep_count from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' and DEST_COUNTRY_CODE in (select DEST_COUNTRY_CODE as dest_country from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' group by DEST_COUNTRY_CODE minus select SRC_COUNTRY_CODE as src_country from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by SRC_COUNTRY_CODE ) group by DEST_COUNTRY_CODE order by 2 desc)"; //out.println("<br>" + CountQuery);
			ps13 = con.prepareStatement(CountQuery4);
			rs13 = ps13.executeQuery(); 
			if(rs13.next())
				{
					QueryCount4 = rs13.getString(1);
				}
				rs13.close();
				ps13.close();						
				//out.println("      Your Query yields " + QueryCount4 + " Records");
				count4 = Integer.parseInt(QueryCount4);
				sum_Countries_Record = count3 + count4;////MAIN 2

		}
			catch(Exception e)
			{
				out.println(e);
			}
		
	}
	catch(Exception e){
		System.out.println("Carrier Arrival And Departure Table Exception");
	}


		///////////////////////////////////////////////////	Country Arrival And Departure Table - End  ////////////////////////////////////////////////////////////////////////////	
			

				/*
					CARRIER                    VARCHAR2(100) 
					FLIGHT_NO                  VARCHAR2(20)  
					DEP_FLIGHT_NO              VARCHAR2(20)  
					SRC_PORT_CODE     NOT NULL VARCHAR2(3)   
					HOP1_PORT_CODE             VARCHAR2(3)   
					HOP2_PORT_CODE             VARCHAR2(3)   
					DEST_PORT_CODE    NOT NULL VARCHAR2(3)   
					SRC_PORT_DESC              VARCHAR2(280) 
					HOP1_PORT_DESC             VARCHAR2(280) 
					HOP2_PORT_DESC             VARCHAR2(280) 
					DEST_PORT_DESC             VARCHAR2(280) 
					SRC_COUNTRY_CODE           VARCHAR2(80)  
					HOP1_COUNTRY_CODE          VARCHAR2(80)  
					HOP2_COUNTRY_CODE          VARCHAR2(80)  
					DEST_COUNTRY_CODE          VARCHAR2(80)  
					SRC_COUNTRY_DESC           VARCHAR2(80)  
					HOP1_COUNTRY_DESC          VARCHAR2(80)  
					HOP2_COUNTRY_DESC          VARCHAR2(80)  
					DEST_COUNTRY_DESC          VARCHAR2(80)  
					ROUTE                      VARCHAR2(80)  
					ICP_SRNO                   VARCHAR2(3)   
					ENTRY_DATE                 DATE          
					FLIGHT_NUMBER     NOT NULL VARCHAR2(20)  
				*/
			
		//////////////////////////////////////////////////////	 Carriers Arr Dep List Table - Start  //////////////////////////////////////////////////////////////


		String selectCarrier = "";
		String carriers = "";
		String carriersCount = "";
		int carrierFlightCount = 0;
		int total_Carrier_Arr_Count = 0;
		int total_carrierFlightCount = 0;
		int sum_Arr_Dep = 0;
		int total_Arr_Carrier = 0;
		int total_Final = 0;
		String carrier_Arr = "";
		String selectCarrierDep = "";
		String selectCarrierArr = "";
		String carrier_Arr_Count = "";
		String carrier_Dep = "";
		String carrier_Dep_Count = "";
		String bgcolor="e8daff";
		String QueryCount = "";
		String CountQuery = "";
		String QueryCount2 = "";
		String CountQuery2 = "";
		int sum_Carriers_Record = 0;
		int count1 = 0;
		int count2 = 0;
		int query1 = 0;
		int query2 = 0;

		try{
			selectCarrierArr= "select substr(flight_no,1,2) as flight_carriers_Arr, count(1) as ca_Arr_Count from IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by substr(flight_no,1,2) order by 2 desc";

				////Arrival	

					ps9 = con.prepareStatement(selectCarrierArr);
					ResultSet rs9 = null;
					ResultSet rs12 = null;

			try
				{
					CountQuery = "select count(1) from (" + selectCarrierArr.toString() + ")"; //out.println("<br>" + CountQuery);
					ps12 = con.prepareStatement(CountQuery);
					rs12 = ps12.executeQuery(); 
					if(rs12.next())
						{
							QueryCount = rs12.getString(1);
						}
						rs12.close();
						ps12.close();						
						//out.println("      Your Query yields " + QueryCount + " Records");
						count1 = Integer.parseInt(QueryCount);
						


				}
				catch(Exception e)
				{
					out.println(e);
				}

				try
				{
					CountQuery2 = "select count(1) from (select substr(flight_no,1,2) as flight_carriers, count(1) as ca_dep_new_count from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' and substr(flight_no,1,2) in (select substr(flight_no,1,2) as flight_carriers from IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' group by substr(flight_no,1,2) minus select substr(flight_no,1,2) as flight_carriers from IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by substr(flight_no,1,2)) group by substr(flight_no,1,2) order by 2 desc)"; 
					ps12 = con.prepareStatement(CountQuery2);
					rs12 = ps12.executeQuery(); 
					if(rs12.next())
						{
							QueryCount2 = rs12.getString(1);
						}
						rs12.close();
						ps12.close();						
						//out.println("      Your Query yields " + QueryCount + " Records");
						count2 = Integer.parseInt(QueryCount2);
						sum_Carriers_Record = count1+count2;//////////MAIN 2

					
				}
				catch(Exception e)
				{
					out.println(e);
				}

				

			%></table><br><p><p><%
		}	

	catch(Exception e){
			System.out.println("Carrier list Arr Dep table Exception");
		}

				/////////////////////////////////////////////			Carriers Arr Dep List Table - End		////////////////////////////////////////	

							//////////////////////////////////   Countries And Carriers  /////////////////////////////////

			%>
				<table align="center" width="25%" border="1" cellspacing="0" cellpadding="8" bordercolorlight="#FF99CC" bodercolordark="#FF99CC" bodercolor="#FF99CC" style="border-collapse: collapse;background-color: #FFFFFF; font-family: verdana;font-size: 8pt;text-align: left; border-color:#e5f6ff;">

					<tr style=" background-color: #78a9ff;font-family: Verdana; font-size: 15px; color:white;font-weight: bold;">
						<td  bgcolor="#0072c3" align="center">Countries</td>
						<td  bgcolor="#a2191f" align="center">Carriers</td>
					</tr>
					
					<tr style="font-family: Verdana; font-size: 14pt; color:white;font-weight: bold">
						<td bgcolor="#0072c3" align="center"><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('country')">
							<%=sum_Countries_Record%></a></td>
						<td bgcolor="#a2191f" align="center"><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('carrier')">
							<%=sum_Carriers_Record%></a></td>
					</tr>
				</table><br><p><p>
			<%

		
/////////////////////////////////////////////////////////////////
		}



					catch(Exception e)  
						{    
								
							out.println("selectQuery Exception");  
						}  
												
							con.commit();
							con.close();							
							%>
</body>

</html>