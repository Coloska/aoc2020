const fs = require('fs');
const input = require('./aocD3.input')

// Deprecated by v2 functions
const day3 = () => {
    const rowLenght = input[0].length;
    let counter = 0;
    input.forEach((row, index) => {
        let horizontalCheck = ((index % rowLenght) * 3) % rowLenght;
        (input[index].split('')[horizontalCheck] === '#') ? counter++ : false;
    })
    return counter;
}

const day3v2 = (horizontalHop, verticalHop) => {
    const rowLenght = input[0].length;
    let counter = 0;
    input.forEach((row, index) => {
        let verticalCheck = index * verticalHop;
        let horizontalCheck = ((index % rowLenght) * horizontalHop) % rowLenght;
        if (verticalCheck <= input.length && horizontalCheck <= row.length) {
            (input[verticalCheck].split('')[horizontalCheck] === '#') ? counter++ : false;
        }
    })
    return counter;
}

console.log(day3v2(3,1));
console.log(day3v2(1,1) * day3v2(3,1) * day3v2(5,1) * day3v2(7,1) * day3v2(1,2))
