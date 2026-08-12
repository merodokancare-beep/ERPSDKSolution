
var GSTPayableAmt, GSTInputAmt, DirectPaymentDetailsAmt, ProjwiseDetailsAmt;
//var DirectPaymentWithExpData = [];
function GstPayableChart(DFrom, DateTo) {
    const GSTPayable = document.getElementById('gstpayablegraph');
    var baroptions = {
        url: '/Home/GSTPayableChart',
        data: { SDate: DFrom, EDate: DateTo },
        type: "GET", global: false,
        datatype: 'json',
    }
    $.ajax(baroptions).done(function (data) {
        //alert(data);
        var TIGST = data.TotalIGST, TCGST = data.TotalCGST, TSGST = data.TotalSGST;
        var options = {
            chart: {
                type: 'pie'
            },
            series: [TIGST, TCGST, TSGST],
            labels: ['Total IGST', 'Total CGST', 'Total SGST'],
            dataLabels: {
                enabled: true,
                formatter: function (val) {
                    return val.toFixed(1) + "%"
                },
            },
            plotOptions: {
                pie: {
                    expandOnClick: false
                }
            },
            //title: {
            //    text: "Total GST Payable For " + ,
            //    align: "center",
            //    style: {
            //        fontSize: "13px"
            //    }
            //},
            legend: {
                position: 'bottom'
            },
            fill: {
                opacity: 1,
            },
            theme: {
                palette: 'palette1' // upto palette10
            },
        }
        GSTPayable.innerHTML = "";
        GSTPayableAmt = new ApexCharts(GSTPayable, options);
        GSTPayableAmt.render();
    }).fail(function (xhr, textStatus, errorThrown) {
        toastr.error(errorThrown, 'Error');
    });
}
function GstInputChart(DFrom, DateTo) {
    const GSTInput = document.getElementById('gstinputgraph');
    var baroptions = {
        url: '/Home/GSTInputChart',
        data: { SDate: DFrom, EDate: DateTo },
        type: "GET", global: false,
        datatype: 'json',
    }
    $.ajax(baroptions).done(function (data) {
        //alert(data);
        var TIGST = data.TotalIGST, TCGST = data.TotalCGST, TSGST = data.TotalSGST;
        var options = {
            chart: {
                type: 'pie'
            },
            series: [TIGST, TCGST, TSGST],
            labels: ['Total IGST', 'Total CGST', 'Total SGST'],
            dataLabels: {
                enabled: true,
                formatter: function (val) {
                    return val.toFixed(1) + "%"
                },
            },
            plotOptions: {
                pie: {
                    expandOnClick: false
                }
            },

            legend: {
                position: 'bottom'
            },
            fill: {
                opacity: 1,
            },
            theme: {
                palette: 'palette1' // upto palette10
            },
        }
        GSTInput.innerHTML = "";
        GSTInputAmt = new ApexCharts(GSTInput, options);
        GSTInputAmt.render();
    }).fail(function (xhr, textStatus, errorThrown) {
        toastr.error(errorThrown, 'Error');
    });
}
function DirectPaymentChart(DFrom, DateTo) {
    const DirectPayment = document.getElementById('directpaymentgraph');
    var baroptions = {
        url: '/Home/DirectPaymentExp',
        data: { SDate: DFrom, EDate: DateTo },
        type: "GET", global: false,
        datatype: 'json',
    }
    $.ajax(baroptions).done(function (data) {
        var ExpHead = [], Received = [], Released = [];
        $.each(data, function (i, item) {
            ExpHead.push(item.ExpenseHead);
            Received.push(item.AmountReceived);
            Released.push(item.AmountReleased);
        });
        var options = {
            series: [{
                name: 'Amount Received',
                data: Received
            }, {
                name: 'Amount Released',
                data: Released
            }],
            chart: {
                type: 'bar',
                height: 380,
                toolbar: { show: false },
                background: 'transparent',
                foreColor: '#94A3B8',
            },
            theme: { mode: 'dark' },
            colors: ['#7539FF', '#10B981'],
            plotOptions: {
                bar: {
                    horizontal: false,
                    columnWidth: '55%',
                    borderRadius: 4,
                },
            },
            dataLabels: { enabled: false },
            stroke: { show: true, width: 2, colors: ['transparent'] },
            /* ── legend at TOP — away from rotated X-axis labels ── */
            legend: {
                position: 'top',
                horizontalAlign: 'right',
                labels: { colors: '#CBD5E1' },
                markers: { radius: 4 },
                fontSize: '12px',
            },
            xaxis: {
                categories: ExpHead,
                labels: {
                    rotate: -35,
                    rotateAlways: true,
                    maxHeight: 100,
                    trim: true,
                    style: { colors: '#94A3B8', fontSize: '11px' }
                },
            },
            yaxis: {
                title: { text: 'In Indian Rupees', style: { color: '#94A3B8' } },
                labels: { style: { colors: '#94A3B8' } }
            },
            grid: { borderColor: 'rgba(255,255,255,0.06)' },
            fill: { opacity: 1 },
            tooltip: {
                theme: 'dark',
                followCursor: false,
                y: { formatter: function (val) { return "Rs. " + val.toLocaleString('en-IN'); } }
            },
            responsive: [{
                breakpoint: 576,
                options: {
                    chart: { height: 320 },
                    xaxis: { labels: { rotate: -45, maxHeight: 80, style: { fontSize: '9px' } } },
                    legend: { fontSize: '10px' }
                }
            }]
        };
        DirectPayment.innerHTML = "";
        DirectPaymentDetailsAmt = new ApexCharts(DirectPayment, options);
        DirectPaymentDetailsAmt.render();
    }).fail(function (xhr, textStatus, errorThrown) {
        toastr.error(errorThrown, 'Error');
    });
}

