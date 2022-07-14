import React, { useCallback, useState, useEffect } from "react"
import FullCalendar from '@fullcalendar/react';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from '@fullcalendar/list';
import axios from "axios";
import dayjs from 'dayjs';
import 'dayjs/locale/ja';
dayjs.locale('ja');

const calendarComponent= ({
  props
}) => {
  // const [isLoading, setIsLoading] = useState(false);

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
        titleFormat= {(info) => {
          return dayjs(info.date.marker).format('YYYY年M月DD日(ddd)');
        }}
        noEventsContent={''}
        events={(info, successCallback) => {
          console.log(info.start)
          const startDate = info.start;
          // 土or日曜のみ実行
          if (startDate.getDay() === 0 || startDate.getDay() === 6) {
            // setIsLoading(true);
            alert('fetchng...');
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
          } else {
            alert('対象日はレース未開催日です');
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