<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <jsp:include page="components/Header.jsp" />
        <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
        <title>Bidmod Cafe</title>
    </head>

    <body class="bg-[#EAF9F4]">
        <jsp:include page="components/NavBar.jsp" />
        <div class="container mx-auto mt-5">
            <div class="bg-white border-1 rounded-md p-6">
                <h1 class="flex-1 text-2xl text-[#005F3B] font-bold mb-5">Dashboard</h1>
                <div id="dashboard-label" class="mb-10 grid grid-cols-4 gap-4">
                </div>
                <div class="rounded-md mb-5 bg-gray-300 flex justify-center items-center border border-1 gap-5 py-2">
                    <div>
                        <label for="">แสดงรายปี</label>
                        <select id="select-year" class="border border-1 px-2 py-1 rounded-lg">
                            <option value="">เลือกปี</option>
                            <option value="2024">2024</option>
                            <option value="2023">2023</option>
                            <option value="2022">2022</option>
                            <option value="2021">2021</option>
                            <option value="2020">2020</option>
                            <option value="2019">2019</option>
                        </select>
                    </div>
                    <div>
                        <label for="">แสดงรายเดือน</label>
                        <select id="select-month" class="border border-1 px-2 py-1 rounded-lg">
                            <option value="">เลือกเดือน</option>
                            <option value="01">มกราคม</option>
                            <option value="02">กุมภาพันธ์</option>
                            <option value="03">มีนาคม</option>
                            <option value="04">เมษายน</option>
                            <option value="05">พฤษภาคม</option>
                            <option value="06">มิถุนายน</option>
                            <option value="07">กรกฎาคม</option>
                            <option value="08">สิงหาคม</option>
                            <option value="09">กันยายน</option>
                            <option value="10">ตุลาคม</option>
                            <option value="11">พฤศจิกายน</option>
                            <option value="12">ธันวาคม</option>
                        </select>
                    </div>
                    <button onclick="displayChart()"
                        class="bg-blue-500 px-3 py-2 rounded-lg text-white active:scale-90">แสดงผล</button>
                </div>
                <div class="flex flex-row gap-10">
                    <div class="w-[40%]">
                        <canvas id="pieChart"></canvas>
                        <div class="flex justify-center items-center">
                            <ul id="products-percentage" class="mt-10 flex flex-col gap-2">
                            </ul>
                        </div>
                    </div>

                    <div class="w-[60%] flex flex-col">
                        <div class="w-full">
                            <canvas id="barChart1"></canvas>
                        </div>
                        <div class="w-full">
                            <canvas id="barChart2"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            function getCurrentYearMonth() {
                const currentDate = new Date();
                const year = currentDate.getFullYear();
                const month = (currentDate.getMonth() + 1)
                const m = month < 10 ? "0" + month : month
                return { year, month: m };
            }
            async function displayChart() {
                console.log(getCurrentYearMonth());
                const yearValue = document.querySelector("#select-year").value
                const monthValue = document.querySelector("#select-month").value
                const { year: y, month: m } = getCurrentYearMonth()
                const year = yearValue ? yearValue : y
                const month = monthValue ? monthValue : m
                const res = await axios.get("http://localhost:4000/api/dashboard/" + year + "/" + month)
                const data = res.data
                const sellInDate = fillMissingDays(data.sellInDate);
                const revenueInMonth = fillMissingMonths(data.revenueInMonth);
                let innerHTML = ""
                data.productPercentage.forEach(element => {
                    innerHTML +=
                        '<li>' +
                        '    <span class="inline-block font-bold w-[200px]">' + element.productName + '</span><span class="inline-block">' + parseFloat(element.revenur).toFixed(2) + '</span>' +
                        '</li>'
                })
                document.querySelector("#products-percentage").innerHTML = innerHTML

                const pieData = {
                    labels: data.productPercentage.map(item => item.productName),
                    datasets: [{
                        label: 'Sale by menu',
                        data: data.productPercentage.map(item => item.revenur),
                        backgroundColor: data.productPercentage.map(item => getRandomColor()),
                        hoverOffset: 4
                    }]
                };
                const saleInDayData = {
                    labels: sellInDate.map(item => item.day),
                    datasets: [{
                        label: 'ยอดขายรายเดือน',
                        data: sellInDate.map(item => item.revenur),
                        backgroundColor: sellInDate.map(item => getRandomColor()),
                        borderWidth: 1,
                        hoverOffset: 4
                    }]
                }
                const revenueInMonthData = {
                    labels: revenueInMonth.map(item => item.month),
                    datasets: [{
                        label: 'ยอดขายรายวัน',
                        data: revenueInMonth.map(item => item.revenur),
                        backgroundColor: revenueInMonth.map(item => getRandomColor()),
                        borderWidth: 1,
                        hoverOffset: 4
                    }]
                }
                const pieConfig = {
                    type: 'pie',
                    data: pieData,
                };
                const saleInDayConf = {
                    type: "bar",
                    data: saleInDayData,
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                }
                const revenueInMonthConf = {
                    type: "bar",
                    data: revenueInMonthData,
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                }

                const pieChart = document.getElementById('pieChart');
                const barChart1 = document.getElementById('barChart1');
                const barChart2 = document.getElementById('barChart2');
                canVasPieChart.destroy()
                canVasBarChar1.destroy()
                canVasBarChar2.destroy()
                canVasPieChart = new Chart(pieChart, pieConfig)
                canVasBarChar1 = new Chart(barChart1, saleInDayConf)
                canVasBarChar2 = new Chart(barChart2, revenueInMonthConf)

                document.querySelector("#dashboard-label").innerHTML = ""
                document.querySelector("#dashboard-label").innerHTML =
                    '<div class="border border-1 p-3 rounded-lg">' +
                    '    <h1 class="font-bold text-lg">รายได้ทั้งหมด</h1>' +
                    '    <p>' + numberWithCommas(data.totalRevenue) + ' บาท</p>' +
                    '</div>' +
                    '<div class="border border-1 p-3 rounded-lg">' +
                    '    <h2 class="font-bold text-lg">ออเดอร์ทั้งหมด</h2>' +
                    '    <p>' + numberWithCommas(data.totalCountOrder) + ' ออเดอร์ </p>' +
                    '</div>' +
                    '<div class="border border-1 p-3 rounded-lg">' +
                    '    <h2 class="font-bold text-lg">ออเดอร์สั่งกลับบ้าน - ' + numberWithCommas(data.totalCountTakeHome) + ' ออเดอร์</h2>' +
                    '    <p>รวมราคา ' + numberWithCommas(data.totalTakeHomeRevenue) + ' บาท</p>' +
                    '</div>' +
                    '<div class="border border-1 p-3 rounded-lg">' +
                    '    <h2 class="font-bold text-lg">ออเดอร์ทานที่ร้าน - ' + numberWithCommas(data.totalCountTable) + ' ออเดอร์</h2>' +
                    '    <p>รวมราคา ' + numberWithCommas(data.totalTableRevenue) + ' บาท</p>' +
                    '</div>'

            }
            async function getData() {
                const res = await axios.get("http://localhost:4000/api/dashboard/2024/02")
                const data = res.data
                return data
            }
            function getRandomColor() {
                const r = Math.floor(Math.random() * 256);
                const g = Math.floor(Math.random() * 256);
                const b = Math.floor(Math.random() * 256);
                return 'rgb(' + r + ', ' + g + ', ' + b + ')';
            }
            function fillMissingDays(data) {
                const daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
                const filledData = [];

                for (const day of daysOfWeek) {
                    const existingEntry = data.find(item => item.day === day);
                    if (existingEntry) {
                        filledData.push(existingEntry);
                    } else {
                        filledData.push({ revenur: 0, day });
                    }
                }

                return data;
            }
            function numberWithCommas(x) {
                return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            }
            function fillMissingMonths(data) {
                const allMonths = [
                    "January", "February", "March", "April", "May", "June",
                    "July", "August", "September", "October", "November", "December"
                ];
                const filledData = [];

                for (const month of allMonths) {
                    const existingEntry = data.find(item => item.month === month);
                    if (existingEntry) {
                        filledData.push(existingEntry);
                    } else {
                        filledData.push({ revenur: 0, month });
                    }
                }

                return data;
            }
            (async () => {
                const data = await getData()
                const sellInDate = fillMissingDays(data.sellInDate);
                const revenueInMonth = fillMissingMonths(data.revenueInMonth);

                let innerHTML = ""
                data.productPercentage.forEach(element => {
                    innerHTML +=
                        '<li>' +
                        '    <span class="inline-block font-bold w-[200px]">' + element.productName + '</span><span class="inline-block">' + parseFloat(element.revenur).toFixed(2) + '</span>' +
                        '</li>'
                })
                document.querySelector("#products-percentage").innerHTML = innerHTML

                const pieData = {
                    labels: data.productPercentage.map(item => item.productName),
                    datasets: [{
                        label: 'Sale by menu',
                        data: data.productPercentage.map(item => item.revenur),
                        backgroundColor: data.productPercentage.map(item => getRandomColor()),
                        hoverOffset: 4
                    }]
                };
                const saleInDayData = {
                    labels: sellInDate.map(item => item.day),
                    datasets: [{
                        label: 'ยอดขายรายเดือน',
                        data: sellInDate.map(item => item.revenur),
                        backgroundColor: sellInDate.map(item => getRandomColor()),
                        borderWidth: 1,
                        hoverOffset: 4
                    }]
                }
                const revenueInMonthData = {
                    labels: revenueInMonth.map(item => item.month),
                    datasets: [{
                        label: 'ยอดขายรายวัน',
                        data: revenueInMonth.map(item => item.revenur),
                        backgroundColor: revenueInMonth.map(item => getRandomColor()),
                        borderWidth: 1,
                        hoverOffset: 4
                    }]
                }
                const pieConfig = {
                    type: 'pie',
                    data: pieData,
                };
                const saleInDayConf = {
                    type: "bar",
                    data: saleInDayData,
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                }
                const revenueInMonthConf = {
                    type: "bar",
                    data: revenueInMonthData,
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                }

                const pieChart = document.getElementById('pieChart');
                const barChart1 = document.getElementById('barChart1');
                const barChart2 = document.getElementById('barChart2');
                canVasPieChart = new Chart(pieChart, pieConfig)
                canVasBarChar1 = new Chart(barChart1, saleInDayConf)
                canVasBarChar2 = new Chart(barChart2, revenueInMonthConf)

                document.querySelector("#dashboard-label").innerHTML =
                    '<div class="border border-1 p-3 rounded-lg">' +
                    '    <h1 class="font-bold text-lg">รายได้ทั้งหมด</h1>' +
                    '    <p>' + numberWithCommas(data.totalRevenue) + ' บาท</p>' +
                    '</div>' +
                    '<div class="border border-1 p-3 rounded-lg">' +
                    '    <h2 class="font-bold text-lg">ออเดอร์ทั้งหมด</h2>' +
                    '    <p>' + numberWithCommas(data.totalCountOrder) + ' ออเดอร์ </p>' +
                    '</div>' +
                    '<div class="border border-1 p-3 rounded-lg">' +
                    '    <h2 class="font-bold text-lg">ออเดอร์สั่งกลับบ้าน - ' + numberWithCommas(data.totalCountTakeHome) + ' ออเดอร์</h2>' +
                    '    <p>รวมราคา ' + numberWithCommas(data.totalTakeHomeRevenue) + ' บาท</p>' +
                    '</div>' +
                    '<div class="border border-1 p-3 rounded-lg">' +
                    '    <h2 class="font-bold text-lg">ออเดอร์ทานที่ร้าน - ' + numberWithCommas(data.totalCountTable) + ' ออเดอร์</h2>' +
                    '    <p>รวมราคา ' + numberWithCommas(data.totalTableRevenue) + ' บาท</p>' +
                    '</div>'
            })();
        </script>


    </body>

    </html>