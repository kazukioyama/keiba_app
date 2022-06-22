import React, { useCallback, useState, useEffect } from "react"
import FullCalendar from '@fullcalendar/react';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from '@fullcalendar/list';
import axios from "axios";
import dayjs from 'dayjs';

const calendarComponent= ({
  props
}) => {

  const [targetDate, setTargetDate] = useState(new Date());
  const [events, setEvents] = useState([{ title: "3回 東京 3日目", date: '2022-06-21', color: 'green' }]);

  useEffect(() => {
    console.log(targetDate);
    fetchDailyRaceData();
  }, [targetDate]);

  const fetchDailyRaceData = useCallback(() => {
    const targetDateStr = dayjs(targetDate).format('YYYYMMDD');
    console.log('ab')
    // 土or日曜のみ実行
    if (targetDate.getDay() === 0 || targetDate.getDay() === 6) {
      axios
      .get(`/api/v1/scraping/daily_race_data/${targetDateStr}`)
      .then((res) => {
        console.log(res.data);
        setEvents([{ title: "取得できたお", date: '2022-06-19', color: 'green' }]);
      });
    } else {
      return;
    };
  }, [targetDate]);

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
          setTargetDate(info.start);
          console.log(info.start)
          console.log('a')
          // fetchDailyRaceData(targetDate);
          successCallback(events);
        }}
      />
    </div>
  )
};

export default calendarComponent;