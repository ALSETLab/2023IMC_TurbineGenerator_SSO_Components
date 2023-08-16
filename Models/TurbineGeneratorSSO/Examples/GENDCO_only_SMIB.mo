within TurbineGeneratorSSO.Examples;
model GENDCO_only_SMIB
  "SMIB system to test functionality of GENDCO generator model"
  extends OpenIPSL.Tests.BaseClasses.SMIB(SysData(S_b=100000000, fn=60));
    //H=4.28,
equation
  connect(generator.PMECH, generator.PMECH0) annotation (Line(points={{-90,12},
          {-100,12},{-100,26},{-42,26},{-42,10},{-44,10}}, color={0,0,127}));
  connect(generator.EFD, generator.EFD0) annotation (Line(points={{-90,-12},{
          -100,-12},{-100,-30},{-42,-30},{-42,-10},{-44,-10}}, color={0,0,127}));
  connect(generator.p, GEN1.p)
    annotation (Line(points={{-46,0},{-30,0}}, color={0,0,255}));
  annotation (experiment(
      StopTime=30,
      Interval=0.0004,
      __Dymola_Algorithm="Rkfix4"));
end GENDCO_only_SMIB;
