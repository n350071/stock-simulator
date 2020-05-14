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
    let ticker_counts = new Array()
    performances.forEach(performance => {
        months.push(performance['month'])
        total_assets.push(performance['total_asset'])
        cashes.push(performance['cash'])
        buys.push(performance['buy'])
        sells.push(performance['sell'])
        ticker_counts.push(performance['ticker_count'])
    } )

    var ctx = document.getElementById('myChart').getContext('2d');
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
                label: '売却額',
                data: sells,
                backgroundColor:'rgba(255, 2255, 255, 0)',
                borderColor: 'rgba(58, 134, 255, 1)',
                lineTension: 0,
                borderWidth: 1
            },{
                label: '購入額',
                data: buys,
                backgroundColor:'rgba(255, 2255, 255, 0)',
                borderColor: 'rgba(131, 56, 236, 1)',
                lineTension: 0,
                borderWidth: 1
            }
            ,{
                label: '銘柄数',
                data: ticker_counts,
                backgroundColor:'rgba(255, 2255, 255, 0)',
                borderColor: 'rgba(251, 86, 7, 1)',
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
