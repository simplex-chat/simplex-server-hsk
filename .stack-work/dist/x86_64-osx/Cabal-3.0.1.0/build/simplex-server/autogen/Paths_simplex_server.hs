{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_simplex_server (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/evgeny/Documents/opensource/simplex-server/.stack-work/install/x86_64-osx/7948e568b39635598154e102080b95f1ba07b9e75a6bf5fe00eca576eae665a7/8.8.2/bin"
libdir     = "/Users/evgeny/Documents/opensource/simplex-server/.stack-work/install/x86_64-osx/7948e568b39635598154e102080b95f1ba07b9e75a6bf5fe00eca576eae665a7/8.8.2/lib/x86_64-osx-ghc-8.8.2/simplex-server-0.1.0.0-H3dho2jthDdERJath1NDVD-simplex-server"
dynlibdir  = "/Users/evgeny/Documents/opensource/simplex-server/.stack-work/install/x86_64-osx/7948e568b39635598154e102080b95f1ba07b9e75a6bf5fe00eca576eae665a7/8.8.2/lib/x86_64-osx-ghc-8.8.2"
datadir    = "/Users/evgeny/Documents/opensource/simplex-server/.stack-work/install/x86_64-osx/7948e568b39635598154e102080b95f1ba07b9e75a6bf5fe00eca576eae665a7/8.8.2/share/x86_64-osx-ghc-8.8.2/simplex-server-0.1.0.0"
libexecdir = "/Users/evgeny/Documents/opensource/simplex-server/.stack-work/install/x86_64-osx/7948e568b39635598154e102080b95f1ba07b9e75a6bf5fe00eca576eae665a7/8.8.2/libexec/x86_64-osx-ghc-8.8.2/simplex-server-0.1.0.0"
sysconfdir = "/Users/evgeny/Documents/opensource/simplex-server/.stack-work/install/x86_64-osx/7948e568b39635598154e102080b95f1ba07b9e75a6bf5fe00eca576eae665a7/8.8.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "simplex_server_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "simplex_server_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "simplex_server_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "simplex_server_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "simplex_server_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "simplex_server_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
