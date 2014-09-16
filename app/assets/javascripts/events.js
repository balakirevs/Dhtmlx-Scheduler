jQuery(document).ready(function($) {
  function init() {
        
    var users = scheduler.serverList("users");
    var teams = scheduler.serverList("teams");
    var groups = scheduler.serverList("groups");

    scheduler.locale.labels.timeline_tab = "Timeline";
    scheduler.locale.labels.timeline2_tab = "Timeline 2";
    scheduler.locale.labels.unit_tab = "Unit";
    scheduler.config.multisection = true;
    scheduler.config.details_on_create = true;
    scheduler.config.details_on_dblclick = true;
    scheduler.config.xml_date = "%Y-%m-%d %H:%i";
    scheduler.config.multi_day = true;

    scheduler.createTimelineView({
      name:  'timeline',
      section_autoheight: false,
      x_unit: 'hour',
      x_date: '%A',
      x_step: 12,
      x_size: 62,
      x_length: 62,
      folder_dy:20,
      dy:30,
      dx: 150,
      y_unit: groups,
      y_property: 'unit_id',
      render: 'tree',
      round_position: true,
      second_scale: {
        x_unit: 'day',
        x_date: "%j",
        x_step:  1,
        x_size: 62,
        x_start: 0,
        x_length: 62
      }
    });

    scheduler.createTimelineView({
      name: 'timeline2',
      section_autoheight: false,
      x_unit: 'day',
      x_date: "%j",
      //x_step: 12, // 12 - 2columns(AM/PM); 8 - 3 columns
      x_size: 31,
      x_length: 31,
      folder_dy:20,
      dy:30,
      dx: 150,
      y_unit: teams,
      y_property: 'section_id',
      render: 'tree',
      round_position: true
    });

    scheduler.createUnitsView("unit", "unit_id", users);

    var config = {
      days:  [0, 6],
      zones: "fullday",
      css: "grey_section",
      type:"dhx_time_block"
    };

    scheduler.config.lightbox.sections = [
      {name:"description", height:50, map_to:"text", type:"textarea", focus:true},
      {name:"Team Members", height:23, type:"select", options:users, map_to:"unit_id" },
      {name:"time", height:72, type:"calendar_time", map_to:"auto" }
    ];

    scheduler.addMarkedTimespan(config);

    dhtmlxAjax.get("/teams.json", function(resp){
      var teams = JSON.parse(resp.xmlDoc.responseText);
      scheduler.updateCollection("teams", teams);
    });

    dhtmlxAjax.get("/groups.json", function(resp){
      var groups = JSON.parse(resp.xmlDoc.responseText);
      scheduler.updateCollection("groups", groups);
    });

    dhtmlxAjax.get("/users.json", function(resp){
      var users = JSON.parse(resp.xmlDoc.responseText);
      scheduler.updateCollection("users", users);
    });

    scheduler.init('scheduler_here', new Date(), "unit");
    scheduler.load("/events.json", 'json');
    var dp = new dataProcessor("/events/save");
      dp.init(scheduler);
      dp.setTransactionMode("POST",false);
  }

  init();
});

function show_minical(){
  if (scheduler.isCalendarVisible()){
    scheduler.destroyCalendar();
  } else {
      scheduler.renderCalendar({
        position:"dhx_minical_icon",
        date:scheduler._date,
        navigation:true,
        handler:function(date,calendar){
          scheduler.setCurrentView(date);
          scheduler.destroyCalendar();
        }
      });
  }
}