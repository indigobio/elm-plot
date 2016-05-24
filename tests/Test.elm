module Main exposing (..)

import ElmTest exposing (..)
import Test.Plot.InterpolationTest
import Test.Private.Axis.ViewTest
import Test.Private.Axis.TicksTest
import Test.Private.Axis.TitleTest
import Test.Private.Scale.LinearTest
import Test.Private.Extras.IntervalTest
import Test.Private.Extras.FloatTest
import Test.Private.Scale.OrdinalBandsTest
import Test.Private.BarsTest
import Test.Private.BoundingBoxTest
import Test.Private.Scale.UtilsTest
import Test.Private.PointsTest


-- TODO autogenerate this file


tests : Test
tests =
    suite "All Tests"
        [ Test.Plot.InterpolationTest.tests
        , Test.Private.Axis.TicksTest.tests
        , Test.Private.Axis.TitleTest.tests
        , Test.Private.Axis.ViewTest.tests
        , Test.Private.Extras.FloatTest.tests
        , Test.Private.Scale.LinearTest.tests
        , Test.Private.Scale.OrdinalBandsTest.tests
        , Test.Private.BarsTest.tests
        , Test.Private.BoundingBoxTest.tests
        , Test.Private.Extras.IntervalTest.tests
        , Test.Private.Scale.UtilsTest.tests
        , Test.Private.PointsTest.tests
        ]


main =
    runSuiteHtml tests
