// JavaScript Document
function handleSelect(type,args,obj) {
    var dates = args[0];
    var date = dates[0];
    var year = date[0], month = date[1], day = date[2];

    var objIDArray = obj.id.split( '_' );
    var id = objIDArray[3];
    var datatype = objIDArray[1];
    var base = objIDArray[0];

    var txtYear = document.getElementsByName( base + '_' + datatype + '_year_' + id );
    txtYear[0].value = year;

    var txtMonth = document.getElementsByName( base + '_' + datatype + '_month_' + id );
    txtMonth[0].value = month;

    var txtDay = document.getElementsByName( base + '_' + datatype + '_day_' + id );
    txtDay[0].value = day;

    window['cal'+id].hide();
}

function showDatePicker( base, id, datatype ) {
    var calIconID = base + '_' + datatype + '_cal_' + id;
    var calContainerID = base + '_' + datatype + '_cal_container_' + id;
    var calContainer = document.getElementById( calContainerID );

    var xy = YAHOO.util.Dom.getXY( calIconID );

    calContainer.style.left = ( xy[0] + 26 ) + 'px';
    calContainer.style.top = ( xy[1] + 30 ) + 'px';
    calContainer.style.display = 'block';

    window['cal'+id] = new YAHOO.widget.Calendar( base + '_' + datatype + '_cal_' + id , calContainerID, { close: true, 
                                                                                              mindate: "1/1/1970",
                                                                                              LOCALE_WEEKDAYS: "medium",
                                                                                              start_weekday: 1} );

    // Correct formats for France: dd.mm.yyyy, dd.mm, mm.yyyy
    window['cal'+id].cfg.setProperty("DATE_FIELD_DELIMITER", ".");
     
    window['cal'+id].cfg.setProperty("MDY_DAY_POSITION", 1);
    window['cal'+id].cfg.setProperty("MDY_MONTH_POSITION", 2);
    window['cal'+id].cfg.setProperty("MDY_YEAR_POSITION", 3);
     
    window['cal'+id].cfg.setProperty("MD_DAY_POSITION", 1);
    window['cal'+id].cfg.setProperty("MD_MONTH_POSITION", 2);
     
    // Date labels for German locale
    window['cal'+id].cfg.setProperty("MONTHS_SHORT",   ["Jan", "Fev", "Mar", "Avr", "Mai", "Juin", "Jui", "Ao\u00FB", "Sep", "Oct", "Nov", "Dec"]);
    window['cal'+id].cfg.setProperty("MONTHS_LONG",    ["Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Ao\u00FBt", "Septembre", "Octobre", "Novembre", "Decembre"]);
    window['cal'+id].cfg.setProperty("WEEKDAYS_1CHAR", ["D", "L", "M", "M", "J", "V", "S"]);
    window['cal'+id].cfg.setProperty("WEEKDAYS_SHORT", ["Di", "Lu", "Ma", "Me", "Je", "Ve", "Sa"]);
    window['cal'+id].cfg.setProperty("WEEKDAYS_MEDIUM",["Dim", "Lun", "Mar", "Mer", "Jeu", "Ven", "Sam"]);
    window['cal'+id].cfg.setProperty("WEEKDAYS_LONG",  ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"]);
                                                                                              
    window['cal'+id].render();
    window['cal'+id].selectEvent.subscribe( handleSelect, window['cal'+id], true );
}