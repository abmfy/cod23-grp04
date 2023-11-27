import mill._, scalalib._

val spinalVersion = "1.9.4"

object cod extends SbtModule {
  def scalaVersion = "2.12.18"
  override def millSourcePath = os.pwd
  def sources = T.sources(
    millSourcePath / "spinal"
  )
  def ivyDeps = Agg(
    ivy"com.github.spinalhdl::spinalhdl-core:$spinalVersion",
    ivy"com.github.spinalhdl::spinalhdl-lib:$spinalVersion"
  )
  def scalacPluginIvyDeps = Agg(ivy"com.github.spinalhdl::spinalhdl-idsl-plugin:$spinalVersion")
  def mainClass = Some("cod.Generate")
}

def compile() = cod.run()
def c() = compile()

def run() = compile()
def r() = run()

val DEFAULT_TESTCASE = "cod.tb.Lab6"

def test(testcase: String = DEFAULT_TESTCASE) = cod.runMain(testcase)
def t(testcase: String = DEFAULT_TESTCASE) = test(testcase)
