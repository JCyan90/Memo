$(() => {
  const search = () => {
    const action = 'http://localhost:8080/posts' + document.getElementsByName("keyword")[0].value;
    const form = document.getElementById('formSearch');
    form.action = action;
  }
});
