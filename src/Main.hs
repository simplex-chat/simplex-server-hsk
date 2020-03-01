{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}
{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE DeriveAnyClass  #-}

module Main where

import Data.Aeson
import GHC.Generics
import Network.Wai
import Network.Wai.Handler.Warp
import Servant

type Base64EncodedString = String

data NewConnectionRequest = NewConnectionRequest
  { recipientKey :: Base64EncodedString
  } deriving (Show, Generic, FromJSON)

data NewConnectionResponse = NewConnectionResponse
  { recipientUri :: String
  , senderUri :: String
  } deriving (Show, Generic, ToJSON)


data User = User
  { userId        :: Int
  , userFirstName :: String
  , userLastName  :: String
  } deriving (Eq, Show, Generic, ToJSON)


type API = "users" :> Get '[JSON] [User]
      :<|> "connection" :> ReqBody '[JSON] NewConnectionRequest
                        :> Post '[JSON] NewConnectionResponse

startApp :: IO ()
startApp = run 8080 app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server = getUsers
    :<|> createConnection
    
  where
    getUsers :: Handler [User]
    getUsers = return users

    createConnection :: NewConnectionRequest -> Handler NewConnectionResponse
    createConnection NewConnectionRequest {recipientKey=_} =
      return NewConnectionResponse {recipientUri="", senderUri=""}

users :: [User]
users = [ User 1 "Isaac" "Newton"
        , User 2 "Albert" "Einstein"
        ]

main :: IO ()
main = startApp
