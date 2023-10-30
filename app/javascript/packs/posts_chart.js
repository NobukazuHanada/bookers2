import {Chart} from "chart.js/auto";

function setDataToPostChart(per_day_posts) {
    const postChartElm = document.getElementById("post-chart");
    const labels = per_day_posts.map((_post, index) => index === 0 ? "本日" : index === 1 ? "前日" : `${index}日前`);
    new Chart(
        postChartElm,
        {
            type: 'bar',
            data: {
                labels: labels.reverse(),
                datasets: [{
                    label: '投稿数',
                    data: per_day_posts.reverse()
                }]
            }
        }
    )

}

window.setDataToPostChart = setDataToPostChart;