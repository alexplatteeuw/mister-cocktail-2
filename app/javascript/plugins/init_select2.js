import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.select2').select2({ theme: "classic" }); // (~ document.querySelectorAll)
};

export { initSelect2 };
