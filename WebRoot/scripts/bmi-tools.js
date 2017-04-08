function bmi(kg,h){
	var _k = parseFloat(kg);
	var _h = parseFloat(h)/100;
	var rs = _k / ( _h*_h );
	return rs.toFixed(1);
}
function bmr(age,w,h,sex){
	var bmr = 0;
	if(sex == 0){
		bmr =  w * 24;
			//Math.round((13.7*parseFloat(w))+(5.0*parseFloat(h))-(6.8*parseInt(age))+66);
	}else{
		bmr = w * 23; 
			//Math.round((9.6*w)+(1.8*h)-(4.7*age)+655);
	}
	return bmr;
}
function heart(age){
	var myH = [];
	myH.push(Math.round(parseFloat(220-age)*0.6));
	myH.push(Math.round(parseFloat(220-age)*0.8));
	return myH;
}
function hweight(bmi,h){
	var _h = parseFloat(h)/100;
	var rs = ( _h*_h ) * bmi ;
	return Math.round(rs);
}
function begin(){
	var age = $("#age").val();
	if(!$.isNumeric(age) || age>100){
		alert("请输入合理的年龄");
		return;
	}
	var height = $("#height").val();
	if(!$.isNumeric(height) || height<100 || height>230 ){
		alert("请输入合理的身高");
		return;
	}
	var weight = $("#weight").val();
	if(!$.isNumeric(weight) || height<30 || height>200 ){
		alert("请输入合理的体重");
		return;
	}
	var sex = $('input:radio[name=sex_type]:checked').val();
	if(!$.isNumeric(sex) || (sex!=0 && sex!=1) ){
		alert("请选择性别");
		return;
	}
	var _bmi = bmi(weight,height);
	$("#bmi").html(_bmi);
	$("#h-weight").html(hweight(18.5,height)+"~"+hweight(24,height));
	$("#s-weight").html(hweight(22,height));
	$("#bmr").html(bmr(age,weight,height,sex));
	var _a = heart(age);
	$("#l-low").html(_a[0]);
	$("#l-high").html(_a[1]);
	$("#rs-c").show();
}

/**
 * 体脂测量
 */
var rs = {};
function saveTz(){
	if(!ACT.memberStatus.isLogin){
		ACT.loginWin();
		return false;
	}
	var m1t = "";
	if(rs.sex == 0){
		m1t = "line.tzXb";
	}else if(rs.sex == 1){
		m1t = "line.tzYx";
	}
	ACT.openProgress();
	$.ajax({
		url:'/user/saveTzInfo?'+m1t+'='+rs.m1,
		data:{'line.tizhi':rs.tz,'line.tzFb':rs.m2,'line.tzDt':rs.m3,'line.tzYb':rs.m4,'line.tzGs':rs.m5,'line.userAge':rs.age,'line.userSex':rs.sex},
		dataType:'json',
		success:function(data){
			ACT.closeProgress();
			ACT.alertfind(data.resultEntity.resultMessage);
		},error:function(){
			ACT.closeProgress();
			ACT.alertfind("系统繁忙..请稍候");
		}
	})
}

function getTz(){
	var sex = $('input:radio[name=tz_sex_type]:checked').val();
	var age = $("#tz-age").val();
	if(!$.isNumeric(age) || age>100){
		alert("请输入合理的年龄");
		return false;
	}
	var mm = 0.0;
	var m1 = 0.0,m2 = 0.0,m3 = 0.0,m4=0.0,m5=0.0;
	if(sex == 0){
		m1 = parseFloat($("#xb").val());
	}else if(sex == 1){
		m1 = parseFloat($("#yx").val());
	}
	m2 = parseFloat($("#fb").val());
	m3 = parseFloat($("#dt").val());
	m4 = parseFloat($("#yb").val());
	m5 = parseFloat($("#gs").val());
	if(m1 && m2 && m3 && m4 && m5){
		mm = m1+m2+m3+m4+m5;
		var t1 = getTzByMM(sex,mm);
		var t2 = getTzByAge(sex, age);
		rs.sex = sex;
		rs.age = age;
		rs.m1 = m1;
		rs.m2 = m2;
		rs.m3 = m3;
		rs.m4 = m4;
		rs.m5 = m5;
		rs.tz = t1+t2;
		rs.type=getTzResult(age, sex, rs.tz);
		$.cookie("tzzc",JSON.stringify(rs), {expires:1});
		$("#rs_tz").html(rs.tz);
		$("#rs_type").html(rs.type);
		$("#rsDiv").show();
		return rs;
	}else{
		alert("请输入正确的数据");
	}
}

