const fs = require('fs');
const input = require('./aocD2.input')

const day2 = () => {
    let index = 0;
    input.forEach((element) => {
        let count = (element[3].match(new RegExp(element[2], "g")) || []).length;
        (count >= element[0] && count <= element[1]) ? index++ : false;
    })
    return index;
}

const day2v2 = () => {
    let index = 0;
    input.forEach((row) => {
        let password = row[3].split("")
        !((password[parseInt(row[0])-1] === row[2]) === (password[parseInt(row[1])-1] === row[2])) ? index++ : false;
        // let characterOne = password[parseInt(row[0])-1];
        // let characterTwo = password[parseInt(row[1])-1];
        // let charOneTest = password[parseInt(row[0])-1] === row[2];
        // let charTwoTest = password[parseInt(row[1])-1] === row[2]
        // !(charOneTest === charTwoTest) ? index = index + 1 : false;
    })
    return index;
}

day2v2();
