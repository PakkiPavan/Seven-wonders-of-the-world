<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Seven wonders</title>
<style>
img{
height:462px;
width:650px;
/* height:462px;
width:650px;
 *//* box-shadow:6px 5px 0px 0px #8888; */
}
.container{
  background-color:red;
  position:relative;
  height:462px;
  width:650px;
  float:left;
  margin:10px 10px;
}
.inner{
  position:absolute;
  background-color:rgb(255,255,255,0.8);
  top:20px;
  left:20px;
  width:613px;
  height:425px;
  display:flex;
  align-items:center;
  justify-content:center;
  opacity:0;
}
.container:hover .inner{
cursor:pointer;
opacity:1;
}
.container:hover .footer{
opacity:0;
}

.footer{
 background-color:rgb(255,255,255,0.8);
 position:absolute;
 bottom:0px;
 width:650px;
 height:40px;
}
.text
{
 position:absolute;
 right:10px;
 font-size:20px;
 top:8px;
}
.ratings
{
 position:absolute;
 left:5px;
 font-size:20px;
 top:8px;
}
#header
{
 position:absolute;
 background-color:silver;
 top:60px;
 height:60px;
 width:100%;
}
.likes
{
 position:absolute;
 top:2px;
 right:20px;
 font-size:30px;
}
</style>
<script>
$(document).ready(function(){
	$.ajax({
		url:'http://www.mocky.io/v2/5bdd28dd32000075008c6227',
		success:function(d)
		{
			//console.log(d);
			$.each(d.data,function(key,value){
				var p=value.place;
				p=p.replace(/ /g,'');
				p=p.replace('(','');
				p=p.replace(')','');
				
				//alert(p);
				//$("#wonders").append('<div class="container" style="background-color:red;position:relative;height:462px;width:650px;float:left;margin:5px 5px;"><img src='+value.imageURL+'><div style="background-color:rgb(255,255,255,0.8);position:absolute;bottom:0px;width:650px;height:40px;"><div style="position:absolute;bottom:12px;right:10px;font-size:20px">'+value.place+'</div></div></div>');
				//$("#wonders").append('<div class="container"> <img src="'+value.imageURL+'"><div class="inner"><div class="text"><center><h2>'+value.place+'</h2></center>'+value.description+'</div></div><div><div class="footer">'+value.place+'</div></div></div>');
		       
				$("#wonders1").append('<div class="container"><img src="'+value.imageURL+'"><div class="inner"><div class="likes"><i class="fa fa-gratipay" id="'+p+'" onclick="like('+key+',\''+p+'\')"></i></div><center><h2>'+value.place+'</h2>'+value.description+'</center></div><div class="footer"><div class="text">'+value.place+'</div><div class="ratings" id="'+value.id+'">Ratings:</div></div></div><input type="hidden" id="'+key+'" value="0">')
				
				var star="";
				for(var i=0;i<5;i++)
				{
					var j=i<value.ratings?"fa fa-star":"fa fa-star-o";
					star=star+'<i class="'+j+'"></i>';
				}
				//if(3.5>3&&3.5<4)
				//console.log("Half Rating");
				$("#"+value.id).append(star);
				$("#"+p).append(0);
			});
			
		}
	});	
});
function search()
{
	var s=$("#search").val();
	//alert(s);
	$("#wonders2").hide();
	$("#wonders3").hide();
	if(s=="")
	{
		$("#wonders1").show();
		$("#wonders2").hide();
	}
	else
	{
		//$("#wonders2").empty();
		$.ajax({
			url:'http://www.mocky.io/v2/5bdd28dd32000075008c6227',
			success:function(d)
			{
				$.each(d.data,function(key,value){
					//alert(value.place.toUpperCase());
					if(s.toUpperCase()==value.place.toUpperCase())
					{
						$("#wonders1").hide();
						//alert(value.id.toLowerCase());
						$("#wonders2").empty();
						$("#wonders2").append('<div class="container"><img src="'+value.imageURL+'"><div class="inner"><center><h2>'+value.place+'</h2>'+value.description+'</center></div><div class="footer"><div class="text">'+value.place+'</div><div class="ratings" id="'+value.id.toLowerCase()+'">Ratings:</div></div></div>');
						$("#wonders2").show();
						//alert("YES1");
						var star="";
						for(var i=0;i<5;i++)
						{
							var j=i<value.ratings?"fa fa-star":"fa fa-star-o";
							star=star+'<i class="'+j+'"></i>';
						}
						//if(3.5>3&&3.5<4)
						//console.log("Half Rating");
						$("#"+value.id.toLowerCase()).append(star);
					}
				    else
					{
						$("#wonders1").hide();
						//$("#wonders2").hide();
					}  
				});
			}
			 
		 });
		
	}

}
function sort()
{
 var s=$("#sort").val();
 if(s=="")
 {
		$("#wonders1").show();
		$("#wonders2").hide();
		$("#wonders3").hide();
 }	 
 else if(s.toLowerCase()=="ratings")
 {
	 $("#wonders1").hide();
	 $("#wonders2").hide();
	 $.ajax({
			url:'http://www.mocky.io/v2/5bdd28dd32000075008c6227',
			success:function(d)
			{
				$("#wonders3").empty();
				var i=0;
				var a=[];
				$.each(d.data,function(key,value){
					a[i++]=value.ratings;
				});
				a.sort()
				a.reverse();
				//alert(a);
				for(var v=0;v<a.length;v++)
				{
					$.each(d.data,function(key,value){
						if(value.ratings==a[v])
						{
							$("#wonders3").append('<div class="container"><img src="'+value.imageURL+'"><div class="inner"><center><h2>'+value.place+'</h2>'+value.description+'</center></div><div class="footer"><div class="text">'+value.place+'</div><div class="ratings" id="'+v+'">Ratings:</div></div></div>')
							var star="";
							for(var i=0;i<5;i++)
							{
								var j=i<value.ratings?"fa fa-star":"fa fa-star-o";
								star=star+'<i class="'+j+'"></i>';
							}
							$("#"+v).append(star);
							$("#wonders3").show();
						}
		
					});
				}

			}
	 });
	 
 }
}
function like(key,p)
{
	var h=$("#"+key).val();
	h=parseInt(h)+1;
	$("#"+key).val(h);
	//var c=$('i').attr('id');
	$("#"+p).empty();
	$("#"+p).append(h);
}
</script>
</head>
<body>
<img src="https://rupeek.com/images/logo.svg" style="position:absolute;height:50px;width:100px;">
<div id="header">
 <div id="searchby">
  <input type="text" id="search" placeholder="Search by name" style="position:absolute;padding:15px;left:5px;" onkeyup="search()">
 </div>
 <div id="sortby">
  <div style="position:absolute;right:220px;font-size:25px;"> Sort By:</div> <input type="text" id="sort" style="position:absolute;padding:15px;right:20px;" onkeyup="sort()">
 </div>
</div>
<div id="wonders1" style="position:absolute;top:120px;">
</div>
<div id="wonders2" style="position:absolute;top:120px;">
</div>
<div id="wonders3" style="position:absolute;top:120px;">
</div>
<input type="hidden" value="0" id="hid">
</body>
</html>
