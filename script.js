console.log("connected!");

let units = document.getElementsByName('units');

for (let unit of units) {
    if(unit.checked) {
        console.log(`Units: ${unit.value}`);
    }
}

units.forEach(units => units.addEventListener('change', function () {
    console.log(`Units: ${units.value}`);
}));



// var getSelectedValue = document.querySelector('input[name="units"]:checked');
// if(getSelectedValue != null) {
//     console.log("Radio button is selected");
// }
// else {
//     console.log("Nothing has been selected");
// }



// for (let i = 0; i < units.length; i++) {
//     console.log(units[i]);
// }



//console.log(`Units: ${units}`);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// var days = document.getElementsByName('day');

// for (let i of days) {

// if (i.checked) {
//     console.log(i.value);
//   }
// }


// function displayRadioValue() {
//     var ele = document.getElementsByName('gender');

//     for(i = 0; i < ele.length; i++) {
//         if(ele[i].checked)
//         document.getElementById("result").innerHTML
//                 = "Gender: "+ele[i].value;
//     }
// }

// <script>
// var radios = document.querySelectorAll('input[type=radio][name="contact"]');
// radios.forEach(radio => radio.addEventListener('change', () => alert(radio.value)));
// </script>

// function getCheckedValue( groupName ) {
//     var radios = document.getElementsByName( groupName );
//     for( i = 0; i < radios.length; i++ ) {
//         if( radios[i].checked ) {
//             return radios[i].value;
//         }
//     }
//     return null;
// }


// const btn = document.querySelector('#btn');
// // handle button click
// btn.onclick = function () {
//     const rbs = document.querySelectorAll('input[name="choice"]');
//     let selectedValue;
//     for (const rb of rbs) {
//         if (rb.checked) {
//             selectedValue = rb.value;
//             break;
//         }
//     }
//     alert(selectedValue);
// };