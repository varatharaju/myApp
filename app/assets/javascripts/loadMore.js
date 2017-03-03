$(document).ready(function () {
	$(document).on("click","#loadMore",function(){
		var page_no = parseInt($("#page_no").val()) + 1;
	    $.ajax({
		    url:  "get_reports?page_no="+page_no,
		    dataType: "json",
		    success: function(data) { 
		        
		        $("#page_no").val(page_no);
		        data.data.forEach(function(report){
		        	$("#report_data").append("<tr><td>"+report.date+"</td><td>"+report.position
		        		+"</td><td>"+report.size+"</td><td>"+report.bidder+"</td><td>"+report.event_type
		        		+"</td><td>"+report.num_records+"</td><td>"+report.cpm_sum+"</td></tr>")
		        });
		    }
		});
	});
});