function getTzResult(age,sex,tz){
	if(age <= 29){
		if(sex == 0){
			if(tz < 7){
				return "很低";
			}else if(tz >= 7 && tz < 12){
				return "低";
			}else if(tz >= 12 && tz < 16){
				return "平均";
			}else if(tz >= 16 && tz < 20){
				return "稍高";
			}else if(tz >=20){
				return "高";
			}
		}else if(sex == 1){
			if(tz < 15){
				return "很低";
			}else if(tz >= 15 && tz < 19){
				return "低";
			}else if(tz >= 19 && tz < 22){
				return "平均";
			}else if(tz >= 22 && tz < 25){
				return "稍高";
			}else if(tz >=25){
				return "高";
			}
		}
	}else if( age >= 30 && age<= 39){
		if(sex == 0){
			if(tz < 11){
				return "很低";
			}else if(tz >= 11 && tz < 16){
				return "低";
			}else if(tz >= 16 && tz < 19){
				return "平均";
			}else if(tz >= 19 && tz < 22){
				return "稍高";
			}else if(tz >=22){
				return "高";
			}
		}else if(sex == 1){
			if(tz < 16){
				return "很低";
			}else if(tz >= 16 && tz < 20){
				return "低";
			}else if(tz >= 20 && tz < 23){
				return "平均";
			}else if(tz >= 23 && tz < 27){
				return "稍高";
			}else if(tz >=27){
				return "高";
			}
		}
	}else if( age >= 40 && age<= 49){
		if(sex == 0){
			if(tz < 14){
				return "很低";
			}else if(tz >= 14 && tz < 18){
				return "低";
			}else if(tz >= 18 && tz < 21){
				return "平均";
			}else if(tz >= 21 && tz < 24){
				return "稍高";
			}else if(tz >=24){
				return "高";
			}
		}else if(sex == 1){
			if(tz < 19){
				return "很低";
			}else if(tz >= 19 && tz < 24){
				return "低";
			}else if(tz >= 24 && tz < 26){
				return "平均";
			}else if(tz >= 26 && tz < 30){
				return "稍高";
			}else if(tz >=30){
				return "高";
			}
		}
	}else if( age >= 50 && age<= 59){
		if(sex == 0){
			if(tz < 15){
				return "很低";
			}else if(tz >= 15 && tz < 20){
				return "低";
			}else if(tz >= 20 && tz < 23){
				return "平均";
			}else if(tz >= 23 && tz < 26){
				return "稍高";
			}else if(tz >=26){
				return "高";
			}
		}else if(sex == 1){
			if(tz < 22){
				return "很低";
			}else if(tz >= 22 && tz < 27){
				return "低";
			}else if(tz >= 27 && tz < 30){
				return "平均";
			}else if(tz >= 30 && tz < 34){
				return "稍高";
			}else if(tz >=34){
				return "高";
			}
		}
	}else if( age >= 60){
		if(sex == 0){
			if(tz < 15){
				return "很低";
			}else if(tz >= 15 && tz < 20){
				return "低";
			}else if(tz >= 20 && tz < 24){
				return "平均";
			}else if(tz >= 24 && tz < 27){
				return "稍高";
			}else if(tz >=27){
				return "高";
			}
		}else if(sex == 1){
			if(tz < 21){
				return "很低";
			}else if(tz >= 21 && tz < 28){
				return "低";
			}else if(tz >= 28 && tz < 31){
				return "平均";
			}else if(tz >= 31 && tz < 34){
				return "稍高";
			}else if(tz >=34){
				return "高";
			}
		}
	}
	return " - -";
}