function ProjwiseDetails(DFrom, DateTo) {
    const ProjectwiseChart = document.getElementById('projectwisegraph');
    var baroptions = {
        url: '/Home/ProjwiseDetails',
        data: { SDate: DFrom, EDate: DateTo },
        type: "GET", global: false,
        datatype: 'json',
    }
    $.ajax(baroptions).done(function (data) {
        var ProjName = [], ProjVal = [], PaymentReceived = [], Due = [];
        $.each(data, function (i, item) {
            ProjName.push(item.ProjectName);
            ProjVal.push(item.ProjCost);
            PaymentReceived.push(item.PaymentReceived);
            Due.push(item.DueAmt);
        });
        var options = {
            series: [{
                name: 'Project Value',
                data: ProjVal
            }, {
                name: 'Payment Received',
                data: PaymentReceived
            }, {
                name: 'Balance Amount',
                data: Due
            }],
            chart: {
                type: 'bar',
                height: 400,
                toolbar: { show: false },
                background: 'transparent',
                foreColor: '#94A3B8',
            },
            theme: { mode: 'dark' },
            colors: ['#008FFB', '#00E396', '#FEB019'],
            plotOptions: {
                bar: {
                    horizontal: false,
                    columnWidth: '60%',
                    borderRadius: 4,
                },
            },
            dataLabels: { enabled: false },
            stroke: { show: true, width: 2, colors: ['transparent'] },
            /* ── legend at TOP — no collision with X-axis labels ── */
            legend: {
                position: 'top',
                horizontalAlign: 'center',
                labels: { colors: '#CBD5E1' },
                markers: { radius: 4 },
                fontSize: '12px',
                /* extra top offset so legend doesn't crowd the chart title */
                offsetY: 4,
            },
            xaxis: {
                categories: ProjName,
                labels: {
                    rotate: -40,
                    rotateAlways: true,
                    /* trim long project names */
                    trim: true,
                    maxHeight: 120,
                    style: {
                        colors: '#94A3B8',
                        fontSize: '11px',
                    }
                },
                axisBorder: { color: 'rgba(255,255,255,0.1)' },
                axisTicks: { color: 'rgba(255,255,255,0.1)' },
            },
            yaxis: {
                title: {
                    text: 'In Indian Rupees',
                    style: { color: '#94A3B8', fontSize: '12px' }
                },
                labels: { style: { colors: '#94A3B8' } }
            },
            grid: { borderColor: 'rgba(255,255,255,0.06)' },
            fill: { opacity: 1 },
            tooltip: {
                theme: 'dark',
                y: {
                    formatter: function (val) {
                        return "Rs. " + val.toLocaleString('en-IN');
                    }
                }
            },
            /* ── Responsive: on mobile, use horizontal bars ── */
            responsive: [{
                breakpoint: 768,
                options: {
                    chart: {
                        height: 320,
                        type: 'bar',
                    },
                    plotOptions: {
                        bar: { horizontal: true, borderRadius: 3, columnWidth: '70%' }
                    },
                    xaxis: {
                        labels: { rotate: 0, style: { fontSize: '9px' } },
                        axisBorder: { show: false }
                    },
                    legend: { fontSize: '10px', offsetY: 0 }
                }
            }]
        };
        ProjectwiseChart.innerHTML = "";
        ProjwiseDetailsAmt = new ApexCharts(ProjectwiseChart, options);
        ProjwiseDetailsAmt.render();

    }).fail(function (xhr, textStatus, errorThrown) {
        toastr.error(errorThrown, 'Error');
    });
}