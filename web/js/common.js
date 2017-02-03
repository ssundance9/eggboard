jQuery(function($) {
    $.datepicker.setDefaults({
        dateFormat: "yy-mm-dd"
    });
});
function isEmpty(str) {
    if (str == undefined || str == "") {
        return true;
    } else {
        return false;
    }
}

function validateParam(obj, msg) {
    if (isEmpty(obj.val())) {
        alert(msg);
        obj.focus();
        
        return false;
    } else {
        return true;
    }
}