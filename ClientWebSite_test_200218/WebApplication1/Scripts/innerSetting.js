
// kendo elements
var editor = null;
var editor_eng = null;
var date_begin = null;
var date_end = null;
var time_begin = null;
var time_end = null;

// common member
var currentId = '';
var korImagePath = '';
var engImagePath = '';
var currentService = '';
var memberFile = [];
var lastFile = [];

$(document).ready(function () {
    if (window.location.href.indexOf('/Announcements/') >= 0) {
        $('.tpmenu').find('a').eq(0).addClass("current");
    } else if (window.location.href.indexOf('/FAQ/') >= 0) {
        $('.tpmenu').find('a').eq(1).addClass("current");
    } else if (window.location.href.indexOf('/PopupAnnouncements/') >= 0) {
        $('.tpmenu').find('a').eq(2).addClass("current");
    } else if (window.location.href.indexOf('/Attachments/') >= 0) {
        $('.tpmenu').find('a').eq(3).addClass("current");
    } else if (window.location.href.indexOf('/AdUsers_List.aspx') >= 0) {
        $('.tpmenu').find('a').eq(4).addClass("current");
    } else if (window.location.href.indexOf('/AzureRegionList.aspx') >= 0) {
        $('.tpmenu').find('a').eq(5).addClass("current");
    } else if (window.location.href.indexOf('/GroupMappingList.aspx') >= 0) {
        $('.tpmenu').find('a').eq(6).addClass("current");
    }
});

// function 
function editorSetting(elemId, isEng) {
    $("#" + elemId).kendoEditor({
        encoded: false,
        tools: [
            {
                name: "bold",
                tooltip: "굵게"
            }, {
                name: "italic",
                tooltip: "기울임꼴"
            }, {
                name: "underline",
                tooltip: "밑줄"
            }, {
                name: "fontName",
                items: [{
                    text: "기본",
                    value: "NotoSans-Regular"
                }, {
                    text: "맑은 고딕",
                    value: "Malgun Gothic"
                }, {
                    text: "궁서",
                    value: "Gungsuh"
                }, {
                    text: "궁서체",
                    value: "GungsuhChe"
                }, {
                    text: "굴림",
                    value: "Gulim"
                }, {
                    text: "굴림체",
                    value: "GulimChe"
                }, {
                    text: "바탕",
                    value: "Batang"
                }, {
                    text: "바탕체",
                    value: "BatangChe"
                }, {
                    text: "돋움",
                    value: "Dotum"
                }, {
                    text: "돋움체",
                    value: "DotumChe"
                }, {
                    text: "Arial",
                    value: "Arial,Helvetica,sans-serif"
                }, {
                    text: "Courier New",
                    value: "'Courier New',Courier,monospace"
                }, {
                    text: "Georgia",
                    value: "Georgia,serif"
                }, {
                    text: "Impact",
                    value: "Impact,Charcoal,sans-serif"
                }, {
                    text: "Lucida Console",
                    value: "'Lucida Console',Monaco,monospace"
                }, {
                    text: "Tahoma",
                    value: "Tahoma,Geneva,sans-serif"
                }, {
                    text: "Times New Roman",
                    value: "'Times New Roman',Times,serif"
                }, {
                    text: "Trebuchet MS",
                    value: "'Trebuchet MS',Helvetica,sans-serif"
                }, {
                    text: "Verdana",
                    value: "Verdana,Geneva,sans-serif"
                }],
                tooltip: "글꼴"
            }, {
                name: "fontSize",
                tooltip: "글꼴 크기"
            }, {
                name: "formatting",
                tooltip: "글꼴 형식"
            }, {
                name: "foreColor",
                tooltip: "글꼴 색"
            }, {
                name: "backColor",
                tooltip: "음영"
            }, {
                name: "justifyLeft",
                tooltip: "왼쪽 맞춤"
            }, {
                name: "justifyCenter",
                tooltip: "가운데 맞춤"
            }, {
                name: "justifyRight",
                tooltip: "오른쪽 맞춤"
            }, {
                name: "justifyFull",
                tooltip: "균등 분할"
            }, {
                name: "viewHtml",
                tooltip: "HTML 수정"
            }, {
                name: "createTable",
                tooltip: "표 삽입"
            }, {
                name: "addColumnLeft",
                tooltip: "왼쪽에 열 추가"
            }, {
                name: "addColumnRight",
                tooltip: "오른쪽에 열 추가"
            }, {
                name: "addRowAbove",
                tooltip: "위에 행 추가"
            }, {
                name: "addRowBelow",
                tooltip: "아래에 행 추가"
            }, {
                name: "deleteRow",
                tooltip: "행 삭제"
            }, {
                name: "deleteColumn",
                tooltip: "열 삭제"
            }, {
                name: "image-export",
                tooltip: "이미지 삽입",
                exec: function (e) {
                    if (isEng != "T") {
                        $('#txtTempFile').trigger('click');
                    } else {
                        $('#txtTempFile_Eng').trigger('click');
                    }
                }
            }
        ],
        stylesheets: [
            "/Content/css/rbs_guide_style.css"
        ]
    });
}

