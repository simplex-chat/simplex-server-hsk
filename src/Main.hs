{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}

module Main where

import Data.Aeson
import Data.Aeson.TH
import Data.ByteString
import Network.Wai
import Network.Wai.Handler.Warp
import Servant

data Connection
  = NewConnReq
  { recipientKey :: ByteString
  }
  | NewConn
  { recipientUri :: String
  , senderUri :: String
  }

-- data Connection = Connection
--   { recipientId :: Word16
--   , senderId :: Word16
--   , recipientKey :: ByteString
--   , senderKey :: ByteString
--   } deriving (Eq, Show, Generic)

-- instance ToJSON Connection

-- type API = "connection" :> Post '[JSON] [Connection]

data User = User
  { userId        :: Int
  , userFirstName :: String
  , userLastName  :: String
  } deriving (Eq, Show)

-- instance ToJSON User
$(deriveJSON defaultOptions ''User)

type API = "users" :> Get '[JSON] [User]
      :<|> "connection" :> ReqBody '[JSON] Connection :> Post '[JSON] Connection

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
    getUsers :: () -> [User]
    getUsers = return users

    createConnection :: Connection -> Connection
    createConnection NewConnReq {recipientKey=rk} =
      return NewConn {recipientUri="", senderUri=""}

users :: [User]
users = [ User 1 "Isaac" "Newton"
        , User 2 "Albert" "Einstein"
        ]

main :: IO ()
main = startApp
