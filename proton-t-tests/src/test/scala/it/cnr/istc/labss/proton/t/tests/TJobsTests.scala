package it.cnr.istc.labss.proton.t.tests

import org.nlogo.headless.HeadlessWorkspace
import org.nlogo.core.LogoList
import org.nlogo.api.ScalaConversions.RichSeq

class TJobsTests extends TModelSuite {

 def setup4x300(ws: HeadlessWorkspace): Unit = {
    ws.cmd("""
      set num-communities 4
      set citizens-per-community 300
      setup
    """)
  }

  test("All mosques and community centers staffed") { ws =>
    setup4x300(ws)
    ws.rpt("""
      all? activities with [ 
        [ is-job? and (location-type = "community center"  or location-type = "mosque") ]  of my-activity-type 
      ] [ 
        any? activity-link-neighbors 
      ] 
      """) shouldBe true
  }

  test("Community workers preach to an effect") { ws =>
    setup4x300(ws)
    ws.cmd("""
      repeat 24 * 3 + 22 [ go ] ; 10PM on the tenth day
      ask n-of 
        count locations with [ shape = "community center" ] 
        citizens with [
          [ shape ] of locations-here != [ "community center" ] 
        ] [
          move-to one-of locations with [ shape = "community center" ] 
        ]
    """)
    val meanInstDist = """
      mean [ value ] of link-set [
        out-topic-link-to ( one-of topics with [ topic-name = "Institutional distrust" ]) 
      ] of (citizens-on locations with [ shape = "community center"]) with [
        [ not (is-job? and location-type = "community center") ] of [ my-activity-type ] of current-activity 
      ]
    """
    val before = ws.rpt(meanInstDist).asInstanceOf[Number].floatValue    
    ws.cmd("""
      repeat 100 [ 
        ask citizens with [ 
          [ is-job? and location-type = "community center" ] of [ my-activity-type ] of current-activity 
        ] [ preach ]
        ]
      """)
    val after = ws.rpt(meanInstDist).asInstanceOf[Number].floatValue
    after - before < 0 shouldBe true
  }

  test("Imams preach to an effect") { ws =>
    setup4x300(ws)
    ws.cmd("""
      repeat 24 * 3 + 22 [ go ] ; 10PM on the tenth day
      ask n-of 
        count locations with [ shape = "mosque" ] 
        citizens with [
          [ shape ] of locations-here != [ "mosque" ] 
        ] [
          move-to one-of locations with [ shape = "mosque" ] 
        ]    
    """)
    val meanInstDist = """
      mean [ value ] of link-set [
        out-topic-link-to ( one-of topics with [ topic-name = "Institutional distrust" ]) 
      ] of (citizens-on locations with [ shape = "mosque"]) with [
        [ not (is-job? and location-type = "mosque") ] of [ my-activity-type ] of current-activity 
      ]
    """
    val before = ws.rpt(meanInstDist).asInstanceOf[Number].floatValue    
    ws.cmd("""
      repeat 100 [ 
        ask citizens with [ 
          [ is-job? and location-type = "mosque" ] of [ my-activity-type ] of current-activity 
        ] [ preach ]
        ]
      """)
    val after = ws.rpt(meanInstDist).asInstanceOf[Number].floatValue
    after - before > 0 shouldBe true
  }

  test("citizens in workplace are working") { ws =>
    setup4x300(ws)
    1 to 500 foreach { _ => 
      ws.cmd("go")
      ws.rpt("""
        count citizens with [ any? out-activity-link-neighbors with [ 
          [ is-mandatory? ] of my-activity-type and 
          [ current-activity] of myself = self] 
        ] -
        count citizens with  [ [ [is-mandatory? ] of my-activity-type ] of current-activity ]
      """) shouldBe 0 
      ws.rpt("""
        all? citizens with [ any? locations-here with [ shape = "workplace" ] ] [ 
          [ [ location-type ] of my-activity-type ] of current-activity = "workplace" ]
        """) shouldBe true  
    }
  }
}