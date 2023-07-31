# purescript-chameleon-transformers

Writing web views in with
[chameleon](https://github.com/thought2/purescript-chameleon) has a lot of
benefits. We can abstract away specifics of concrete frameworks. 
But also, similar to `mtl` style Monad Transformers, we can abstract away common abilities
we need to add to a specific HTML type.

- `Ctx` Similar to `ReaderT` but for `Chameleon` views. It allows to pass
  context to subviews without explicitly passing it as an argument.
- `OutMsg` Adds a the ability to trigger global messages from subviews.
- `Accum` Like WriterT but for `Chameleon` views.
  
## Examples
### Ctx

In this example we'rew using the `Ctx` transformer to implicitly pass a theme to a subview.


```hs
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
```