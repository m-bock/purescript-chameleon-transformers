
{-
# purescript-chameleon-transformers

## Examples
### Ctx
-}

module Demo.SampleReadme where

import Prelude

import Chameleon (class Html)
import Chameleon as C
import Chameleon.Impl.TestHtml (TestHtml)
import Chameleon.Transformers.Ctx.Class (class Ctx, withCtx)
import Chameleon.Transformers.Ctx.Trans (CtxT, runCtxT)

type MyCtx =
  { theme :: String
  }

viewSub
  :: forall html msg
   . Html html
  => Ctx MyCtx html
  => html msg
viewSub =
  withCtx \myCtx ->
    C.text ("Hello, " <> myCtx.theme)

viewMain
  :: forall html msg
   . Html html
  => Ctx MyCtx html
  => html msg
viewMain =
  C.div_
    [ C.text "Hello!"
    , viewSub
    ]

type MyHTML msg = CtxT MyCtx TestHtml msg

result :: forall msg. MyHTML msg
result = runCtxT viewMain { theme: "dark" }