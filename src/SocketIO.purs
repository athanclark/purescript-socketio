module SocketIO where

import Prelude
import Data.Function.Eff (EffFn1, runEffFn1, EffFn3, runEffFn3)
import Data.Foreign (Foreign)
import Control.Monad.Eff (Eff)


foreign import data SOCKETIO :: !
foreign import data Socket :: *

type Host = String
type Channel = String


foreign import connectImpl :: forall eff. EffFn1 (socketio :: SOCKETIO | eff) Host Socket

foreign import onImpl :: forall eff. EffFn3 (socketio :: SOCKETIO | eff) Socket Channel (forall eff. Foreign -> Eff (socketio :: SOCKETIO | eff) Unit) Unit

foreign import emitImpl :: forall eff. EffFn3 (socketio :: SOCKETIO | eff) Socket Channel String Unit


connect :: forall eff. Host -> Eff (socketio :: SOCKETIO | eff) Socket
connect = runEffFn1 connectImpl

on :: forall eff. Socket -> Channel -> (forall eff. Foreign -> Eff (socketio :: SOCKETIO | eff) Unit) -> Eff (socketio :: SOCKETIO | eff) Unit
on = runEffFn3 onImpl

emit :: forall eff. Socket -> Channel -> String -> Eff (socketio :: SOCKETIO | eff) Unit
emit = runEffFn3 emitImpl
