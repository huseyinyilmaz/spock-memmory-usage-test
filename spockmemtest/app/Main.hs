{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Spock
import Web.Spock.Config

import Control.Monad.Trans
import Data.Monoid
import qualified Data.Text as T

data MySession = EmptySession
data MyAppState = DummyAppState

main :: IO ()
main =
    do spockCfg <- defaultSpockCfg EmptySession PCNoDatabase (DummyAppState)
       runSpock 8080 (spock spockCfg app)

app :: SpockM () MySession MyAppState ()
app =
    do get root $
           text "Hello World!"
       get ("hello" <//> var) $ \name -> text ("Hello " <> name)
