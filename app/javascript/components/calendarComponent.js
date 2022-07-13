import React, { useCallback, useState, useEffect } from "react"
import FullCalendar from '@fullcalendar/react';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from '@fullcalendar/list';
import axios from "axios";
import dayjs from 'dayjs';

const calendarComponent= ({
  props
}) => {
  const [isLoading, setIsLoading] = useState(false);

  // const fetchDailyRaceData = useCallback((startDate) => {
  //   const targetDateStr = dayjs(startDate).format('YYYYMMDD');
  //   // 土or日曜のみ実行
  //   if (startDate.getDay() === 0 || startDate.getDay() === 6) {
  //     axios
  //     .get(`/api/v1/scraping/daily_race_data/${targetDateStr}`)
  //     .then((res) => {
  //       console.log(res.data);
  //       setEvents([{ title: "取得できたお", date: '2022-06-19', color: 'green' }]);
  //       return [{ title: "取得できたお", date: '2022-06-19', color: 'green' }];
  //       // setIsFirstFetch(false);
  //     });
  //   } else {
  //     // setEvents([{ title: "取得できたお", date: '2022-06-19', color: 'green' }]);
  //     setIsFirstFetch(false);
  //     return [];
  //   };
  // }, [targetDate]);

  return (
    <div className="calendar">
      <FullCalendar
        plugins={[dayGridPlugin, listPlugin]}
        initialView="listDay"
        locale="ja"
        headerToolbar={{
          center: 'prev next',
          end: 'today'
        }}
        // titleFormat={(date) => {
        //   console.log(date)
        // }}
        noEventsContent={'レース未開催日'}
        events={(info, successCallback) => {
          console.log(info.start)
          const startDate = info.start;
          // 土or日曜のみ実行
          if (startDate.getDay() === 0 || startDate.getDay() === 6) {
            // setIsLoading(true);
            axios
            .get(`/api/v1/scraping/daily_race_data_for_fullcalendar/${dayjs(startDate).format('YYYYMMDD')}`)
            .then((res) => {
              console.log(res.data);
              // setIsLoading(false);
              successCallback(res.data);
            })
            .catch((error) => {
              alert(error);
            });
          };
        }}
        eventClick={(e) => {
          window.open(`https://race.netkeiba.com/race/shutuba.html?race_id=${e.event.extendedProps.raceId}&rf=race_list`);
        }}
        // eventMouseEnter={(info) => {
        //   console.log(info.event.title)
        // }}
      />
    </div>
  )
};

export default calendarComponent;