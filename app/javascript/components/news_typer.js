import Typed from 'typed.js';


const typedNews = () => {
    const { news } = document.getElementById('typed').dataset
    const { fixture } = document.getElementById('typed').dataset
    console.log(news);
    var options = {
        strings: ['Latest player news:', news, 'Next fixture:', fixture ],
        typeSpeed: 40,
        loop: true
    };
    
    var typed = new Typed('#typed', options);
}

export { typedNews };