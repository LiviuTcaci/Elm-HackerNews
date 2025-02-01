module View.Posts exposing (..)

import Html exposing (Html, a, div, input, label, option, select, table, td, text, th, tr)
import Html.Attributes exposing (checked, class, for, href, id, selected, title, type_, value)
import Html.Events exposing (onCheck, onInput)
import Model exposing (Msg(..))
import Model.Post exposing (Post)
import Model.PostsConfig exposing (Change(..), PostsConfig, SortBy(..), filterPosts, sortFromString, sortOptions, sortToCompareFn, sortToString)
import Time exposing (Posix)
import Util.Time exposing (durationBetween, formatDuration, formatTime)


{-| Show posts as a HTML [table](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/table)

Relevant local functions:

  - Util.Time.formatDate
  - Util.Time.formatTime
  - Util.Time.formatDuration (once implemented)
  - Util.Time.durationBetween (once implemented)

Relevant library functions:

  - [Html.table](https://package.elm-lang.org/packages/elm/html/latest/Html#table)
  - [Html.tr](https://package.elm-lang.org/packages/elm/html/latest/Html#tr)
  - [Html.th](https://package.elm-lang.org/packages/elm/html/latest/Html#th)
  - [Html.td](https://package.elm-lang.org/packages/elm/html/latest/Html#td)

-}
postTable : PostsConfig -> Posix -> List Post -> Html msg
postTable config currentTime posts =
    let
        header =
            tr []
                [ th [] [ text "Score" ]
                , th [] [ text "Title" ]
                , th [] [ text "Type" ]
                , th [] [ text "Posted" ]
                , th [] [ text "Link" ]
                ]

        row post =
            let
                relativeTime =
                    durationBetween post.time currentTime

                formattedTime =
                    Maybe.withDefault "N/A" (Maybe.map formatDuration relativeTime)
            in
            tr []
                [ td [ class "post-score" ] [ text (String.fromInt post.score) ]
                , td [ class "post-title" ] [ text post.title ]
                , td [ class "post-type" ] [ text post.type_ ]
                , td [ class "post-time", title (formatTime Time.utc post.time) ] [ text (formatTime Time.utc post.time ++ " (" ++ formattedTime ++ ")") ]
                , td [ class "post-url" ]
                    [ case post.url of
                        Just url ->
                            a [ href url ] [ text "Link" ]

                        Nothing ->
                            text "No URL"
                    ]
                ]

        body =
            List.map row (filterPosts config posts)
    in
    table []
        ([ header ] ++ body)


{-| Show the configuration options for the posts table

Relevant functions:

  - [Html.select](https://package.elm-lang.org/packages/elm/html/latest/Html#select)
  - [Html.option](https://package.elm-lang.org/packages/elm/html/latest/Html#option)
  - [Html.input](https://package.elm-lang.org/packages/elm/html/latest/Html#input)
  - [Html.Attributes.type\_](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#type_)
  - [Html.Attributes.checked](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#checked)
  - [Html.Attributes.selected](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#selected)
  - [Html.Events.onCheck](https://package.elm-lang.org/packages/elm/html/latest/Html-Events#onCheck)
  - [Html.Events.onInput](https://package.elm-lang.org/packages/elm/html/latest/Html-Events#onInput)

-}
postsConfigView : PostsConfig -> Html Msg
postsConfigView config =
    div []
        [ select
            [ id "select-posts-per-page"
            , onInput (\value -> ConfigChanged (ChangePostsToShow (Maybe.withDefault 10 (String.toInt value))))
            ]
            [ option [ value "10", selected (config.postsToShow == 10) ] [ text "10" ]
            , option [ value "25", selected (config.postsToShow == 25) ] [ text "25" ]
            , option [ value "50", selected (config.postsToShow == 50) ] [ text "50" ]
            ]
        , select
            [ id "select-sort-by"
            , onInput (\value -> ConfigChanged (ChangeSortBy (Maybe.withDefault None (sortFromString value))))
            ]
            (List.map
                (\sortOption ->
                    option
                        [ value (sortToString sortOption)
                        , selected (sortOption == config.sortBy)
                        ]
                        [ text (sortToString sortOption) ]
                )
                sortOptions
            )
        , div []
            [ input
                [ id "checkbox-show-job-posts"
                , type_ "checkbox"
                , checked config.showJobs
                , onCheck (\value -> ConfigChanged (ChangeShowJobs value))
                ]
                []
            , label [ for "checkbox-show-job-posts" ] [ text "Show job posts" ]
            ]
        , div []
            [ input
                [ id "checkbox-show-text-only-posts"
                , type_ "checkbox"
                , checked config.showTextOnly
                , onCheck (\value -> ConfigChanged (ChangeShowTextOnly value))
                ]
                []
            , label [ for "checkbox-show-text-only-posts" ] [ text "Show text-only posts" ]
            ]
        ]
