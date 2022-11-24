 {-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import NumericalMethods
import Language.Haskell.Interpreter
import Data.Text(pack, unpack, replace)
import System.Exit

replaceEuler :: String -> String
replaceEuler = unpack . replace "e" "(exp 1)" . pack

main :: IO ()
main = do
    putStrLn "CALCULADORA DE INTEGRAL"
    putStrLn "Escolha um método para calcular sua integral:"
    putStrLn "0    <- Método do trapézio"
    putStrLn "1    <- Método do trapézio composto"
    putStrLn "2    <- Sair"

    c <- getChar
    case c of
        '0' -> return ()
        '1' -> putChar '\n' >> putStrLn "Hello World"
        '2' -> putChar '\n' >> putStrLn "Saindo..." >> exitSuccess

    putStrLn "-------------------"



    let fExpr =   "let f x = " ++ replaceEuler "e * x**2 in f"

    r <- runInterpreter $ do
            setImports ["Prelude"]
            interpret fExpr (as :: Double -> Double)

    case r of
        Left err -> putStrLn $ "Erro no parse... " ++ (show err)
        Right f  -> do
            putStr "Resultado: "
            putStr  (show (compositeTrapeizoidal 1 7 10000 f)) >> putChar '\n'
            putStrLn "-------------------"
            
    main
