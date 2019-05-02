$(function() {
    
    //autocomplete
    $("#auto").autocomplete({
        source: "index.php?action=quelsModeles",
        minLength: 1
    });                

});