jQuery(document).ready(function($) {
  function init() {
    var users = [];
    $('#event_user_id > option').each(function(){
      var user = {};
      user.key = this.value;
      user.label = this.text;
      users.push(user);
    });
    
    var teams = scheduler.serverList("teams");

    scheduler.locale.labels.timeline_tab = "Timeline";
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
      y_unit: teams,
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

    scheduler.createUnitsView("unit", "unit_id", users);

    var config = {
      days:  [0, 6],
      zones: "fullday",
      css: "grey_section",
      type:"dhx_time_block"
    };

    scheduler.config.lightbox.sections = [
      {name:"description", height:50, map_to:"text", type:"textarea", focus:true},
      {name:"custom", height:23, type:"select", options:users, map_to:"unit_id" },
      {name:"time", height:72, type:"calendar_time", map_to:"auto" }
    ];

    scheduler.addMarkedTimespan(config);

    dhtmlxAjax.get("/teams.json", function(resp){
      var teams = JSON.parse(resp.xmlDoc.responseText);
      scheduler.updateCollection("teams", teams);
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