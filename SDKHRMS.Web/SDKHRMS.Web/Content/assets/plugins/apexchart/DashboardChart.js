var GSTPayableAmt, GSTInputAmt, DirectPaymentDetailsAmt, ProjwiseDetailsAmt;

function GstPayableChart(DFrom, DateTo) {
    const GSTPayable = document.getElementById('gstpayablegraph');
    if (!GSTPayable) return;
    var baroptions = {
        url: '/Home/GSTPayableChart',
        data: { SDate: DFrom, EDate: DateTo },
        type: "GET", global: false,
        datatype: 'json',
    }
    $.ajax(baroptions).done(function (data) {
        if (!data) return;
        var TIGST = data.TotalIGST ?? data.totalIGST ?? data.totalIgst ?? 0;
        var TCGST = data.TotalCGST ?? data.totalCGST ?? data.totalCgst ?? 0;
        var TSGST = data.TotalSGST ?? data.totalSGST ?? data.totalSgst ?? 0;
        var options = {
            chart: {
                type: 'pie'
            },
            series: [TIGST, TCGST, TSGST],
            labels: ['Total IGST', 'Total CGST', 'Total SGST'],
            dataLabels: {
                enabled: true,
                formatter: function (val) {
                    return val ? val.toFixed(1) + "%" : "0%";
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
                palette: 'palette1'
            },
        }
        GSTPayable.innerHTML = "";
        GSTPayableAmt = new ApexCharts(GSTPayable, options);
        GSTPayableAmt.render();
    }).fail(function (xhr, textStatus, errorThrown) {
        if (errorThrown) toastr.error(errorThrown, 'Error');
    });
}

function GstInputChart(DFrom, DateTo) {
    const GSTInput = document.getElementById('gstinputgraph');
    if (!GSTInput) return;
    var baroptions = {
        url: '/Home/GSTInputChart',
        data: { SDate: DFrom, EDate: DateTo },
        type: "GET", global: false,
        datatype: 'json',
    }
    $.ajax(baroptions).done(function (data) {
        if (!data) return;
        var TIGST = data.TotalIGST ?? data.totalIGST ?? data.totalIgst ?? 0;
        var TCGST = data.TotalCGST ?? data.totalCGST ?? data.totalCgst ?? 0;
        var TSGST = data.TotalSGST ?? data.totalSGST ?? data.totalSgst ?? 0;
        var options = {
            chart: {
                type: 'pie'
            },
            series: [TIGST, TCGST, TSGST],
            labels: ['Total IGST', 'Total CGST', 'Total SGST'],
            dataLabels: {
                enabled: true,
                formatter: function (val) {
                    return val ? val.toFixed(1) + "%" : "0%";
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
                palette: 'palette1'
            },
        }
        GSTInput.innerHTML = "";
        GSTInputAmt = new ApexCharts(GSTInput, options);
        GSTInputAmt.render();
    }).fail(function (xhr, textStatus, errorThrown) {
        if (errorThrown) toastr.error(errorThrown, 'Error');
    });
}

function DirectPaymentChart(DFrom, DateTo) {
    const DirectPayment = document.getElementById('directpaymentgraph');
    if (!DirectPayment) return;
    var baroptions = {
        url: '/Home/DirectPaymentExp',
        data: { SDate: DFrom, EDate: DateTo },
        type: "GET", global: false,
        datatype: 'json',
    }
    $.ajax(baroptions).done(function (data) {
        var ExpHead = [], Received = [], Released = [];
        if (data && data.length > 0) {
            $.each(data, function (i, item) {
                ExpHead.push(item.ExpenseHead ?? item.expenseHead ?? '');
                Received.push(item.AmountReceived ?? item.amountReceived ?? 0);
                Released.push(item.AmountReleased ?? item.amountReleased ?? 0);
            });
        }
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
                y: { formatter: function (val) { return "Rs. " + (val ? val.toLocaleString('en-IN') : "0"); } }
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
        if (errorThrown) toastr.error(errorThrown, 'Error');
    });
}

function ProjwiseDetails(DFrom, DateTo) {
    const ProjectwiseChart = document.getElementById('projectwisegraph');
    if (!ProjectwiseChart) return;
    var baroptions = {
        url: '/Home/ProjwiseDetails',
        data: { SDate: DFrom, EDate: DateTo },
        type: "GET", global: false,
        datatype: 'json',
    }
    $.ajax(baroptions).done(function (data) {
        var ProjName = [], ProjVal = [], PaymentReceived = [], Due = [];
        if (data && data.length > 0) {
            $.each(data, function (i, item) {
                ProjName.push(item.ProjectName ?? item.projectName ?? '');
                ProjVal.push(item.ProjCost ?? item.projCost ?? 0);
                PaymentReceived.push(item.PaymentReceived ?? item.paymentReceived ?? 0);
                Due.push(item.DueAmt ?? item.dueAmt ?? 0);
            });
        }
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
            legend: {
                position: 'top',
                horizontalAlign: 'center',
                labels: { colors: '#CBD5E1' },
                markers: { radius: 4 },
                fontSize: '12px',
                offsetY: 4,
            },
            xaxis: {
                categories: ProjName,
                labels: {
                    rotate: -40,
                    rotateAlways: true,
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
                        return "Rs. " + (val ? val.toLocaleString('en-IN') : "0");
                    }
                }
            },
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
        if (errorThrown) toastr.error(errorThrown, 'Error');
    });
}