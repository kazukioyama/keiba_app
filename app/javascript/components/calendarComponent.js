import React, { useCallback, useState, useEffect } from "react"
import FullCalendar from '@fullcalendar/react';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from '@fullcalendar/list';
import axios from "axios";
import dayjs from 'dayjs';

const calendarComponent= ({
  props
}) => {

  // const [targetDate, setTargetDate] = useState(new Date()); //setStateでinfo.startを入れるとなぜか無限ループエラーになってしまうので
  const [events, setEvents] = useState([{ title: "3回 東京 3日目", date: '2022-06-21', color: 'green' }]);
  let date;

  //setStateでinfo.startを入れるとなぜか無限ループエラーになってしまうのでコメントアウト
  // useEffect(() => {
  //   fetchDailyRaceData();
  // }, [date]);

  const fetchDailyRaceData = () => {
    const targetDateStr = dayjs(date).format('YYYYMMDD');
    // 土or日曜のみ実行
    if (date.getDay() === 0 || date.getDay() === 6) {
      axios
      .get(`/api/v1/scraping/daily_race_data/${targetDateStr}`)
      .then((res) => {
        console.log(res);
        setEvents([{ title: "取得できたお", date: '2022-06-19', color: 'green' }]);
      });
    } else {
      return
    };
  };

  return (
    <div class="calendar">
      <FullCalendar
        plugins={[dayGridPlugin, listPlugin]}
        initialView="listDay"
        locale="ja"
        headerToolbar={{
          center: 'prev next',
          end: 'today'
        }}
        events={(info, successCallback) => {
          // setTargetDate(info.start);
          date = info.start; //setStateでinfo.startを入れるとなぜか無限ループエラーになるので
          console.log(date);
          fetchDailyRaceData();
          successCallback(events);
        }}
      />
    </div>
  )
};

export default calendarComponent;