function fnSetDatePicker(elemId) {
    $("#" + elemId).kendoDatePicker({
        format: "yyyy-MM-dd",
        dateInput: true
    });
}

function fnSetTimePicker(elemId) {
    $("#" + elemId).kendoTimePicker({
        format: "HH:mm",
        timeFormat: "HH:mm",
        dateInput: true
    });
}

function fnUploadImage(e, noNumber, isEng) {
    var file = e.target.files;
    if (file.length > 0) {
        var formData = new FormData();
        formData.append("id", currentId);
        formData.append("imageFile", file[0]);
        formData.append("noNumber", noNumber);
        formData.append("isEng", isEng);

        $.ajax({
            type: "POST",
            url: "../Service/" + currentService + "Service.asmx/UploadFile",
            data: formData,
            enctype: 'multipart/form-data',
            cache: false,
            processData: false,
            contentType: false,
            success: function (data) {
                if (data != null) {
                    if ($(data).find('string').text()) {
                        fnUploadIamgeCallBack($(data).find('string').text(), isEng);
                    }
                } else {
                    alert("이미지 파일 업로드 실패");
                }
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });
    }

    $('#txtTempFile').val("");
    $('#txtTempFile_Eng').val("");
}

function fnUploadFile(indexNumber) {
    var formData = new FormData();
    formData.append("id", indexNumber);
    formData.append("length", memberFile.length);
    formData.append("lastLength", lastFile.length);

    $(memberFile).each(function (i) {
        formData.append("attachFile_" + i, memberFile[i]);
    });

    $(lastFile).each(function (i) {
        formData.append("lastFile_" + i, lastFile[i]);
    });

    $.ajax({
        type: "POST",
        url: "../Service/" + currentService + "Service.asmx/UploadAttach",
        data: formData,
        enctype: 'multipart/form-data',
        cache: false,
        processData: false,
        contentType: false,
        success: function (data) {
            if (data != null) {
                if ($(data).find('string').text()) {
                    fnUploadFileCallBack($(data).find('string').text(), isEng);
                }
            } else {
                alert("첨부 파일 업로드 실패");
            }
        },
        error: function (request, status, error) {
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
}

function fnImageCopy(noNumber, isEng) {
    if (confirm((isEng == "T" ? "영문" : "한글") + " 화면에 작성 중이던 내용이 초기화 될 수 있습니다. 계속 진행하시겠습니까?")) {
        var copyParam = {
            id: currentId,
            noNumber: noNumber,
            isEng: isEng
        }

        $.ajax({
            type: "POST",
            url: "../Service/AnnouncementsService.asmx/CopyFile",
            data: JSON.stringify(copyParam),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                var beforeControl = (isEng == 'T' ? editor : editor_eng);
                var afterControl = (isEng == 'T' ? editor_eng : editor);
                var beforeFolderName = (isEng == 'T' ? '/kor/' : '/eng/');
                var afterFolderName = (isEng == 'T' ? '/eng/' : '/kor/');

                var $html = $('<div>' + beforeControl.value() + '</div>');
                $html.find('img').each(function () {
                    $(this).attr('src', $(this).attr('src').replace(beforeFolderName, afterFolderName));
                });

                afterControl.value($html.html());
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });
    }
}

function fnFormatFileSize(bytes, decimalPoint) {
    if (bytes == 0) return '0 Bytes';
    var k = 1000,
        dm = decimalPoint || 2,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
}