import Chart from "chart.js";
const $ = require("jquery")

document.addEventListener("turbolinks:load", function(){
    var pathname = window.location.pathname;
    console.log(pathname)
    if(/month_simulations\/\d/.test(pathname) ){
        getData(pathname)
    }
});

function getData(pathname) {
    $.get(pathname + ".json", function(data, status){
        drawChart(data)
    });
}

function drawChart(data) {
    let months = new Array()
    let reports = new Array()
    data['months'].forEach(month => {
        months.push(month['month'])
    } )

    let datasets = new Array()
    data['reports'].forEach(report => {
        datasets.push(
            {
                label: report['report_id'],
                data: report['performances'].map( p => p['total_asset'] ),
                backgroundColor:'rgba(255, 255, 255, 0)',
                borderColor: 'rgba(255, 190, 11, 1)',
                lineTension: 0,
                borderWidth: 1
            }
        )
    } )

    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: data['months'].map(month => month['month']  ),
            datasets: datasets
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });
}
