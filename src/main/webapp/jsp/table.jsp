<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <jsp:include page="components/Header.jsp" />
        <title>Bidmod Cafe</title>
        <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/daisyui@4.7.2/dist/full.min.css" rel="stylesheet" type="text/css" />
        <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body class="bg-[#EAF9F4] h-[100vh]">
        <jsp:include page="components/NavBar.jsp" />
        <div class="container mx-auto mt-5">
            <div class="flex flex-row gap-3 justify-between items-center">
                <h1 class="flex-1 text-2xl text-[#005F3B] font-bold mb-3">Select Table</h1>
                <button onclick="openDelete()" class="mb-2 active:scale-90">
                    <div class="w-8 h-8 flex justify-center items-center text-white bg-black p-1 rounded-full">
                        <svg xmlns="http://www.w3.org/2000/svg" width="4em" height="4em" viewBox="0 0 1024 1024"><path fill="currentColor" d="M512.5 390.6c-29.9 0-57.9 11.6-79.1 32.8c-21.1 21.2-32.8 49.2-32.8 79.1c0 29.9 11.7 57.9 32.8 79.1c21.2 21.1 49.2 32.8 79.1 32.8c29.9 0 57.9-11.7 79.1-32.8c21.1-21.2 32.8-49.2 32.8-79.1c0-29.9-11.7-57.9-32.8-79.1a110.96 110.96 0 0 0-79.1-32.8m412.3 235.5l-65.4-55.9c3.1-19 4.7-38.4 4.7-57.7s-1.6-38.8-4.7-57.7l65.4-55.9a32.03 32.03 0 0 0 9.3-35.2l-.9-2.6a442.5 442.5 0 0 0-79.6-137.7l-1.8-2.1a32.12 32.12 0 0 0-35.1-9.5l-81.2 28.9c-30-24.6-63.4-44-99.6-57.5l-15.7-84.9a32.05 32.05 0 0 0-25.8-25.7l-2.7-.5c-52-9.4-106.8-9.4-158.8 0l-2.7.5a32.05 32.05 0 0 0-25.8 25.7l-15.8 85.3a353.44 353.44 0 0 0-98.9 57.3l-81.8-29.1a32 32 0 0 0-35.1 9.5l-1.8 2.1a445.93 445.93 0 0 0-79.6 137.7l-.9 2.6c-4.5 12.5-.8 26.5 9.3 35.2l66.2 56.5c-3.1 18.8-4.6 38-4.6 57c0 19.2 1.5 38.4 4.6 57l-66 56.5a32.03 32.03 0 0 0-9.3 35.2l.9 2.6c18.1 50.3 44.8 96.8 79.6 137.7l1.8 2.1a32.12 32.12 0 0 0 35.1 9.5l81.8-29.1c29.8 24.5 63 43.9 98.9 57.3l15.8 85.3a32.05 32.05 0 0 0 25.8 25.7l2.7.5a448.27 448.27 0 0 0 158.8 0l2.7-.5a32.05 32.05 0 0 0 25.8-25.7l15.7-84.9c36.2-13.6 69.6-32.9 99.6-57.5l81.2 28.9a32 32 0 0 0 35.1-9.5l1.8-2.1c34.8-41.1 61.5-87.4 79.6-137.7l.9-2.6c4.3-12.4.6-26.3-9.5-35m-412.3 52.2c-97.1 0-175.8-78.7-175.8-175.8s78.7-175.8 175.8-175.8s175.8 78.7 175.8 175.8s-78.7 175.8-175.8 175.8"/></svg>                      
                    </div>
                </button>
            </div>
            <div class="bg-white border-1 rounded-md p-4 h-[75vh] overflow-y-scroll">
                <ul id="table-list" class="grid grid-cols-5 gap-4">
                </ul>
            </div>
        </div>
    </body>
    <script>
        function openDelete() {
            document.querySelectorAll(".deleteBtn").forEach(btn => {
                if (btn.classList.contains("hidden")) {
                    btn.classList.remove("hidden");
                } else {
                    btn.classList.add("hidden");
                }
            });
        }
        async function deleteTable(tid){
            try{
                const res = await axios.delete("http://localhost:4000/api/tables/"+tid)
                const data = res.data
                console.log(data);
            }catch(err){
                console.log(err);
            }finally{
                tables = await getTables()
                updateTable()
            }
        }
        async function getTables() {
            const res = await axios.get("http://localhost:4000/api/tables")
            const tables = res.data
            return tables
        }
        function updateTable(){
            let innerTableList = 
                '<li>' +
                    '<button id="addTableBtn" class="w-full h-full block flex flex-row gap-4 bg-slate-100 border border-1 border-slate-200 p-4 px-7 rounded-[1em] justify-center items-center">' +
                        '<div class="w-7 h-7">' +
                            '<svg data-slot="icon" fill="none" stroke-width="1.5" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15"></path></svg>' +
                        '</div>' +
                    '</button>' +
                ' </li>'
            let c = 0
            tables.forEach(table => {
                const tableStatus = table?.status ? "โต๊ะเต็ม" : "โต๊ะว่าง"
                const statusColor = table?.status ? "red" : "green"
                const isDisabled =  table?.status ? "disabled" : ""
                innerTableList += 
                '<li>' +
                    '<div class="relative w-full block">' +
                        '<button '+ isDisabled +' onclick="deleteTable('+ table.tableId +')" class="hidden deleteBtn z-50 absolute top-[-4%] right-[-3%] w-6 h-6 bg-red-500 text-white p-1 rounded-full flex justify-center items-center"><svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 40 40"><path fill="currentColor" d="M21.499 19.994L32.755 8.727a1.064 1.064 0 0 0-.001-1.502c-.398-.396-1.099-.398-1.501.002L20 18.494L8.743 7.224c-.4-.395-1.101-.393-1.499.002a1.05 1.05 0 0 0-.309.751c0 .284.11.55.309.747L18.5 19.993L7.245 31.263a1.064 1.064 0 0 0 .003 1.503c.193.191.466.301.748.301h.006c.283-.001.556-.112.745-.305L20 21.495l11.257 11.27c.199.198.465.308.747.308a1.058 1.058 0 0 0 1.061-1.061c0-.283-.11-.55-.31-.747z"/></svg></button>' +
                        '<button '+ isDisabled +' onclick="selectTable(' + table.tableId + ')" class="w-full flex flex-row gap-4 bg-slate-100 border border-1 border-slate-200 p-4 px-7 rounded-[1em] justify-between items-center">'+
                            '<div class="flex flex-col justify-center items-center text-black text-2xl font-bold">' +
                                '<span>Table</span>' +
                                '<span>'+ ++c +'</span>' +
                            '</div>' +
                            '<div class="flex flex-col items-start">' +
                                '<span class="block ms-3 text-sm">status</span>' +
                                '<div class="flex flex-col justify-center">' +
                                    '<div class="border bg-white border-1 flex flex-row gap-2 items-center justify-center px-[.4em] py-[.3em] pe-[.5em] rounded-[1em] ">' +
                                    '<div class="w-4 h-4 bg-'+ statusColor +'-600 rounded-full"></div>' +
                                    '<p class="text-sm text-black">'+ tableStatus +'</p>' +
                                '</div>' +
                            '</div>' +
                        '</div>' +
                    '</button>' +
                '</li>'
            });
            document.querySelector("#table-list").innerHTML = innerTableList
            document.querySelector("#addTableBtn").addEventListener("click",async ()=>{
                const options = {
                    url: "http://localhost:4000/api/tables",
                    method: "POST",
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json;charset=UTF-8'
                    },
                };
                try{
                    const res = await axios(options)
                    const table = res.data
                    if(Object.keys(table).length){
                        tables = await getTables()
                    }else{
                        alert("insert fail")
                    }
                }catch(error){
                    console.log(error);
                }finally{
                    updateTable()
                }
            })
        }
        async function selectTable(tid){
            if(!window.orderId){
                window.location.href = "/orders"
            }
            const orderId = parseInt(window.orderId)
            let url = "http://localhost:4000/api/orders/"+orderId+"/tables/"+tid
            const options = {
                url: url,
                method: "PUT",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json;charset=UTF-8'
                },
            };
            try{
                const res = await axios(options)
                const resAction = await axios.get("http://localhost:4000/api/actions")
                const order = res.data
                const action = resAction.data
                let targetUrl
                if(action.action == "saveOrder"){
                    targetUrl = "/"
                }else{
                    targetUrl = "/orderdetail/" + order.orderId
                }
                window.location.href = targetUrl
            }catch(error){
                console.log(error);
                alert("Create order.");
            }
        }
        (async () => {
            const urlParams = new URLSearchParams(window.location.search);
            const orderId = urlParams.get('orderId') || null ;
            window.orderId = orderId
            tables = await getTables()
            updateTable()
        })();
    </script>

    </html>