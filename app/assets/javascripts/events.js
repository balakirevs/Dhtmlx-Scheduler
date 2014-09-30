jQuery(document).ready(function($) {
  function init() {
        
    var users = scheduler.serverList("users");
    var teams = scheduler.serverList("teams");
    var groups = scheduler.serverList("groups");
    var mates = scheduler.serverList("mates");
    var members = scheduler.serverList("members");

    scheduler.locale.labels.timeline_tab = "Timeline";
    scheduler.locale.labels.timeline2_tab = "Timeline 2";
    scheduler.locale.labels.team_tab = "Team";
    scheduler.locale.labels.group_tab = "Group";
    scheduler.locale.labels.unit_tab = "Unit";
    scheduler.locale.labels.section_selectme = "Events";
    scheduler.config.multisection = true;
    scheduler.config.details_on_create = true;
    scheduler.config.details_on_dblclick = true;
    scheduler.templates.tooltip_date_format = scheduler.date.date_to_str("%Y-%m-%d %H:%i");
    scheduler.config.xml_date = "%Y-%m-%d %H:%i";
    scheduler.config.multi_day = true;
    //scheduler.config.quick_info_detached = true;

    scheduler.templates.event_class=function(start, end, event){
      var css = "";
      if(event.text)
        css += "event_"+event.text;
      if(event.id == scheduler.getState().select_id){
        css += " selected";
      }
      return css;
    };
    
    var events = [
      { key: 1, label: 'O' },
      { key: 2, label: 'C' },
      { key: 3, label: 'R' },
      { key: 4, label: 'S' },
      { key: 5, label: 'V' },
      { key: 6, label: 'Holiday' }
    ];

    scheduler.createTimelineView({
      name:  'group',
      section_autoheight: false,
      x_unit: 'hour',
      x_date: '%A',
      x_step: 12,
      x_size: 62,
      x_length: 62,
      folder_dy:20,
      dy:30,
      dx: 150,
      y_unit: members,
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
      name: 'team',
      section_autoheight: false,
      x_unit: 'day',
      x_date: "%j",
      //x_step: 12, // 12 - 2columns(AM/PM); 8 - 3 columns
      x_size: 31,
      x_length: 31,
      folder_dy:20,
      dy:30,
      dx: 150,
      y_unit: mates,
      y_property: 'section_id',
      render: 'tree',
      round_position: true
    });
    
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

    scheduler.addMarkedTimespan(config);
    
    scheduler.attachEvent("onEventLoading", function(ev){
      if (ev.start_date.getHours() >= 12)
        ev.work_id = "Am";
      else
        ev.work_id = "Pm";
      return true;
    });

    scheduler.config.lightbox.sections = [
      {name:"description", height:50, map_to:"text", type:"textarea", focus:true},
      {name:"Team Members", height:23, type:"select", options:users, map_to:"unit_id" },
      { name:"selectme", height: 58, options: events, map_to:"radiobutton_option", type:"radio" },
      {name:"time", height:72, type:"calendar_time", map_to:"auto" }
    ];

    dhtmlxAjax.get("/teams.json", function(resp){
      var teams = JSON.parse(resp.xmlDoc.responseText);
      scheduler.updateCollection("teams", teams);
    });

    dhtmlxAjax.get("/groups.json", function(resp){
      var groups = JSON.parse(resp.xmlDoc.responseText);
      scheduler.updateCollection("groups", groups);
    });

    dhtmlxAjax.get("/mates.json", function(resp){
      var mates = JSON.parse(resp.xmlDoc.responseText);
      scheduler.updateCollection("mates", mates);
    });

    dhtmlxAjax.get("/members.json", function(resp){
      var members = JSON.parse(resp.xmlDoc.responseText);
      scheduler.updateCollection("members", members);
    });

    dhtmlxAjax.get("/users.json", function(resp){
      var users = JSON.parse(resp.xmlDoc.responseText);
      scheduler.updateCollection("users", users);
    });

    scheduler.init('scheduler_here', new Date(), "month");
    scheduler.load("/events.json", 'json');
    var dp = new dataProcessor("/events/save");
      dp.init(scheduler);
      dp.setTransactionMode("POST",false);

    for(var i = 0; i < holidays.length; i++){
      scheduler.blockTime(new Date(holidays[i].date), "fullday");
    }
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