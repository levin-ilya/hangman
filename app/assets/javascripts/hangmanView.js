/**
 * Created by Ilya on 4/12/14.
 */

zenBuilder.HangmanView = {
  init: function () {
      //setup view
      $("#alphabet > div").click(this.guessLetter);

  },
  updateView: function (data,letter){
      var letterSelector = "#" + letter;
      var status =  data.status
      $("#maskedWord")[0].innerText = data.maskedWord
      $("#movesleft")[0].innerText = data.movesLeft;

      // update Image
      $("#hangmanImage")[0].src = "/assets/" + data.movesLeft + ".png";

      // remove listener
      $(letterSelector).unbind("click");
      $(letterSelector).css("color:gray");
      if(status=="winner"){
          $('#winnerDisplay').foundation('reveal', 'open');
      }else if(status=="lost"){
          $('#lostDisplay').foundation('reveal', 'open');
      }
  },
  guessLetter: function (data){
      zenBuilder.HangmanProxy.guessLetter(data.currentTarget.id);
  }
};