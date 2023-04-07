{-# LANGUAGE InstanceSigs #-}
module Main where
import Control.Monad.Cont
import Control.Applicative

main :: IO ()
main = putStrLn ""


-- Fun little exercise trying to understand monad transformers

newtype MaybeT m a = MaybeT { runMaybeT :: m (Maybe a) }

instance (Functor m) => Functor (MaybeT m) where
    fmap f (MaybeT mma) = MaybeT $ (fmap . fmap) f mma

instance (Applicative m) => Applicative (MaybeT m) where
    pure x = MaybeT $ pure (Just x) 
    (MaybeT mf) <*> (MaybeT mx) = MaybeT $ (<*>) <$> mf <*> mx

instance (Monad m) => Monad (MaybeT m) where
    return = MaybeT . return . Just

    x >>= f = MaybeT $ do
        v <- runMaybeT x
        case v of
            Nothing -> return Nothing
            Just y -> runMaybeT (f y)

instance MonadTrans MaybeT where
    lift :: (Monad m) => m a -> MaybeT m a
    lift m = MaybeT $ fmap Just m

instance (Alternative m) => Alternative (MaybeT m) where
    empty = MaybeT $ pure Nothing
    (MaybeT ma) <|> (MaybeT mb) = MaybeT $ ma <|> mb