function getTzByMM(sex,mm){
	if(mm < 17){
		return sex == 0 ? 1.1 : 6.2;
	}else if(mm < 22 && mm >= 17){
		return sex == 0 ? 2.7 : 8.1;
	}else if(mm < 27 && mm >= 22){
		return sex == 0 ? 4.2 : 9.9;
	}else if(mm < 32 && mm >= 27){
		return sex == 0 ? 5.8 : 11.9;
	}else if(mm < 37 && mm >= 32){
		return sex == 0 ? 7.3 : 13.7;
	}else if(mm < 42 && mm >= 37){
		return sex == 0 ? 8.8 : 15.5;
	}else if(mm < 47 && mm >= 42){
		return sex == 0 ? 10.3 : 17.2;
	}else if(mm < 52 && mm >= 47){
		return sex == 0 ? 11.7 : 18.9;
	}else if(mm < 57 && mm >= 52){
		return sex == 0 ? 13.2 : 20.6;
	}else if(mm < 62 && mm >= 57){
		return sex == 0 ? 14.5 : 22.3;
	}else if(mm < 67 && mm >= 62){
		return sex == 0 ? 15.9 : 23.9;
	}else if(mm < 72 && mm >= 67){
		return sex == 0 ? 17.3 : 25.4;
	}else if(mm < 77 && mm >= 72){
		return sex == 0 ? 18.6 : 26.9;
	}else if(mm < 82 && mm >= 77){
		return sex == 0 ? 19.9 : 28.4;
	}else if(mm < 87 && mm >= 82){
		return sex == 0 ? 21.1 : 29.8;
	}else if(mm < 92 && mm >= 87){
		return sex == 0 ? 22.4 : 31.2;
	}else if(mm < 97 && mm >= 92){
		return sex == 0 ? 23.6 : 32.5;
	}else if(mm < 102 && mm >= 97){
		return sex == 0 ? 24.7 : 33.8;
	}else if(mm < 107 && mm >= 102){
		return sex == 0 ? 25.9 : 35.1;
	}else if(mm < 112 && mm >= 107){
		return sex == 0 ? 26.9 : 36.2;
	}else if(mm < 117 && mm >= 112){
		return sex == 0 ? 28.1 : 37.4;
	}else if(mm < 122 && mm >= 117){
		return sex == 0 ? 29.1 : 38.5;
	}else if(mm < 127 && mm >= 122){
		return sex == 0 ? 30.1 : 39.5;
	}else if(mm >= 127){
		return sex == 0 ? 31.1 : 40.5;
	}
}

function getTzByAge(sex,age){
	if(age<=19){
		return sex == 0 ? 2.1 : 1.1;
	}else if(age >= 20 && age <= 22){
		return sex == 0 ? 2.4 : 1.3;
	}else if(age >= 23 && age <= 25){
		return sex == 0 ? 2.8 : 1.5;
	}else if(age >= 26 && age <= 28){
		return sex == 0 ? 3.1 : 1.7;
	}else if(age >= 29 && age <= 31){
		return sex == 0 ? 3.5 : 1.9;
	}else if(age >= 32 && age <= 34){
		return sex == 0 ? 3.8 : 2.1;
	}else if(age >= 35 && age <= 37){
		return sex == 0 ? 4.2 : 2.3;
	}else if(age >= 38 && age <= 40){
		return sex == 0 ? 4.5 : 2.4;
	}else if(age >= 41 && age <= 43){
		return sex == 0 ? 4.9 : 2.6;
	}else if(age >= 44 && age <= 46){
		return sex == 0 ? 5.2 : 2.8;
	}else if(age >= 47 && age <= 49){
		return sex == 0 ? 5.6 : 2.9;
	}else if(age >= 50 && age <= 52){
		return sex == 0 ? 5.9 : 3.2;
	}else if(age >= 53 && age <= 55){
		return sex == 0 ? 6.3 : 3.4;
	}else if(age >= 56 && age <= 58){
		return sex == 0 ? 6.6 : 3.6;
	}else if(age >= 59 && age <= 61){
		return sex == 0 ? 6.9 : 3.8;
	}else if(age >= 62){
		return sex == 0 ? 7.3 : 3.9;
	}
}
