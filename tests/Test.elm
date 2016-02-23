import Task
import Console
import ElmTest exposing (..)
import Test.Line.InterpolationTest as InterpolationTest
import Test.Scale.LinearTest as ScaleLinearTest
import Test.Axis.SvgTest as AxisSvgTest
import Test.FloatExtraTest as FloatExtraTest
import Test.Scale.OrdinalPointsTests as OrdinalPointsTests

tests : Test
tests =
    suite "All Tests"
        [ InterpolationTest.tests
        , AxisSvgTest.tests
        , ScaleLinearTest.tests
        , FloatExtraTest.tests
        , OrdinalPointsTests.tests
        ]

port runner : Signal (Task.Task x ())
port runner =
    Console.run (consoleRunner tests)