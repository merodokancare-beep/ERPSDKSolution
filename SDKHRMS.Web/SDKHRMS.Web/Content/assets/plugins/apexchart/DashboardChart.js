// Modern ERP Dashboard Chart Renderer (Dynamic Financial Year Data Support)

function renderGSTAnnualDonut() {
    var chartElem = document.getElementById('gstAnnualDonutChart');
    if (!chartElem) return;
    if (typeof ApexCharts === 'undefined') return;

    var cgst = parseFloat(chartElem.getAttribute('data-cgst')) || 1228394;
    var sgst = parseFloat(chartElem.getAttribute('data-sgst')) || 1228394;
    var igst = parseFloat(chartElem.getAttribute('data-igst')) || 3214568;
    var cess = parseFloat(chartElem.getAttribute('data-cess')) || 405184;

    var options = {
        series: [cgst, sgst, igst, cess],
        labels: ['CGST', 'SGST', 'IGST', 'CESS'],
        chart: {
            type: 'donut',
            height: 220,
            sparkline: { enabled: false }
        },
        colors: ['#0284c7', '#10b981', '#f59e0b', '#a855f7'],
        dataLabels: { enabled: false },
        legend: { show: false },
        plotOptions: {
            pie: {
                donut: {
                    size: '72%',
                    labels: { show: false }
                }
            }
        },
        stroke: { width: 2 }
    };

    chartElem.innerHTML = "";
    var chart = new ApexCharts(chartElem, options);
    chart.render();
}

function renderIncomeVsExpensesChart(sdate, edate) {
    var chartElem = document.getElementById('incomeexpensegraph');
    if (!chartElem) return;
    if (typeof ApexCharts === 'undefined') return;

    var drawChart = function (res) {
        res = res || {};
        var options = {
            series: [{
                name: 'Income (₹)',
                data: res.income || [32, 28, 35, 30, 26, 38, 31, 29, 34, 25, 27, 33]
            }, {
                name: 'Expense (₹)',
                data: res.expense || [22, 19, 24, 21, 18, 26, 20, 19, 23, 17, 18, 22]
            }, {
                name: 'Profit (₹)',
                data: res.profit || [10, 9, 11, 9, 8, 12, 11, 10, 11, 8, 9, 11]
            }],
            chart: {
                type: 'bar',
                height: 270,
                toolbar: { show: false }
            },
            colors: ['#0284c7', '#10b981', '#f59e0b'],
            plotOptions: {
                bar: {
                    horizontal: false,
                    columnWidth: '50%',
                    borderRadius: 3
                }
            },
            dataLabels: { enabled: false },
            stroke: { show: true, width: 2, colors: ['transparent'] },
            xaxis: {
                categories: res.months || ['Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar'],
                labels: { style: { fontSize: '11px' } }
            },
            yaxis: {
                labels: {
                    formatter: function (val) {
                        return val + "L";
                    },
                    style: { fontSize: '11px' }
                }
            },
            legend: { show: false },
            grid: {
                borderColor: 'rgba(0,0,0,0.05)',
                strokeDashArray: 4
            }
        };

        chartElem.innerHTML = "";
        var chart = new ApexCharts(chartElem, options);
        chart.render();
    };

    var targetUrl = typeof resolveUrl === 'function' ? resolveUrl('/Home/GetIncomeVsExpensesData') : '/Home/GetIncomeVsExpensesData';
    $.ajax({
        type: 'GET',
        url: targetUrl,
        data: { SDate: sdate, EDate: edate },
        success: function (res) {
            drawChart(res);
        },
        error: function () {
            drawChart(null);
        }
    });
}

function renderAgingCharts(sdate, edate) {
    var recElem = document.getElementById('receivablesDonutChart');
    var payElem = document.getElementById('payablesDonutChart');
    if (typeof ApexCharts === 'undefined') return;

    var drawAging = function (res) {
        res = res || {};
        if (recElem) {
            var recOptions = {
                series: [res.Rec_0_30_Per || 45, res.Rec_31_60_Per || 31, res.Rec_61_90_Per || 14, res.Rec_90_Plus_Per || 10],
                labels: ['0-30 Days', '31-60 Days', '61-90 Days', '>90 Days'],
                chart: { type: 'donut', height: 120 },
                colors: ['#0284c7', '#10b981', '#f59e0b', '#ef4444'],
                dataLabels: { enabled: false },
                legend: { show: false },
                plotOptions: { pie: { donut: { size: '68%' } } },
                stroke: { width: 1 }
            };
            recElem.innerHTML = "";
            new ApexCharts(recElem, recOptions).render();
        }

        if (payElem) {
            var payOptions = {
                series: [res.Pay_0_30_Per || 49, res.Pay_31_60_Per || 28, res.Pay_61_90_Per || 14, res.Pay_90_Plus_Per || 9],
                labels: ['0-30 Days', '31-60 Days', '61-90 Days', '>90 Days'],
                chart: { type: 'donut', height: 120 },
                colors: ['#8b5cf6', '#3b82f6', '#f59e0b', '#ef4444'],
                dataLabels: { enabled: false },
                legend: { show: false },
                plotOptions: { pie: { donut: { size: '68%' } } },
                stroke: { width: 1 }
            };
            payElem.innerHTML = "";
            new ApexCharts(payElem, payOptions).render();
        }
    };

    var targetUrl = typeof resolveUrl === 'function' ? resolveUrl('/Home/GetReceivablesPayablesAging') : '/Home/GetReceivablesPayablesAging';
    $.ajax({
        type: 'GET',
        url: targetUrl,
        data: { SDate: sdate, EDate: edate },
        success: function (res) {
            drawAging(res);
        },
        error: function () {
            drawAging(null);
        }
    });
}