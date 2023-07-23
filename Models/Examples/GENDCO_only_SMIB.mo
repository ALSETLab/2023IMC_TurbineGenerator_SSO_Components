within TurbineGeneratorSSO.Examples;
model GENDCO_only_SMIB
  "SMIB system to test functionality of generator model with round rotor and quadratic saturation"
  extends OpenIPSL.Tests.BaseClasses.SMIB(SysData(S_b=892400000, fn=60));
  Components.Machines.GENDCO_standardbase  generator(
    Tpd0=5,
    Tppd0=0.07,
    Tpq0=0.9,
    Tppq0=0.09,
    D=0,
    Xd=1.84,
    Xq=1.75,
    Xpd=0.41,
    Xpq=0.6,
    Xppd=0.2,
    Xl=0.12,
    S10=0.11,
    S12=0.39,
    angle_0=0.070492225331847,
    Xppq=0.2,
    R_a=0,
    Xpp=0.2,
    H = 2.8301254,
    M_b=100000000,
    P_0=40000000,
    Q_0=5416582,
    v_0=1) annotation (Placement(transformation(extent={{-86,-20},{-46,20}})));
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
