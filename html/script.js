var logo = document.createElement('img')
var vehiclenamedisplay = document.createElement('h1');

$(function () {
  const originalCarDisplay = document.getElementById('car-display').innerHTML;
  function display(bool) {
    if (bool) {
      $('.tablet').css('display', 'flex');
    } else {
      $('.tablet').css('display', 'none');
      document.getElementById('car-display').innerHTML = originalCarDisplay;
    }
  }
  $('.car-button').removeClass('active');
  display(false);

  let carDetails = {}
  let carId = undefined

  window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.type === "ui") {
        if (item.status == true) {
          $('.car-list').empty();
          for(let i = 0; i < item.vehicles.length; i++){
            var vehicle = item.vehicles[i]
            carDetails[i] = vehicle
            html = `
            <li><button class="car-button" data-car-id=${i}>${vehicle.name}</button></li>
            `
           $('.car-list').append(html);
          }
          document.getElementsByClassName('person')[0].innerHTML = item.name;
    
          document.getElementsByClassName('welcometext')[0].innerHTML = item.garagename;

          const startlogo = document.getElementsByClassName('startlogo')[0];
          startlogo.src = item.logo;

          logo.src = item.logo;

            display(true)
        } else {
            display(false)
        }
    }
})

document.onkeyup = function(data) {
  if (data.which == 27) {
      $.post("http://sl-jobvehicles/exit", JSON.stringify({}));
      return
  }
};

  $('.car-list').on('click', '.car-button', function() {
    var car = $(this).data('car-id');
    $('.car-button').removeClass('active');
    displayCar(car);
    carId = car
    $(this).addClass('active');
  });
  const tablet = document.querySelector('.tablet');

  document.getElementById('cashButton').addEventListener('click', function() {
    $.post("http://sl-jobvehicles/buyvehicle", JSON.stringify({method:"cash", id:carId + 1}))
    document.getElementById('purchaseBox').style.display = 'none';
    tablet.classList.remove('blurred');
  });
  
  document.getElementById('cardButton').addEventListener('click', function() {
    $.post("http://sl-jobvehicles/buyvehicle", JSON.stringify({method:"bank", id:carId + 1}))
    document.getElementById('purchaseBox').style.display = 'none';
    tablet.classList.remove('blurred');
  });

  function displayCar(car) {
    const carDisplay = document.getElementById('car-display');
  
    carDisplay.innerHTML = '';
  
    logo.classList.add('logo');
  
    const carImage = document.createElement('img');
    carImage.src = carDetails[car].image;
    carImage.alt = car;

    vehiclenamedisplay.textContent = carDetails[car].name;

    vehiclenamedisplay.classList.add('vehiclename');

    const priceTag = document.createElement('p');
    priceTag.textContent = 'Price: $' + carDetails[car].price.toLocaleString();
    priceTag.classList.add('price-tag');
  
    const buyButton = document.createElement('button');
    buyButton.textContent = 'Buy Now';
    buyButton.classList.add('buy-button');
      
    buyButton.addEventListener('click', function() {
      document.getElementById('purchaseBox').style.display = 'block';
      tablet.classList.add('blurred');
    });
  
    document.getElementById('closemethods').addEventListener('click', function() {
      document.getElementById('purchaseBox').style.display = 'none';
      tablet.classList.remove('blurred');
    });

    carDisplay.appendChild(vehiclenamedisplay)
    carDisplay.appendChild(logo);
    carDisplay.appendChild(carImage);
    carDisplay.appendChild(priceTag);
    carDisplay.appendChild(buyButton);
  
    carImage.style.opacity = 0,5; // Set initial opacity to 0
    logo.style.opacity = 0.5

    // Apply animation effect using setTimeout to ensure transition after the content change
    setTimeout(() => {
      carImage.style.transition = 'opacity 0.5s ease'; // Opacity transition only
      logo.style.transition = 'opacity 0.5s ease';
      logo.style.opacity = 1
      carImage.style.opacity = 1;
    }, 50); // Adjust the delay as needed
  }
  function updateTime() {
    const timeElement = document.getElementById('time');

    if (timeElement) {
      var currentTime = new Date();
      var hours = currentTime.getHours();
      var minutes = currentTime.getMinutes();
  
      minutes = (minutes < 10 ? '0' : '') + minutes;
  
      var formattedTime = hours + ':' + minutes;
  
      timeElement.textContent = formattedTime;
  }
}

  updateTime();

  setInterval(updateTime, 1000);
});
