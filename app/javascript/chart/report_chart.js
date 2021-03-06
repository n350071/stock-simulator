import Chart from "chart.js";
const $ = require("jquery")

document.addEventListener("turbolinks:load", function(){
    var pathname = window.location.pathname;
    if(/reports/.test(pathname) ){
        getData(pathname)
    }
});

function getData(pathname) {
    $.get(pathname + ".json", function(data, status){
        drawChart(data['performances'])
    });
}

function drawChart(performances) {
    let months = new Array()
    let total_assets = new Array()
    let cashes = new Array()
    let buys = new Array()
    let sells = new Array()
    let total_badgets = new Array()
    let ticker_counts = new Array()
    let total_ratios = new Array()
    performances.forEach(performance => {
        months.push(performance['month'])
        total_assets.push(performance['total_asset'])
        total_badgets.push((performance['total_badget']))
        cashes.push(performance['cash'])
        buys.push(performance['buy'])
        sells.push(performance['sell'])
        ticker_counts.push(performance['ticker_count'])
        if(performance['total_badget']){
            total_ratios.push(performance['total_asset']/performance['total_badget'])
        }
    } )

    var ctx = document.getElementById('myChart').getContext('2d');
    var ctx_ticker_counts = document.getElementById('tickerCounts').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: months,
            datasets: [{
                label: '総資産',
                data: total_assets,
                backgroundColor:'rgba(255, 255, 255, 0)',
                borderColor: 'rgba(255, 190, 11, 1)',
                lineTension: 0,
                borderWidth: 1
            },{
                label: '累積投入予算',
                data: total_badgets,
                backgroundColor:'rgba(255, 2255, 255, 0)',
                borderColor: 'rgba(58, 134, 255, 1)',
                lineTension: 0,
                borderWidth: 1
            }
        ]
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
    new Chart(ctx_ticker_counts, {
        type: 'line',
        data: {
            labels: months,
            datasets: [{
                label: '銘柄数',
                data: ticker_counts,
                backgroundColor:'rgba(255, 2255, 255, 0)',
                borderColor: 'rgba(251, 86, 7, 1)',
                lineTension: 0,
                borderWidth: 1
            },{
                label: '総資産／投入予算',
                data: total_ratios,
                backgroundColor:'rgba(255, 2255, 255, 0)',
                borderColor: 'rgba(131, 56, 236, 1)',
                lineTension: 0,
                borderWidth: 1
            }
        ]
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
