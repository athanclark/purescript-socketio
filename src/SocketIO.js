"use strict";

exports.connectImpl = function(host) {
  return io(host);
};

exports.onImpl = function(socket,chan,run) {
  socket.on(chan, function(x) {run(x)();});
};

exports.emitImpl = function(socket,chan,x) {
  socket.emit(chan,x);
};
